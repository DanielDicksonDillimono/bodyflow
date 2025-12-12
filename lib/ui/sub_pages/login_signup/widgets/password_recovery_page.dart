import 'package:flutter/material.dart';

class PasswordRecoveryPage extends StatelessWidget {
  const PasswordRecoveryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.0),
                Text(
                  'Password\nRecovery',
                  style: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).textTheme.headlineLarge
                      : Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.black,
                        ),
                ),
                SizedBox(height: 50.0),
                Text(
                  'Enter email to receive a password reset link',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
