import 'package:bodyflow/data/services/ai_workout_service.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/workout.dart';
import 'package:flutter/material.dart';

class GeneratorPageViewModel with ChangeNotifier {
  final AiWorkoutService? _aiService;
  
  GeneratorPageViewModel({AiWorkoutService? aiService})
      : _aiService = aiService;
  
  final timeController = TextEditingController.fromValue(
    const TextEditingValue(
      text: '30',
      selection: TextSelection.collapsed(offset: 2),
    ),
  );
  bool _isGenerating = false;

  bool get isGenerating => _isGenerating;

  final List<BodyPart> _selectedBodyParts = [];
  final List<Days> _selectedDays = [];

  ActivityType _activityType = ActivityType.session;

  int _sessionLengthInMinutes = 30;

  int get sessionLengthInMinutes => _sessionLengthInMinutes;

  ActivityType get activityType => _activityType;

  List<BodyPart> get selectedBodyParts => _selectedBodyParts;
  List<Days> get selectedDays => _selectedDays;

  void setActivityAsSession() {
    if (_activityType == ActivityType.session) return;
    _activityType = ActivityType.session;
    clearSelections();
  }

  void clearSelections() {
    _selectedBodyParts.clear();
    _selectedDays.clear();
    notifyListeners();
  }

  void setActivityAsSchedule() {
    if (_activityType == ActivityType.schedule) return;
    _activityType = ActivityType.schedule;
    clearSelections();
  }

  void setSessionLength(int minutes) {
    _sessionLengthInMinutes = minutes;
    notifyListeners();
  }

  void setIsGenerating(bool value) {
    _isGenerating = value;
    notifyListeners();
  }

  void addOrRemoveBodyPart(BodyPart bodyPart) {
    if (_selectedBodyParts.contains(bodyPart)) {
      _selectedBodyParts.remove(bodyPart);
    } else {
      _selectedBodyParts.add(bodyPart);
    }
    notifyListeners();
  }

  void addOrRemoveDay(Days day) {
    if (_selectedDays.contains(day)) {
      _selectedDays.remove(day);
    } else {
      _selectedDays.add(day);
    }
    notifyListeners();
  }

  void showGetALifeMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Get a life!'),
        content: const Text(
          'More than 2 hour workout? You should really get a life outside of the gym.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              timeController.text = '120';
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> generateWorkout(BuildContext context) async {
    // Validate selections based on activity type
    if (_selectedBodyParts.isEmpty) {
      _showValidationError(
        context,
        'No body parts selected',
        'Please select at least one body part to generate a workout.',
      );
      return;
    }
    
    if (_activityType == ActivityType.schedule && _selectedDays.isEmpty) {
      _showValidationError(
        context,
        'No days selected',
        'Please select at least one day for your schedule.',
      );
      return;
    }
    
    if (_activityType == ActivityType.session) {
      final minutes = int.tryParse(timeController.text) ?? 0;
      if (minutes <= 0) {
        _showValidationError(
          context,
          'Invalid duration',
          'Please enter a valid session length greater than 0 minutes.',
        );
        return;
      }
      _sessionLengthInMinutes = minutes;
    }
    
    // Check if AI service is available
    if (_aiService == null) {
      _showValidationError(
        context,
        'AI Service Not Available',
        'Please configure the Gemini API key to use AI-powered workout generation.',
      );
      return;
    }
    
    setIsGenerating(true);
    
    try {
      if (_activityType == ActivityType.session) {
        // Generate a single workout
        final workout = await _aiService!.generateWorkout(
          bodyParts: _selectedBodyParts,
          durationMinutes: _sessionLengthInMinutes,
        );
        
        setIsGenerating(false);
        _showWorkoutResult(context, workout);
      } else {
        // Generate a schedule
        final schedule = await _aiService!.generateSchedule(
          bodyParts: _selectedBodyParts,
          days: _selectedDays,
        );
        
        setIsGenerating(false);
        _showScheduleResult(context, schedule);
      }
    } catch (e) {
      setIsGenerating(false);
      _showValidationError(
        context,
        'Generation Failed',
        'Failed to generate workout: ${e.toString()}',
      );
    }
  }

  void _showWorkoutResult(BuildContext context, Workout workout) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(workout.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                workout.description,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (workout.durationMinutes != null)
                Text('Duration: ${workout.durationMinutes} minutes'),
              const SizedBox(height: 16),
              if (workout.exercises != null && workout.exercises!.isNotEmpty) ...[
                const Text(
                  'Exercises:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...workout.exercises!.map((exercise) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          if (exercise.sets != null && exercise.reps != null)
                            Text('${exercise.sets} sets × ${exercise.reps} reps'),
                          if (exercise.instructions != null)
                            Text(
                              exercise.instructions!,
                              style: const TextStyle(fontSize: 12),
                            ),
                        ],
                      ),
                    )),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showScheduleResult(
    BuildContext context,
    Map<Days, Workout> schedule,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Weekly Schedule'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: schedule.entries.map((entry) {
              final dayName = _getDayName(entry.key);
              final workout = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(workout.name),
                    Text(
                      workout.description,
                      style: const TextStyle(fontSize: 12),
                    ),
                    if (workout.durationMinutes != null)
                      Text(
                        'Duration: ${workout.durationMinutes} min',
                        style: const TextStyle(fontSize: 12),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _getDayName(Days day) {
    switch (day) {
      case Days.monday:
        return 'Monday';
      case Days.tuesday:
        return 'Tuesday';
      case Days.wednesday:
        return 'Wednesday';
      case Days.thursday:
        return 'Thursday';
      case Days.friday:
        return 'Friday';
      case Days.saturday:
        return 'Saturday';
      case Days.sunday:
        return 'Sunday';
    }
  }

  void _showValidationError(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }
}
