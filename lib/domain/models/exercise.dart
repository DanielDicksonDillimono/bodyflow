class Exercise {
  final String name;
  final String? description;
  final String? imagePath;
  final int? sets;
  final int? reps;
  final int? durationMinutes;
  final String? instructions;
  final String? difficulty;

  const Exercise({
    required this.name,
    this.description,
    this.imagePath,
    this.sets,
    this.reps,
    this.durationMinutes,
    this.instructions,
    this.difficulty,
  });
}
