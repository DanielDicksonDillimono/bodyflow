import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:flutter/material.dart';

class GeneratorPageViewModel with ChangeNotifier {
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
    
    setIsGenerating(true);
    // Simulate workout generation delay
    await Future.delayed(const Duration(seconds: 2));
    setIsGenerating(false);
    
    // TODO: Implement actual workout generation logic
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
