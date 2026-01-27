import 'package:bodyflow/data/repos/workout_repo.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScheduleViewModel with ChangeNotifier {
  // Add properties and methods to manage the schedule state
  final Schedule _schedule;
  final WorkoutRepo _repo;
  int _currentWeekIndex = 0;

  ScheduleViewModel({required Schedule schedule, required WorkoutRepo repo})
    : _schedule = schedule,
      _repo = repo;

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

  Future<void> deleteSchedule(BuildContext context) async {
    final localization = AppLocalization.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localization.deleteSchedule),
          content: Text(localization.deleteScheduleConfirmation),
          actions: [
            TextButton(
              onPressed: () async {
                await _repo.deleteSchedule(_schedule.id);
                if (context.mounted) context.go(Routes.home);
              },
              child: Text(localization.delete, style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                if (context.mounted) context.pop();
              },
              child: Text(localization.cancel),
            ),
          ],
        );
      },
    );
  }
}
