import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  final LoginViewmodel model;
  const LoginPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Scaffold(
      body: Center(
        child: ListenableBuilder(
          listenable: model,
          builder: (context, child) {
            return model.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Form(
                      key: model.formKey,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              localization.bodyflow,
                              style:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Theme.of(context).textTheme.headlineLarge
                                  : Theme.of(context).textTheme.headlineLarge
                                        ?.copyWith(color: Colors.black),
                            ),
                            SizedBox(height: 50.0),
                            TextFormField(
                              controller: model.emailController,
                              decoration: InputDecoration(
                                labelText: localization.email,
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: model.passwordController,
                              obscureText: model.isPasswordObscured,
                              decoration: InputDecoration(
                                labelText: localization.password,
                                prefixIcon: IconButton(
                                  onPressed: model.togglePasswordVisibility,
                                  icon: Icon(
                                    model.isPasswordObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 66.0),
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => model.login(context),
                                    style: Theme.of(
                                      context,
                                    ).elevatedButtonTheme.style,
                                    child: Text(localization.login),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(localization.dontHaveAccount),
                                    TextButton(
                                      onPressed: () {
                                        context.push(Routes.signUp);
                                        // Handle navigation to signup page
                                      },
                                      child: Text(
                                        localization.signUp,
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                TextButton(
                                  onPressed: () =>
                                      model.goToPasswordRecovery(context),
                                  child: Text(localization.forgotPassword),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
