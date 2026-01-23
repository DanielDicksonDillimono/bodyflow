import 'package:bodyflow/data/repos/workout_repo.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier {
  final WorkoutRepo _workoutRepo;

  HomePageViewModel({required WorkoutRepo workoutRepo})
    : _workoutRepo = workoutRepo;

  // Add your ViewModel logic here

  Stream<dynamic> get sessionStream => _workoutRepo.allSessionsStream();
  Stream<dynamic> get scheduleStream => _workoutRepo.allSchedulesStream();
}
