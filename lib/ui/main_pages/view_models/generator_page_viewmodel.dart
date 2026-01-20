import 'package:bodyflow/data/repos/workout_repo.dart';
import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GeneratorPageViewModel with ChangeNotifier {
  final WorkoutRepo _workoutRepo;

  GeneratorPageViewModel({required WorkoutRepo workoutRepo})
    : _workoutRepo = workoutRepo;

  final timeController = TextEditingController.fromValue(
    const TextEditingValue(
      text: '30',
      selection: TextSelection.collapsed(offset: 2),
    ),
  );

  final weekController = TextEditingController.fromValue(
    const TextEditingValue(
      text: '1',
      selection: TextSelection.collapsed(offset: 1),
    ),
  );

  bool _isGenerating = false;

  bool _varyWeeklySessions = false;

  bool get isGenerating => _isGenerating;

  bool get varyWeeklySessions => _varyWeeklySessions;

  final List<BodyPart> _selectedBodyParts = [];
  final List<Days> _selectedDays = [];

  ActivityType _activityType = ActivityType.session;

  int _sessionLengthInMinutes = 30;
  int _numberOfWeeks = 1;

  int get sessionLengthInMinutes => _sessionLengthInMinutes;

  ActivityType get activityType => _activityType;

  List<BodyPart> get selectedBodyParts => _selectedBodyParts;
  List<Days> get selectedDays => _selectedDays;

  void setVaryWeeklySessions(bool value) {
    _varyWeeklySessions = value;
    notifyListeners();
  }

  void setActivityAsSession() {
    if (_activityType == ActivityType.session) return;
    _activityType = ActivityType.session;
    clearSelections();
  }

  void clearSelections() {
    _selectedBodyParts.clear();
    _selectedDays.clear();
    notifyListeners();
  }

  void setActivityAsSchedule() {
    if (_activityType == ActivityType.schedule) return;
    _activityType = ActivityType.schedule;
    clearSelections();
  }

  void setSessionLength(int minutes) {
    _sessionLengthInMinutes = minutes;
    notifyListeners();
  }

  void setNumberOfWeeks(int weeks) {
    _numberOfWeeks = weeks;
    notifyListeners();
  }

  void setIsGenerating(bool value) {
    _isGenerating = value;
    notifyListeners();
  }

  void addOrRemoveBodyPart(BodyPart bodyPart) {
    if (_selectedBodyParts.contains(bodyPart)) {
      _selectedBodyParts.remove(bodyPart);
    } else {
      _selectedBodyParts.add(bodyPart);
    }
    notifyListeners();
  }

  void addOrRemoveDay(Days day) {
    if (_selectedDays.contains(day)) {
      _selectedDays.remove(day);
    } else {
      _selectedDays.add(day);
    }
    notifyListeners();
  }

  void showGetALifeMessage(BuildContext context) {
    final localization = AppLocalization.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localization.getALife),
        content: Text(localization.getALifeMessage),
        actions: [
          TextButton(
            onPressed: () {
              timeController.text = '120';
              Navigator.of(context).pop();
            },
            child: Text(localization.ok),
          ),
        ],
      ),
    );
  }

  void showTooManyWeeksMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Too many weeks!'),
        content: const Text(
          'Generating a schedule for more than 12 weeks is not recommended. Please select 12 weeks or less.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              weekController.text = '12';
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> generateWorkout(BuildContext context) async {
    final localization = AppLocalization.of(context);
    
    // Check if user is logged in
    final userAuth = Provider.of<UserAuthentication>(context, listen: false);
    if (userAuth.currentUser() == null) {
      _showValidationError(
        context,
        localization.loginRequired,
        localization.loginRequiredMessage,
      );
      return;
    }
    
    // Validate selections based on activity type
    if (_selectedBodyParts.isEmpty) {
      _showValidationError(
        context,
        localization.noBodyPartsSelected,
        localization.selectBodyPartMessage,
      );
      return;
    }

    if (_activityType == ActivityType.schedule && _selectedDays.isEmpty) {
      _showValidationError(
        context,
        localization.noDaysSelected,
        localization.selectDayMessage,
      );
      return;
    }

    if (_activityType == ActivityType.session) {
      final minutes = int.tryParse(timeController.text) ?? 0;
      if (minutes <= 0) {
        _showValidationError(
          context,
          localization.invalidDuration,
          localization.invalidDurationMessage,
        );
        return;
      }
      _sessionLengthInMinutes = minutes;
    }

    setIsGenerating(true);

    try {
      if (_activityType == ActivityType.session) {
        final workout = await _workoutRepo.generateWorkoutSession(
          _selectedBodyParts,
          _sessionLengthInMinutes,
        );
        setIsGenerating(false);
        if (context.mounted) {
          _showWorkoutSessionResult(context, workout);
        }
        return;
      } else if (_activityType == ActivityType.schedule) {
        final schedule = await _workoutRepo.generateWorkoutSchedule(
          bodyParts: _selectedBodyParts,
          days: _selectedDays,
          numberOfWeeks: _numberOfWeeks,
          durationMinutes: _sessionLengthInMinutes,
          varyWeeklySessions: _varyWeeklySessions,
        );
        setIsGenerating(false);
        if (context.mounted) {
          _showWorkoutScheduleResult(context, schedule);
        }
      }
      setIsGenerating(false);
    } catch (e) {
      setIsGenerating(false);
      // Log the actual error for debugging
      debugPrint('Workout generation error: $e');
      if (context.mounted) {
        _showValidationError(
          context,
          'Generation Failed',
          'Unable to generate workout at this time. Please check your internet connection and try again.',
        );
      }
    }
  }

  void _showWorkoutSessionResult(BuildContext context, Session session) {
    context.push(Routes.session, extra: session);
  }

  void _showWorkoutScheduleResult(BuildContext context, Schedule schedule) {
    context.push(Routes.schedule, extra: schedule);
  }

  void _showValidationError(
    BuildContext context,
    String title,
    String message,
  ) {
    final localization = AppLocalization.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(localization.ok),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }
}
