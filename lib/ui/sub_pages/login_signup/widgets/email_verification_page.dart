import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/view_models/email_verification_viewmodel.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatelessWidget {
  final EmailVerificationViewmodel viewModel;

  const EmailVerificationPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: Dimens.of(context).edgeInsetsScreenHorizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalization.of(context).emailVerification,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 20),
              Text(
                AppLocalization.of(context).emailVerificationMessage,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => viewModel.sendVerificationEmail(context),
                child: Text(
                  AppLocalization.of(context).resendVerificationEmail,
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => viewModel.checkValidation(context),
                child: Text(AppLocalization.of(context).iHaveVerifiedMyEmail),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
