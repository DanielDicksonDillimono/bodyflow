import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/session.dart';

/// Model representing a workout schedule comprising multiple sessions.
/// A schedule is structured into various sessions which correspond to different days.
/// Each schedule contains a name, description, and a list of weeks.
/// Each week is represented as a list of maps, where each map associates days of the week.
class Schedule {
  final String name;
  final String description;
  final List<List<Map<Days, Session>>> weeks;
  Schedule({
    required this.name,
    required this.weeks,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'weeks': weeks.map((week) {
        final Map<String, Map<String, dynamic>> daysMap = {};
        for (final day in week) {
          final dayKey = day.keys.first.toString().split('.').last;
          daysMap[dayKey] = day.values.first.toMap();
        }
        return daysMap;
      }).toList(),
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      name: map['name'],
      description: map['description'],
      weeks:
          map['weeks']?.map<List<Map<Days, Session>>>((week) {
                final List<Map<Days, Session>> dailySessions = [];
                (week as Map<String, dynamic>).forEach((dayKey, sessionMap) {
                  final day = Days.values.firstWhere(
                    (d) => d.toString().split('.').last == dayKey,
                  );
                  final session = Session.fromMap(sessionMap);
                  dailySessions.add({day: session});
                });
                return dailySessions;
              }).toList()
              as List<List<Map<Days, Session>>>,
    );
  }
}
