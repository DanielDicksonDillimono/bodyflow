import 'package:bodyflow/ui/sub_pages/login_signup/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewmodel(),
      child: Consumer<LoginViewmodel>(
        builder: (context, model, _) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: model.formKey,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BODYFLOW',
                          style: Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(context).textTheme.headlineLarge
                              : Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: Colors.black,
                                ),
                        ),
                        SizedBox(height: 50.0),
                        TextFormField(
                          controller: model.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: model.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 66.0),
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: model.isLoading
                                    ? null
                                    : () => model.login(context),
                                style: Theme.of(context).elevatedButtonTheme.style,
                                child: model.isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Login'),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    context.go('/signup');
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            TextButton(
                              onPressed: () => model.goToPasswordRecovery(context),
                              child: const Text('Forgot Password?'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
