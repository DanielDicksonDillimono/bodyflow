import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:flutter/material.dart';

class CreateAccountViewmodel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserAuthentication _authService;
  CreateAccountViewmodel({required UserAuthentication authService})
    : _authService = authService;

  bool isLoading = false;
  bool termsAccepted = false;
  bool obscureText = true;

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void createAccount() {
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

      _authService
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((_) {
            // Account created successfully
            isLoading = false;
            notifyListeners();
            // Navigate to next page or show success message
          })
          .catchError((error) {
            // Handle errors during account creation
            isLoading = false;
            notifyListeners();
            showErrorMessage(formKey.currentContext!, error.toString());
          });
    }
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
