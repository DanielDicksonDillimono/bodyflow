import 'package:bodyflow/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePageViewmodel extends ChangeNotifier {
  ProfilePageViewmodel();
  bool loggedIn = false;
  bool get isLoading => false;
  bool get isLoggedIn => loggedIn;
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
    // showAboutDialog(
    //   context: context,
    //   applicationName: 'BodyFlow',
    //   applicationVersion: '1.0.0',
    //   applicationLegalese: '© 2025 DeeFormed All rights reserved.',
    //   applicationIcon: Image.asset('assets/images/logo.png'),
    //   children: [
    //     const Padding(
    //       padding: EdgeInsets.only(top: 15.0),
    //       child: Text(
    //         'BodyFlow is your ultimate workout companion, designed to help you achieve your fitness goals with personalized workout plans and intuitive tracking features.',
    //       ),
    //     ),
    //   ],
    // );
  }

  void openWebsite() {
    // Implement website opening logic here
  }

  void signIn(BuildContext context) {
    // Implement sign-in logic here
    context.go(Routes.login);
  }
}
