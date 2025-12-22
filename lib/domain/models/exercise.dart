class Exercise {
  final String name;
  final String? description;
  final String imagePath;
  final int? sets;
  final int? reps;
  final int? durationMinutes;
  final String? instructions;
  final String? difficulty;

  Exercise({
    required this.name,
    required this.imagePath,
    this.description,
    this.sets,
    this.reps,
    this.durationMinutes,
    this.instructions,
    this.difficulty,
  });
}
