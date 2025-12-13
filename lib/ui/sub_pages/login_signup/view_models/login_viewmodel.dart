import 'package:bodyflow/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class LoginViewmodel extends ChangeNotifier {
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
