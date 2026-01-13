import 'dart:convert';

import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/exercise.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:firebase_ai/firebase_ai.dart';

class AiWorkoutService {
  static const String _defaultWorkoutImage = 'assets/images/barbell.jpg';
  static const int _defaultScheduleDuration = 60;

  final GenerativeModel _model;

  AiWorkoutService()
    : _model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.5-flash',
        systemInstruction: Content.text('You are a helpful fitness assistant.'),
      );

  final Schema scheduleSchema = Schema.object(
    properties: {
      'name': Schema.string(),
      'description': Schema.string(),
      'weeklySessions': Schema.array(
        items: Schema.object(
          properties: {
            'day': Schema.string(),
            'session': Schema.object(
              properties: {
                'name': Schema.string(),
                'description': Schema.string(),
                'exercises': Schema.array(
                  items: Schema.object(
                    properties: {
                      'name': Schema.string(),
                      'sets': Schema.integer(),
                      'reps': Schema.integer(),
                      'instructions': Schema.string(),
                    },
                  ),
                ),
              },
            ),
          },
        ),
      ),
    },
  );

  final Schema sessionSchema = Schema.object(
    properties: {
      'name': Schema.string(),
      'description': Schema.string(),
      'exercises': Schema.array(
        items: Schema.object(
          properties: {
            'name': Schema.string(),
            'sets': Schema.integer(),
            'reps': Schema.integer(),
            'instructions': Schema.string(),
            'imagePath': Schema.string(),
            'durationMinutes': Schema.integer(),
          },
        ),
      ),
    },
  );

  /// Generates a single workout session based on body parts and duration
  Future<Session> generateSession({
    required List<BodyPart> bodyParts,
    required int durationMinutes,
  }) async {
    final receivedBodyParts = bodyParts.map((bp) => bp.name).join(', ');

    final prompt =
        '''
Generate a workout session with the following specifications:
- Target body parts: $receivedBodyParts
- Duration: $durationMinutes minutes
- each exercise should take approximately 10 minutes to complete
- Add at least one compound movement exercise
- 
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
    late final GenerateContentResponse response;
    try {
      response = await _model.generateContent(
        content,
        generationConfig: GenerationConfig(
          responseSchema: sessionSchema,
          responseMimeType: 'application/json',
        ),
      );
    } catch (e) {
      throw Exception('Failed to generate workout: $e');
      //rethrow;
    }

    if (response.text == null) {
      throw Exception('Failed to generate workout');
    }

    return _parseWorkoutSessionResponse(
      response.text!,
      durationMinutes,
      receivedBodyParts,
    );
  }

  /// Generates a weekly schedule with workouts for specific days
  Future<Schedule> generateSchedule({
    required List<BodyPart> bodyParts,
    required List<Days> days,
    required int numberOfWeeks,
  }) async {
    final List<Content> content = <Content>[];

    final response = await _model.generateContent(content);

    Schedule fullSchedule = Schedule(
      name: 'Custom Schedule',
      description: 'AI-generated workout schedule',
      weeklySessions: [],
    );

    for (var i = 0; i < numberOfWeeks; i++) {
      for (var day in days) {
        final session = await generateSession(
          bodyParts: bodyParts,
          durationMinutes: _defaultScheduleDuration,
        );
        fullSchedule.weeklySessions.add({day: session});
      }
    }

    return fullSchedule;
  }

  Session _parseWorkoutSessionResponse(
    String response,
    int durationMinutes,
    String bodyPartsStr,
  ) {
    final Map<String, dynamic> responseMap = jsonDecode(response);
    String workoutName = responseMap['name'] ?? 'Custom Workout';
    String description =
        responseMap['description'] ?? 'AI-generated workout for $bodyPartsStr';
    final exercises =
        responseMap['exercises']
            ?.map<Exercise>(
              (exercise) => Exercise(
                name: exercise['name'],
                sets: exercise['sets'],
                reps: exercise['reps'],
                instructions: exercise['instructions'],
              ),
            )
            .toList() ??
        [];

    return Session(
      name: workoutName,
      description: description,
      imagePath: _defaultWorkoutImage,
      durationMinutes: durationMinutes,
      exercises: exercises.isNotEmpty ? exercises : null,
    );
  }

  Schedule _parseScheduleResponse(String response, List<Days> days) {
    final scheduleMap = <Days, Session>{};

    return Schedule(
      name: 'Custom Schedule',
      description: 'AI-generated workout schedule',
      weeklySessions: [scheduleMap],
    );
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
