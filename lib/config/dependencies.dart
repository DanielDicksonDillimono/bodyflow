import 'package:bodyflow/data/database/database_service.dart';
import 'package:bodyflow/data/repos/workout_repo.dart';
import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:bodyflow/data/services/ai_workout_service.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> dependencyProviders() {
  return [
    ChangeNotifierProvider(
      create: (context) => UserAuthentication(FirebaseAuth.instance),
    ),
    Provider(
      create: (context) => WorkoutRepo(
        aiWorkoutService: AiWorkoutService(),
        databaseService: DatabaseService(FirebaseFirestore.instance),
      ),
    ),
  ];
}
