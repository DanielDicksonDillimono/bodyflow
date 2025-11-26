import 'package:flutter/material.dart';

enum ActivityType { session, schedule }

class GeneratorPageViewModel with ChangeNotifier {
  GlobalKey<FormState> timeKey = GlobalKey<FormState>();
  final timeController = TextEditingController.fromValue(
    TextEditingValue(text: '30', selection: TextSelection.collapsed(offset: 2)),
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
    // notifyListeners();
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
    // notifyListeners();
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
        title: Text('Get a life!'),
        content: Text(
          'More than 2 hour workout? You should really get a life outside of the gym.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              timeController.text = '120';
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> generateWorkout() async {
    setIsGenerating(true);
    // Simulate workout generation delay
    await Future.delayed(const Duration(seconds: 2));
    setIsGenerating(false);
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }
}

enum BodyPart {
  fullBody,
  upperBody,
  lowerBody,
  arms,
  legs,
  back,
  chest,
  shoulders,
  core,
}

enum Days { monday, tuesday, wednesday, thursday, friday, saturday, sunday }
