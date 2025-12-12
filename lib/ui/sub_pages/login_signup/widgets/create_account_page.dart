import 'package:bodyflow/ui/sub_pages/login_signup/view_models/create_account_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateAccountViewmodel(),
      child: Consumer<CreateAccountViewmodel>(
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
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 50.0),
                        TextFormField(
                          controller: model.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
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
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: model.confirmPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Repeat Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != model.passwordController.text) {
                              return 'Passwords do not match';
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
                                    : () => model.submit(context),
                                style: Theme.of(context).elevatedButtonTheme.style,
                                child: model.isLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Create Account'),
                              ),
                            ),
                            const SizedBox(height: 16.0),

                            const SizedBox(height: 16.0),
                            TextButton(
                              onPressed: () {
                                context.go('/login');
                              },
                              child: const Text('Already have an account'),
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
