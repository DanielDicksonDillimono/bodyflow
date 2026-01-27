import 'dart:convert';

import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/exercise.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:firebase_ai/firebase_ai.dart';

class AiWorkoutService {
  static const String _defaultWorkoutImage = 'assets/images/barbell.jpg';

  final GenerativeModel _model;

  AiWorkoutService()
    : _model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.5-flash',
        systemInstruction: Content.text('You are a helpful fitness assistant.'),
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
    String extraNotes = '',
  }) async {
    final receivedBodyParts = bodyParts.map((bp) => bp.name).join(', ');

    final prompt =
        '''
        Generate a workout session with the following specifications:
        - Target body parts: $receivedBodyParts
        - Duration: $durationMinutes minutes
        - each exercise should take approximately 10 minutes to complete
        - Add at least one compound movement exercise
        - For each exercise, provide: name, sets, reps, and brief instructions
        - No bodyweight exercises, only use equipment like dumbbells, barbells, machines, cables, etc.
        - Include any additional notes or tips for the workout session (optional).
        - if $extraNotes are supplied, include them in the response.


        Format the response as follows:
        WORKOUT NAME: [name] keep it to 2 - 3 words.
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
    required int durationMinutes,
    required bool varyWeeklySessions,
    String extraNotes = '',
  }) async {
    Schedule schedule;
    String daysStr = days.map((day) => day.name).join(', ');
    String bodyPartsStr = bodyParts.map((bp) => bp.name).join(', ');

    final prompt =
        '''
        Generate a workout Schedule for each $daysStr for the next $numberOfWeeks weeks with the following specifications:
        - Target body parts: $bodyPartsStr
        - Duration: $durationMinutes minutes
        - each exercise should take approximately 15 minutes to complete
        - Add at least one compound movement exercise
        - For each exercise, provide: name, sets, reps, and brief instructions
        - No bodyweight exercises, only use equipment like dumbbells, barbells, machines, cables, etc.
        - Include any additional notes or tips for the workout sessions (optional).
        - if $extraNotes are supplied, include them in the response.


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

        if varyWeeklySessions is true, make sure each week's sessions are different but keep the overall structure and format consistent i.e.
        each session should have a similar number of exercises and follow the same format.
        ''';

    final List<Content> content = [Content.text(prompt)];

    final Schema scheduleSchema = Schema.object(
      properties: {
        'name': Schema.string(),
        'description': Schema.string(),
        'weeks': Schema.array(
          items: Schema.array(
            items: Schema.object(
              properties: {
                'day': Schema.string(),
                'session': Schema.object(
                  properties: {
                    'name': Schema.string(),
                    'description': Schema.string(),
                    'bodyParts': Schema.string(),
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
                ),
              },
            ),
          ),
        ),
      },
    );

    final response = await _model.generateContent(
      content,
      generationConfig: GenerationConfig(
        responseSchema: scheduleSchema,
        responseMimeType: 'application/json',
      ),
    );

    schedule = _parseScheduleResponse(
      response.text!,
      durationMinutes,
      bodyPartsStr,
    );
    return schedule;
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
                durationMinutes: exercise['durationMinutes'],
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
      id: '', // ID can be assigned when saving to database
    );
  }

  Schedule _parseScheduleResponse(
    String response,
    int durationMinutes,
    String bodyPartsStr,
  ) {
    final Map<String, dynamic> responseMap = jsonDecode(response);
    final weeks = responseMap['weeks'];

    return Schedule(
      name: responseMap['name'] ?? 'Custom Schedule',
      description:
          responseMap['description'] ??
          'AI-generated workout schedule for $bodyPartsStr',
      weeks: _parseWeeklySessionsFromList(weeks, durationMinutes),
      id: '', // ID can be assigned when saving to database
    );
  }

  List<List<Map<Days, Session>>> _parseWeeklySessionsFromList(
    List<dynamic> weeks,
    int durationMinutes,
  ) {
    List<List<Map<Days, Session>>> weeklySessions = [];

    for (var week in weeks) {
      List<Map<Days, Session>> dailySessions = [];
      for (var dayEntry in week) {
        // add a day and its session
        final day = _parseDayFromString(dayEntry['day']);
        final sessionMap = dayEntry['session'] as Map<String, dynamic>;
        final session = _parseSessionFromMap(sessionMap, durationMinutes);
        dailySessions.add({day!: session});
      }
      // add the week's sessions
      weeklySessions.add(dailySessions);
    }
    return weeklySessions;
  }

  Session _parseSessionFromMap(
    Map<String, dynamic> sessionMap,
    int durationMinutes,
  ) {
    final exercises =
        (sessionMap['exercises'] as List<dynamic>?)
            ?.map<Exercise>(
              (exercise) => Exercise(
                name: exercise['name'],
                sets: exercise['sets'],
                reps: exercise['reps'],
                instructions: exercise['instructions'],
                durationMinutes: exercise['durationMinutes'],
              ),
            )
            .toList() ??
        [];

    return Session(
      name: sessionMap['name'] ?? 'Custom Workout',
      description: sessionMap['description'] ?? 'AI-generated workout session',
      imagePath: _defaultWorkoutImage,
      exercises: exercises.isNotEmpty ? exercises : null,
      durationMinutes: durationMinutes,
      id: '', // ID can be assigned when saving to database
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
