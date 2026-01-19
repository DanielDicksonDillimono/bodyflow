import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:flutter/material.dart';

class ScheduleViewModel with ChangeNotifier {
  // Add properties and methods to manage the schedule state
  final Schedule _schedule;
  int _currentWeekIndex = 0;

  ScheduleViewModel({required Schedule schedule}) : _schedule = schedule;

  Schedule get schedule => _schedule;
  int get currentWeekIndex => _currentWeekIndex;

  void goToNextWeek() {
    if (_currentWeekIndex < _schedule.weeks.length - 1) {
      _currentWeekIndex++;
      notifyListeners();
    }
  }

  void goToPreviousWeek() {
    if (_currentWeekIndex > 0) {
      _currentWeekIndex--;
      notifyListeners();
    }
  }

  List<Map<Days, Session>> getSessionsForWeek() {
    List<Map<Days, Session>> sessions = [];

    for (var dayMap in _schedule.weeks[_currentWeekIndex]) {
      dayMap.forEach((day, session) {
        sessions.add({day: session});
      });
    }
    return sessions;
  }
}
