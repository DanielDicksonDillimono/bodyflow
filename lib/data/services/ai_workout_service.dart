import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/exercise.dart';
import 'package:bodyflow/domain/models/workout.dart';
import 'package:firebase_ai/firebase_ai.dart';

class AiWorkoutService {
  static const String _defaultWorkoutImage = 'assets/images/barbell.jpg';
  static const int _defaultScheduleDuration = 60;
  static final RegExp _digitExtractor = RegExp(r'[^\d]');

  final GenerativeModel _model;

  AiWorkoutService(String apiKey)
    : _model = FirebaseAI.googleAI().generativeModel(model: 'google-2.5-flash');

  /// Generates a single workout session based on body parts and duration
  Future<Workout> generateWorkout({
    required List<BodyPart> bodyParts,
    required int durationMinutes,
  }) async {
    final bodyPartsStr = bodyParts
        .map((bp) => _bodyPartToString(bp))
        .join(', ');

    final prompt =
        '''
Generate a workout session with the following specifications:
- Target body parts: $bodyPartsStr
- Duration: $durationMinutes minutes
- Include 5-8 exercises
- For each exercise, provide: name, sets, reps, and brief instructions

Format the response as follows:
WORKOUT NAME: [name]
DESCRIPTION: [brief description]

EXERCISES:
1. [Exercise Name]
   Sets: [number]
   Reps: [number]
   Instructions: [brief instructions]

2. [Exercise Name]
   Sets: [number]
   Reps: [number]
   Instructions: [brief instructions]

[continue for all exercises]

Keep it concise and practical.
''';

    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);

    if (response.text == null) {
      throw Exception('Failed to generate workout');
    }

    return _parseWorkoutResponse(response.text!, durationMinutes, bodyPartsStr);
  }

  /// Generates a weekly schedule with workouts for specific days
  Future<Map<Days, Workout>> generateSchedule({
    required List<BodyPart> bodyParts,
    required List<Days> days,
  }) async {
    final bodyPartsStr = bodyParts
        .map((bp) => _bodyPartToString(bp))
        .join(', ');
    final daysStr = days.map((d) => _dayToString(d)).join(', ');

    final prompt =
        '''
Generate a weekly workout schedule with the following specifications:
- Target body parts: $bodyPartsStr
- Training days: $daysStr
- Create a balanced split across the selected days
- Each workout should be 45-60 minutes
- Include 5-7 exercises per workout

For each day, provide:
DAY: [day name]
WORKOUT NAME: [name]
DESCRIPTION: [brief description]
DURATION: [estimated minutes]

EXERCISES:
1. [Exercise Name]
   Sets: [number]
   Reps: [number]
   Instructions: [brief instructions]

2. [Exercise Name]
   Sets: [number]
   Reps: [number]
   Instructions: [brief instructions]

[continue for all exercises]

---

[Repeat for each training day]

Keep it concise and practical.
''';

    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);

    if (response.text == null) {
      throw Exception('Failed to generate schedule');
    }

    return _parseScheduleResponse(response.text!, days);
  }

  String _bodyPartToString(BodyPart bodyPart) {
    switch (bodyPart) {
      case BodyPart.fullBody:
        return 'Full Body';
      case BodyPart.upperBody:
        return 'Upper Body';
      case BodyPart.lowerBody:
        return 'Lower Body';
      case BodyPart.arms:
        return 'Arms';
      case BodyPart.legs:
        return 'Legs';
      case BodyPart.back:
        return 'Back';
      case BodyPart.chest:
        return 'Chest';
      case BodyPart.shoulders:
        return 'Shoulders';
      case BodyPart.core:
        return 'Core';
    }
  }

  String _dayToString(Days day) {
    switch (day) {
      case Days.monday:
        return 'Monday';
      case Days.tuesday:
        return 'Tuesday';
      case Days.wednesday:
        return 'Wednesday';
      case Days.thursday:
        return 'Thursday';
      case Days.friday:
        return 'Friday';
      case Days.saturday:
        return 'Saturday';
      case Days.sunday:
        return 'Sunday';
    }
  }

  Workout _parseWorkoutResponse(
    String response,
    int durationMinutes,
    String bodyPartsStr,
  ) {
    final lines = response.split('\n');
    String workoutName = 'Custom Workout';
    String description = 'AI-generated workout for $bodyPartsStr';
    final exercises = <Exercise>[];

    String? currentExerciseName;
    int? currentSets;
    int? currentReps;
    String? currentInstructions;

    for (var line in lines) {
      line = line.trim();

      if (line.startsWith('WORKOUT NAME:')) {
        workoutName = line.substring('WORKOUT NAME:'.length).trim();
      } else if (line.startsWith('DESCRIPTION:')) {
        description = line.substring('DESCRIPTION:'.length).trim();
      } else if (RegExp(r'^\d+\.\s+').hasMatch(line)) {
        // Save previous exercise if exists
        if (currentExerciseName != null) {
          exercises.add(
            Exercise(
              name: currentExerciseName,
              imagePath: null,
              sets: currentSets,
              reps: currentReps,
              instructions: currentInstructions,
            ),
          );
        }

        // Start new exercise
        currentExerciseName = line
            .replaceFirst(RegExp(r'^\d+\.\s+'), '')
            .trim();
        currentSets = null;
        currentReps = null;
        currentInstructions = null;
      } else if (line.toLowerCase().startsWith('sets:')) {
        final setsStr = line.substring(5).trim();
        currentSets = int.tryParse(setsStr.replaceAll(_digitExtractor, ''));
      } else if (line.toLowerCase().startsWith('reps:')) {
        final repsStr = line.substring(5).trim();
        currentReps = int.tryParse(repsStr.replaceAll(_digitExtractor, ''));
      } else if (line.toLowerCase().startsWith('instructions:')) {
        currentInstructions = line.substring('instructions:'.length).trim();
      }
    }

    // Add the last exercise
    if (currentExerciseName != null) {
      exercises.add(
        Exercise(
          name: currentExerciseName,
          imagePath: null,
          sets: currentSets,
          reps: currentReps,
          instructions: currentInstructions,
        ),
      );
    }

    return Workout(
      name: workoutName,
      description: description,
      imagePath: _defaultWorkoutImage,
      durationMinutes: durationMinutes,
      exercises: exercises.isNotEmpty ? exercises : null,
    );
  }

  Map<Days, Workout> _parseScheduleResponse(String response, List<Days> days) {
    final scheduleMap = <Days, Workout>{};
    final sections = response.split('---');

    for (var section in sections) {
      section = section.trim();
      if (section.isEmpty) continue;

      final lines = section.split('\n');
      Days? currentDay;
      String workoutName = 'Custom Workout';
      String description = 'AI-generated workout';
      int durationMinutes = 60;
      final exercises = <Exercise>[];

      String? currentExerciseName;
      int? currentSets;
      int? currentReps;
      String? currentInstructions;

      for (var line in lines) {
        line = line.trim();

        if (line.startsWith('DAY:')) {
          final dayStr = line.substring('DAY:'.length).trim().toLowerCase();
          currentDay = _parseDayFromString(dayStr);
        } else if (line.startsWith('WORKOUT NAME:')) {
          workoutName = line.substring('WORKOUT NAME:'.length).trim();
        } else if (line.startsWith('DESCRIPTION:')) {
          description = line.substring('DESCRIPTION:'.length).trim();
        } else if (line.startsWith('DURATION:')) {
          final durationStr = line.substring('DURATION:'.length).trim();
          durationMinutes =
              int.tryParse(durationStr.replaceAll(_digitExtractor, '')) ??
              _defaultScheduleDuration;
        } else if (RegExp(r'^\d+\.\s+').hasMatch(line)) {
          // Save previous exercise if exists
          if (currentExerciseName != null) {
            exercises.add(
              Exercise(
                name: currentExerciseName,
                imagePath: null,
                sets: currentSets,
                reps: currentReps,
                instructions: currentInstructions,
              ),
            );
          }

          // Start new exercise
          currentExerciseName = line
              .replaceFirst(RegExp(r'^\d+\.\s+'), '')
              .trim();
          currentSets = null;
          currentReps = null;
          currentInstructions = null;
        } else if (line.toLowerCase().startsWith('sets:')) {
          final setsStr = line.substring(5).trim();
          currentSets = int.tryParse(setsStr.replaceAll(_digitExtractor, ''));
        } else if (line.toLowerCase().startsWith('reps:')) {
          final repsStr = line.substring(5).trim();
          currentReps = int.tryParse(repsStr.replaceAll(_digitExtractor, ''));
        } else if (line.toLowerCase().startsWith('instructions:')) {
          currentInstructions = line.substring('instructions:'.length).trim();
        }
      }

      // Add the last exercise
      if (currentExerciseName != null) {
        exercises.add(
          Exercise(
            name: currentExerciseName,
            imagePath: null,
            sets: currentSets,
            reps: currentReps,
            instructions: currentInstructions,
          ),
        );
      }

      // Add workout to schedule if we have a valid day
      if (currentDay != null && days.contains(currentDay)) {
        scheduleMap[currentDay] = Workout(
          name: workoutName,
          description: description,
          imagePath: _defaultWorkoutImage,
          durationMinutes: durationMinutes,
          exercises: exercises.isNotEmpty ? exercises : null,
        );
      }
    }

    // Fill in any missing days with basic workouts
    for (var day in days) {
      if (!scheduleMap.containsKey(day)) {
        scheduleMap[day] = Workout(
          name: '${_dayToString(day)} Workout',
          description: 'Rest day or light activity',
          imagePath: _defaultWorkoutImage,
          durationMinutes: 30,
        );
      }
    }

    return scheduleMap;
  }

  Days? _parseDayFromString(String dayStr) {
    final normalized = dayStr.toLowerCase();
    if (normalized.contains('monday')) return Days.monday;
    if (normalized.contains('tuesday')) return Days.tuesday;
    if (normalized.contains('wednesday')) return Days.wednesday;
    if (normalized.contains('thursday')) return Days.thursday;
    if (normalized.contains('friday')) return Days.friday;
    if (normalized.contains('saturday')) return Days.saturday;
    if (normalized.contains('sunday')) return Days.sunday;
    return null;
  }
}
