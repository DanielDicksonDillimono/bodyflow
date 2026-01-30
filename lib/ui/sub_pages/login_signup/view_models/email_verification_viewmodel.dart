import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailVerificationViewmodel extends ChangeNotifier {
  final UserAuthentication _authService;

  EmailVerificationViewmodel({required UserAuthentication authService})
    : _authService = authService {
    userEmail = _authService.currentUser()?.email ?? '';
  }

  bool isLoading = false;
  late String userEmail;

  Future<void> sendVerificationEmail(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await _authService.sendEmailVerification();
      if (context.mounted) {
        showMessage(
          context,
          '${AppLocalization.of(context).verificationEmailSent} $userEmail',
        );
      }
    } catch (e) {
      if (context.mounted) {
        showMessage(
          context,
          '${AppLocalization.of(context).errorSendingVerificationEmail}$userEmail',
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void goToHomePage(BuildContext context) {
    context.go(Routes.home);
  }

  void logout(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await _authService.signOut();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    } catch (e) {
      if (context.mounted) {
        showMessage(context, AppLocalization.of(context).errorOccurredMessage);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void checkValidation(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await _authService.currentUser()?.reload();
    final isVerified = _authService.currentUser()?.emailVerified ?? false;

    isLoading = false;
    notifyListeners();

    if (isVerified) {
      if (context.mounted) {
        goToHomePage(context);
      }
    } else {
      if (context.mounted) {
        showMessage(context, AppLocalization.of(context).errorOccurredMessage);
      }
    }
  }

  void showMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
