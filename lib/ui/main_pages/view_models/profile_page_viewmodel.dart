import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/stat.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePageViewmodel extends ChangeNotifier {
  ProfilePageViewmodel();
  bool loggedIn = false;
  bool get isLoading => false;
  bool get isLoggedIn => loggedIn;
  List<Stat> get stats => [
    Stat(statType: StatType.workouts, value: '42'),
    Stat(statType: StatType.calories, value: '12,345'),
    Stat(statType: StatType.hours, value: '67'),
    Stat(statType: StatType.day, value: 'Wednesday'),
    Stat(statType: StatType.bodyPart, value: 'Legs'),
  ];
  void toggleLoggedIn() {
    loggedIn = !loggedIn;
    notifyListeners();
  }

  void showAboutPage(BuildContext context) {
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
                'Version 1.0.0',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                'BodyFlow is your ultimate workout companion, designed to help you achieve your fitness goals with personalized workout plans and intuitive tracking features.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16),
              TextButton(onPressed: openWebsite, child: Text('Visit Website')),
              TextButton(
                onPressed: () {
                  showLicensePage(
                    context: context,
                    applicationName: 'BodyFlow',
                    applicationVersion: '1.0.0',
                    applicationLegalese:
                        '© 2025 DeeFormed All rights reserved.',
                    applicationIcon: Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                    ),
                  );
                },
                child: Text('Licenses'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openWebsite() {
    // Implement website opening logic here
  }

  void signIn(BuildContext context) {
    context.go(Routes.login);
  }

  Future<void> signOut(BuildContext context) async {
    try {
      final authService = Provider.of<UserAuthentication>(context, listen: false);
      await authService.signOut();
      
      if (context.mounted) {
        context.go(Routes.login);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final authService = Provider.of<UserAuthentication>(context, listen: false);
      await authService.deleteUser();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        context.go(Routes.login);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
