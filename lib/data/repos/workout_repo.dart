import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/data/services/ai_workout_service.dart';
import 'package:bodyflow/data/database/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutRepo {
  //TODO probably not needed if we use streams directly from database service
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

  Stream<List<Schedule>> allSchedulesStream() {
    return _databaseService.allSchedulesStream().map((snapshot) {
      try {
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return Schedule.fromMap(data);
        }).toList();
      } catch (e) {
        return <Schedule>[];
      }
    });
  }

  Stream<List<Session>> allSessionsStream() {
    return _databaseService.allSessionsStream().map(
      (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Session.fromMap(data);
      }).toList(),
    );
  }

  Future<Session> generateWorkoutSession({
    required List<BodyPart> bodyParts,
    required int durationMinutes,
    String extraNotes = '',
  }) async {
    try {
      Session session = await _aiWorkoutService.generateSession(
        bodyParts: bodyParts,
        durationMinutes: durationMinutes,
      );

      // Save if user logged in. Generating sessions are only for logged in users.
      if (FirebaseAuth.instance.currentUser != null) {
        final data = session.toMap();
        await _databaseService.saveSession(data);
      }
      return session;
    } catch (e) {
      rethrow;
    }
  }

  Future<Schedule> generateWorkoutSchedule({
    required List<BodyPart> bodyParts,
    required List<Days> days,
    required int numberOfWeeks,
    required int durationMinutes,
    required bool varyWeeklySessions,
    String extraNotes = '',
  }) async {
    try {
      Schedule schedule = await _aiWorkoutService.generateSchedule(
        bodyParts: bodyParts,
        days: days,
        numberOfWeeks: numberOfWeeks,
        durationMinutes: durationMinutes,
        varyWeeklySessions: varyWeeklySessions,
      );

      // Save if user logged in. Generating schedules are only for logged in users.
      if (FirebaseAuth.instance.currentUser != null) {
        await _databaseService.saveSchedule(schedule.toMap());
      }
      return schedule;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSession(String sessionId) async {
    try {
      await _databaseService.deleteSession(sessionId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSchedule(String scheduleId) async {
    try {
      await _databaseService.deleteSchedule(scheduleId);
    } catch (e) {
      rethrow;
    }
  }
}
