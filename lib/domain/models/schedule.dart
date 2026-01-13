import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/session.dart';

/// Model representing a workout schedule comprising multiple sessions.
/// A schedule is structured into various sessions which correspond to different days.

class Schedule {
  final String name;
  final String description;
  final List<Map<Days, Session>>
  weeklySessions; //list of weekly sessions mapped to days

  Schedule({
    required this.name,
    required this.weeklySessions,
    required this.description,
  });
}
