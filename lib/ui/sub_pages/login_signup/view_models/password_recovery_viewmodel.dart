import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:flutter/material.dart';

class PasswordRecoveryViewModel extends ChangeNotifier {
  final UserAuthentication _authService;
  PasswordRecoveryViewModel({required UserAuthentication authService})
    : _authService = authService;

  String email = '';
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();

  void resetPassword(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      await _authService.resetPassword(email: email.trim());
    } catch (e) {
      // Handle error, e.g., show a message to the user
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
