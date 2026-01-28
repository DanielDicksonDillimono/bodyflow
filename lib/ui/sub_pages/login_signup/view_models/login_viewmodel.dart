import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewmodel extends ChangeNotifier {
  final UserAuthentication _authService;
  LoginViewmodel({required UserAuthentication authService})
    : _authService = authService;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordObscured = true;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    notifyListeners();
  }

  void login(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      isLoading = true;
      notifyListeners();
      _authService
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((_) {
            if (context.mounted) {
              context.go(Routes.home);
            }
          })
          .catchError((error) {
            isLoading = false;
            notifyListeners();
            // Handle login errors here
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(error.toString())));
            }
          });
    }
  }

  void goToPasswordRecovery(BuildContext context) {
    // Implement password recovery logic here
    context.push(Routes.passwordRecovery);
  }
}
