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
        return week.map((day) {
          return MapEntry(day.keys.first, day.values.first.toMap());
        }).toList();
      }).toList(),
    };
  }
}
