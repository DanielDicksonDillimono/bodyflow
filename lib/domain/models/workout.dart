import 'package:bodyflow/domain/models/exercise.dart';

class Workout {
  final String name;
  final String description;
  final String imagePath;
  final int? durationMinutes;
  final List<Exercise>? exercises;

  Workout({
    required this.name,
    required this.description,
    required this.imagePath,
    this.durationMinutes,
    this.exercises,
  });
}
