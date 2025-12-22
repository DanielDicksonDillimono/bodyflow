import 'package:bodyflow/domain/models/exercise.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/domain/models/exercise.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  List<Exercise> _getExercises() {
    return [
      Exercise(
        name: 'Cardio',
        imagePath: 'assets/images/threadmill.jpg',
        durationMinutes: 10,
        description: 'Cardio warm-up exercise',
        difficulty: 'Easy',
      ),
      Exercise(
        name: 'Squats',
        imagePath: 'assets/images/frontSquat.jpg',
        sets: 5,
        reps: 10,
        description: 'Lower body exercise targeting quads, hamstrings, and glutes.',
        instructions: 'Stand shoulder-width apart. Lower by bending knees and hips. Keep back straight. Return to start.',
        difficulty: 'Medium',
      ),
      Exercise(
        name: 'Deadlifts',
        imagePath: 'assets/images/barbell.jpg',
        sets: 3,
        reps: 12,
        description: 'Full body compound exercise for strength building.',
        instructions: 'Stand with feet hip-width. Bend at hips and knees, grip bar. Lift by extending hips and knees.',
        difficulty: 'Hard',
      ),
    ];
  }

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
                        image: AssetImage('assets/images/squat.jpg'),
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
              // Workout Details Section
              Padding(
                padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimens.paddingVertical),
                    // Workout Title
                    Text(
                      'LEGS',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                    SizedBox(height: Dimens.paddingVerticalSmall),
                    // Duration
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '45 minutes',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    SizedBox(height: Dimens.paddingVerticalSmall),
                    // Exercises List
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.fitness_center,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'squats, deadlifts, lunges',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimens.paddingVertical),
                  ],
                ),
              ),
              // Exercise Cards Section
              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                  itemCount: _getExercises().length,
                  separatorBuilder: (context, index) => SizedBox(width: Dimens.paddingHorizontal),
                  itemBuilder: (context, index) {
                    final exercise = _getExercises()[index];
                    return _buildExerciseCard(
                      context,
                      exercise: Exercise(
                        name: 'Cardio',
                        imagePath: 'assets/images/threadmill.jpg',
                        durationMinutes: 10,
                        description: 'Cardiovascular exercise to improve endurance and burn calories.',
                        instructions: 'Start at a comfortable pace. Gradually increase intensity. Maintain steady breathing throughout.',
                        difficulty: 'Easy',
                      ),
                    ),
                    SizedBox(width: Dimens.paddingHorizontal),
                    _buildExerciseCard(
                      context,
                      exercise: Exercise(
                        name: 'Squats',
                        imagePath: 'assets/images/frontSquat.jpg',
                        sets: 5,
                        reps: 10,
                        description: 'A fundamental lower body exercise targeting quads, hamstrings, and glutes.',
                        instructions: 'Stand with feet shoulder-width apart. Lower your body by bending knees and hips. Keep chest up and back straight. Push through heels to return to start.',
                        difficulty: 'Medium',
                      ),
                    ),
                    SizedBox(width: Dimens.paddingHorizontal),
                    _buildExerciseCard(
                      context,
                      exercise: Exercise(
                        name: 'Deadlifts',
                        imagePath: 'assets/images/barbell.jpg',
                        sets: 3,
                        reps: 12,
                        description: 'Compound exercise for building overall strength, targeting back, legs, and core.',
                        instructions: 'Stand with feet hip-width apart. Bend at hips and knees to grip bar. Keep back straight and lift by extending hips and knees. Lower with control.',
                        difficulty: 'Hard',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimens.paddingVertical),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard(
    BuildContext context, {
    required Exercise exercise,
  }) {
    // Format display text for the card
    String displayText;
    if (exercise.durationMinutes != null) {
      displayText = '${exercise.durationMinutes} minutes';
    } else if (exercise.sets != null && exercise.reps != null) {
      displayText = '${exercise.sets} sets of ${exercise.reps} reps';
    } else if (exercise.sets != null) {
      displayText = '${exercise.sets} sets';
    } else if (exercise.reps != null) {
      displayText = '${exercise.reps} reps';
    } else {
      displayText = '';
    }

    return InkWell(
      onTap: () {
        context.push(Routes.exercise, extra: exercise);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Container(
              width: Dimens.textCardWidth(context),
              height: Dimens.textCardHeight(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(exercise.imagePath ?? 'assets/images/barbell.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  exercise.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Exercise Details
            Container(
              padding: const EdgeInsets.all(12),
              width: Dimens.textCardWidth(context),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Icon(
                    exercise.durationMinutes != null ? Icons.access_time : Icons.fitness_center,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      displayText,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
