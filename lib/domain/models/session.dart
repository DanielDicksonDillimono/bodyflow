import 'package:bodyflow/domain/models/exercise.dart';

class Session {
  final String name;
  final String description;
  final String imagePath;
  final int? durationMinutes;
  final List<Exercise>? exercises;

  Session({
    required this.name,
    required this.description,
    required this.imagePath,
    this.durationMinutes,
    this.exercises,
  });
}
