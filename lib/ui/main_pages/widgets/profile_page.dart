import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/main_pages/view_models/profile_page_viewmodel.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final ProfilePageViewmodel viewModel = ProfilePageViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: Dimens.of(context).edgeInsetsScreenHorizontal,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/images/logo.png')),
                        TextButton(
                          onPressed: () => viewModel.showAboutPage(context),
                          child: Text('About BodyFlow'),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign in or create an account to create workout schedules and to view your personal workout stats',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => viewModel.signIn(context),
                            style: Theme.of(context).elevatedButtonTheme.style,
                            child: const Text('Sign In'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
