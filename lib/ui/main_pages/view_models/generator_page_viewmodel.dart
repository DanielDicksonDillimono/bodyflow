import 'package:flutter/material.dart';

enum ActivityType { session, schedule }

class GeneratorPageViewModel with ChangeNotifier {
  bool _isGenerating = false;

  bool get isGenerating => _isGenerating;

  List<BodyPart> selectedBodyParts = [];
  List<Days> selectedDays = [];

  ActivityType activityType = ActivityType.session;

  void setActivityAsSession() {
    if (activityType == ActivityType.session) return;
    activityType = ActivityType.session;
    notifyListeners();
  }

  void setActivityAsSchedule() {
    if (activityType == ActivityType.schedule) return;
    activityType = ActivityType.schedule;
    notifyListeners();
  }

  void setIsGenerating(bool value) {
    _isGenerating = value;
    notifyListeners();
  }

  void addOrRemoveBodyPart(BodyPart bodyPart) {
    if (selectedBodyParts.contains(bodyPart)) {
      selectedBodyParts.remove(bodyPart);
    } else {
      selectedBodyParts.add(bodyPart);
    }
    notifyListeners();
  }

  void addOrRemoveDay(Days day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    notifyListeners();
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
