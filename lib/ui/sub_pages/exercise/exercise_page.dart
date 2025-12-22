import 'package:bodyflow/domain/models/exercise.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  final Exercise exercise;

  const ExercisePage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Section with Back Button
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(exercise.imagePath),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withValues(alpha: 0.3),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                  // Back Button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Exercise Details Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    // Exercise Title
                    Text(
                      exercise.name.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                    ),
                    SizedBox(height: 16),
                    // Difficulty Badge
                    if (exercise.difficulty != null) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(exercise.difficulty!),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          exercise.difficulty!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                    // Stats Section
                    if (exercise.sets != null || exercise.reps != null || exercise.durationMinutes != null) ...[
                      Row(
                        children: [
                          if (exercise.sets != null) ...[
                            Icon(Icons.fitness_center, size: 20),
                            SizedBox(width: 8),
                            Text(
                              '${exercise.sets} sets',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(width: 16),
                          ],
                          if (exercise.reps != null) ...[
                            Icon(Icons.repeat, size: 20),
                            SizedBox(width: 8),
                            Text(
                              '${exercise.reps} reps',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(width: 16),
                          ],
                          if (exercise.durationMinutes != null) ...[
                            Icon(Icons.access_time, size: 20),
                            SizedBox(width: 8),
                            Text(
                              '${exercise.durationMinutes} minutes',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 24),
                    ],
                    // Description
                    if (exercise.description != null) ...[
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        exercise.description!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 24),
                    ],
                    // Instructions
                    if (exercise.instructions != null) ...[
                      Text(
                        'Instructions',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        exercise.instructions!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
