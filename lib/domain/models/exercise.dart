class Exercise {
  final String name;
  final String? description;
  final int? sets;
  final int? reps;
  final int? durationMinutes;
  final String? instructions;
  final String? difficulty;

  Exercise({
    required this.name,
    this.description,
    this.sets,
    this.reps,
    this.durationMinutes,
    this.instructions,
    this.difficulty,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'sets': sets,
      'reps': reps,
      'durationMinutes': durationMinutes,
      'instructions': instructions,
      'difficulty': difficulty,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'],
      description: map['description'],
      sets: map['sets'],
      reps: map['reps'],
      durationMinutes: map['durationMinutes'],
      instructions: map['instructions'],
      difficulty: map['difficulty'],
    );
  }
}
