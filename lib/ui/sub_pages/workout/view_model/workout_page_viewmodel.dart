import 'package:bodyflow/domain/models/exercise.dart';
import 'package:flutter/material.dart';

class WorkoutPageViewmodel extends ChangeNotifier {
  // Add properties and methods relevant to the workout page here

  List<Exercise> getExercises() {
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
        description:
            'Lower body exercise targeting quads, hamstrings, and glutes.',
        instructions:
            'Stand shoulder-width apart. Lower by bending knees and hips. Keep back straight. Return to start.',
        difficulty: 'Medium',
      ),
      Exercise(
        name: 'Deadlifts',
        imagePath: 'assets/images/barbell.jpg',
        sets: 3,
        reps: 12,
        description: 'Full body compound exercise for strength building.',
        instructions:
            'Stand with feet hip-width. Bend at hips and knees, grip bar. Lift by extending hips and knees.',
        difficulty: 'Hard',
      ),
    ];
  }
}
