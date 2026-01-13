import 'package:bodyflow/data/repos/workout_repo.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GeneratorPageViewModel with ChangeNotifier {
  final WorkoutRepo _workoutRepo;

  GeneratorPageViewModel({required WorkoutRepo workoutRepo})
    : _workoutRepo = workoutRepo;

  final timeController = TextEditingController.fromValue(
    const TextEditingValue(
      text: '30',
      selection: TextSelection.collapsed(offset: 2),
    ),
  );

  final weekController = TextEditingController.fromValue(
    const TextEditingValue(
      text: '1',
      selection: TextSelection.collapsed(offset: 1),
    ),
  );

  bool _isGenerating = false;

  bool get isGenerating => _isGenerating;

  final List<BodyPart> _selectedBodyParts = [];
  final List<Days> _selectedDays = [];

  ActivityType _activityType = ActivityType.session;

  int _sessionLengthInMinutes = 30;
  int _numberOfWeeks = 1;

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

  void setNumberOfWeeks(int weeks) {
    _numberOfWeeks = weeks;
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

    setIsGenerating(true);

    try {
      if (_activityType == ActivityType.session) {
        final workout = await _workoutRepo.generateWorkoutSession(
          _selectedBodyParts,
          _sessionLengthInMinutes,
        );
        setIsGenerating(false);
        _showWorkoutSessionResult(context, workout);
        return;
      } else {
        _workoutRepo.generateWorkoutSchedule(
          bodyParts: _selectedBodyParts,
          days: _selectedDays,
          numberOfWeeks: _numberOfWeeks,
        );
      }
      setIsGenerating(false);
    } catch (e) {
      setIsGenerating(false);
      // Log the actual error for debugging
      debugPrint('Workout generation error: $e');
      _showValidationError(
        context,
        'Generation Failed',
        'Unable to generate workout at this time. Please check your internet connection and try again.',
      );
    }
  }

  void _showWorkoutSessionResult(BuildContext context, Session session) {
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: Text(workout.name),
    //     content: SingleChildScrollView(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(
    //             workout.description,
    //             style: const TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           const SizedBox(height: 8),
    //           if (workout.durationMinutes != null)
    //             Text('Duration: ${workout.durationMinutes} minutes'),
    //           const SizedBox(height: 16),
    //           if (workout.exercises != null &&
    //               workout.exercises!.isNotEmpty) ...[
    //             const Text(
    //               'Exercises:',
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             const SizedBox(height: 8),
    //             ...workout.exercises!.map(
    //               (exercise) => Padding(
    //                 padding: const EdgeInsets.only(bottom: 12.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       exercise.name,
    //                       style: const TextStyle(fontWeight: FontWeight.w600),
    //                     ),
    //                     if (exercise.sets != null && exercise.reps != null)
    //                       Text('${exercise.sets} sets × ${exercise.reps} reps'),
    //                     if (exercise.instructions != null)
    //                       Text(
    //                         exercise.instructions!,
    //                         style: const TextStyle(fontSize: 12),
    //                       ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ],
    //       ),
    //     ),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(),
    //         child: const Text('Close'),
    //       ),
    //     ],
    //   ),
    // );

    context.push(Routes.session, extra: session);
  }

  void _showWorkoutScheduleResult(
    BuildContext context,
    Map<Days, Session> schedule,
  ) {
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Weekly Schedule'),
    //     content: SingleChildScrollView(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.min,
    //         children: schedule.entries.map((entry) {
    //           final dayName = _getDayName(entry.key);
    //           final workout = entry.value;
    //           return Padding(
    //             padding: const EdgeInsets.only(bottom: 16.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   dayName,
    //                   style: const TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 16,
    //                   ),
    //                 ),
    //                 Text(workout.name),
    //                 Text(
    //                   workout.description,
    //                   style: const TextStyle(fontSize: 12),
    //                 ),
    //                 if (workout.durationMinutes != null)
    //                   Text(
    //                     'Duration: ${workout.durationMinutes} min',
    //                     style: const TextStyle(fontSize: 12),
    //                   ),
    //               ],
    //             ),
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //     actions: [
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(),
    //         child: const Text('Close'),
    //       ),
    //     ],
    //   ),
    // );
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
