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
      weeks: List<List<Map<Days, Session>>>.from(
        map['weeks'].map(
          (week) => List<Map<Days, Session>>.from(
            week.map((day) {
              final dayKey = day.keys.first;
              final session = day.values.first;
              return {dayKey: Session.fromMap(session)};
            }),
          ),
        ),
      ),
    );
  }
}
