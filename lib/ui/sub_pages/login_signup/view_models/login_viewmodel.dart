import 'package:bodyflow/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class LoginViewmodel {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    // Implement login logic here
  }

  void goToPasswordRecovery(BuildContext context) {
    // Implement password recovery logic here
    context.go(Routes.passwordRecovery);
  }
}
