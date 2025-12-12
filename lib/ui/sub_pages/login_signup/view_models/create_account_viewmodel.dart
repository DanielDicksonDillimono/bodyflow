import 'package:bodyflow/data/services/user_authentication.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateAccountViewmodel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showErrorMessage(context, 'Passwords do not match');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final authService = Provider.of<UserAuthentication>(context, listen: false);
      await authService.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      
      if (context.mounted) {
        context.go(Routes.home);
      }
    } catch (e) {
      if (context.mounted) {
        showErrorMessage(context, e.toString().replaceAll('Exception: ', ''));
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void returnToLogin(BuildContext context) {
    context.go(Routes.login);
  }

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
