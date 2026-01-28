import 'package:bodyflow/data/database/database_service.dart';
import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateAccountViewmodel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserAuthentication _authService;
  final DatabaseService _databaseService;
  CreateAccountViewmodel({
    required UserAuthentication authService,
    required DatabaseService databaseService,
  }) : _authService = authService,
       _databaseService = databaseService;

  bool isLoading = false;
  bool termsAccepted = false;
  bool obscureText = true;

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void createAccount(BuildContext context) async {
    if (termsAccepted == false) {
      showErrorMessage(
        formKey.currentContext!,
        AppLocalization.of(formKey.currentContext!).mustAcceptTerms,
      );
      return;
    }
    if (formKey.currentState!.validate()) {
      if (!termsAccepted) {
        showErrorMessage(
          formKey.currentContext!,
          AppLocalization.of(formKey.currentContext!).mustAcceptTerms,
        );
        return;
      }

      isLoading = true;
      notifyListeners();

      await _authService
          .createUserWithEmailAndPassword(
            email: emailController.text
                .trim()
                .toLowerCase(), //not necessary but just in case.
            password: passwordController.text.trim(),
            displayName: fullNameController.text.trim(),
          )
          .then((credentials) async {
            // Account created successfully
            await saveUserData(credentials, fullNameController.text.trim());
            isLoading = false;
            notifyListeners();
            if (context.mounted) {
              context.go(Routes.home);
            }
          })
          .catchError((error) {
            // Handle errors during account creation
            isLoading = false;
            notifyListeners();
            showErrorMessage(formKey.currentContext!, error.toString());
          });
    }
  }

  Future saveUserData(UserCredential userCredential, String fullName) async {
    final userData = {
      'name': fullName,
      'uid': userCredential.user?.uid,
      'email': emailController.text.trim(),
      'createdAt': DateTime.now().toIso8601String(),
    };
    await _databaseService.createUserAccount(userData);
    // Implement user data saving logic here
  }

  void openTermsAndConditions(BuildContext context) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalization.of(context).currentTermsAndConditions,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocalization.of(context).close),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openPrivacyPolicy(BuildContext context) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalization.of(context).currentPrivacyPolicy,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setTermsAccepted(bool? value) {
    termsAccepted = value ?? false;
    notifyListeners();
  }

  void showErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
