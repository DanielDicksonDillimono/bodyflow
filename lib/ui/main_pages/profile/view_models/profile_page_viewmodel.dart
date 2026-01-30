import 'dart:async';
import 'package:bodyflow/data/database/database_service.dart';
import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:bodyflow/data/repos/workout_repo.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/domain/models/stat.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePageViewmodel extends ChangeNotifier {
  final UserAuthentication _authService;
  final WorkoutRepo _workoutRepo;
  final DatabaseService database;
  int _schedulesCount = 0;
  int _sessionsCount = 0;
  StreamSubscription<List<Schedule>>? _schedulesSubscription;
  StreamSubscription<List<Session>>? _sessionsSubscription;

  ProfilePageViewmodel({
    required UserAuthentication authService,
    required WorkoutRepo workoutRepo,
    required this.database,
  }) : _authService = authService,
       _workoutRepo = workoutRepo {
    _loadStats();
  }

  void _loadStats() {
    // Listen to schedules stream
    _schedulesSubscription = _workoutRepo.allSchedulesStream().listen(
      (schedules) {
        _schedulesCount = schedules.length;
        notifyListeners();
      },
      onError: (error) {
        // Handle error gracefully - keep count at 0
        _schedulesCount = 0;
        notifyListeners();
      },
    );

    // Listen to sessions stream
    _sessionsSubscription = _workoutRepo.allSessionsStream().listen(
      (sessions) {
        _sessionsCount = sessions.length;
        notifyListeners();
      },
      onError: (error) {
        // Handle error gracefully - keep count at 0
        _sessionsCount = 0;
        notifyListeners();
      },
    );
  }

  String get userName {
    final user = _authService.currentUser();
    final displayName = user?.displayName;
    if (displayName != null && displayName.isNotEmpty) {
      return displayName;
    }
    final email = user?.email;

    // Use the user's email prefix as name if displayName is not set
    if (email != null && email.isNotEmpty && email.contains('@')) {
      return email.split('@')[0];
    }
    return 'User';
  }

  String get userEmail {
    final user = _authService.currentUser();
    return user?.email ?? '';
  }

  List<Stat> get stats => [
    Stat(statType: StatType.schedules, value: '$_schedulesCount'),
    Stat(statType: StatType.sessions, value: '$_sessionsCount'),
  ];

  @override
  void dispose() {
    _schedulesSubscription?.cancel();
    _sessionsSubscription?.cancel();
    super.dispose();
  }

  void showAboutPage(BuildContext context) {
    final localization = AppLocalization.of(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logoSlogan.png', height: 100),
              SizedBox(height: 16),
              Text(
                localization.appVersion,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                localization.appDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: openWebsite,
                child: Text(localization.visitWebsite),
              ),
              TextButton(
                onPressed: () {
                  showLicensePage(
                    context: context,
                    applicationName: localization.appName,
                    applicationVersion: '1.0.0',
                    applicationLegalese: localization.copyrightNotice,
                    applicationIcon: Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                    ),
                  );
                },
                child: Text(localization.licenses),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openWebsite() async {
    String url = 'https://dillimono.com/projects';
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      throw 'Could not launch $url';
    }
  }

  void signIn(BuildContext context) {
    // Implement sign-in logic here
    context.push(Routes.login);
  }

  void deleteAccount(BuildContext context) async {
    final localization = AppLocalization.of(context);
    // Implement delete account logic here
    //context.push(Routes.deleteAccount);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          content: Text(localization.deleteAccountConfirmation),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(localization.cancel),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () async {
                // Call the delete account method
                try {
                  await database.deleteUserAccount().then((_) async {
                    await _authService.deleteUser();
                  });
                  if (context.mounted) {
                    context.go(Routes.home);
                  }
                } catch (e) {
                  // Handle error
                }
              },
              child: Text(
                localization.delete,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void signOut(BuildContext context) async {
    // Implement sign-out logic here
    await _authService.signOut();
    if (context.mounted) {
      context.go(Routes.home);
    }
    notifyListeners();
  }

  void showErrorMessage(BuildContext context, String message) {
    final localization = AppLocalization.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localization.error),
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
}
