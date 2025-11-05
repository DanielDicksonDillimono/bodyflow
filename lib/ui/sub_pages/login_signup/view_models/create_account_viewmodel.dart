import 'package:flutter/material.dart';

class CreateAccountViewmodel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool termsAccepted = false;

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      // Handle account creation logic here
    }
  }

  void returnToLogin() {
    // Handle navigation back to login page
  }

  void openTermsAndConditions() {
    // Handle opening terms and conditions
  }

  void openPrivacyPolicy() {
    // Handle opening privacy policy
  }

  void showErrorMessage(BuildContext context, String message) {
    // Handle displaying error messages to the user
  }
}
