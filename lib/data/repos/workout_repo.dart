import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/data/services/ai_workout_service.dart';
import 'package:bodyflow/data/database/database_service.dart';

class WorkoutRepo {
  final List<Schedule> _schedules = [];
  final List<Session> _sessions = [];
  final AiWorkoutService _aiWorkoutService;
  final DatabaseService _databaseService;

  WorkoutRepo({
    required AiWorkoutService aiWorkoutService,
    required DatabaseService databaseService,
  }) : _aiWorkoutService = aiWorkoutService,
       _databaseService = databaseService;

  List<Session> get workouts => _sessions;
  List<Schedule> get schedules => _schedules;

  void getAllSchedules() {
    // Implementation to fetch all schedules from database
  }

  void getAllSessions() {
    // Implementation to fetch all sessions from database
  }

  Future<Session> generateWorkoutSession(
    List<BodyPart> bodyParts,
    int durationMinutes,
  ) async {
    try {
      Session session = await _aiWorkoutService.generateSession(
        bodyParts: bodyParts,
        durationMinutes: durationMinutes,
      );

      //save if user logged in.
      //await _databaseService.saveSession(session as Map<String, dynamic>);
      return session;
    } catch (e) {
      rethrow;
    }

    // Optionally save to database
  }

  Future<Schedule> generateWorkoutSchedule({
    required List<BodyPart> bodyParts,
    required List<Days> days,
    required int numberOfWeeks,
    required int durationMinutes,
    required bool varyWeeklySessions,
  }) async {
    try {
      Schedule schedule = await _aiWorkoutService.generateSchedule(
        bodyParts: bodyParts,
        days: days,
        numberOfWeeks: numberOfWeeks,
        durationMinutes: durationMinutes,
        varyWeeklySessions: varyWeeklySessions,
      );
      //await _databaseService.saveSchedule(schedule);
      return schedule;
    } catch (e) {
      rethrow;
    }
  }

  void getExercise() {
    // Implementation to fetch exercises for workouts
  }
}
