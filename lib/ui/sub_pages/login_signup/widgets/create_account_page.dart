import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/view_models/create_account_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateAccountPage extends StatelessWidget {
  final CreateAccountViewmodel viewModel;
  const CreateAccountPage({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, value) {
              return Form(
                key: viewModel.formKey,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localization.bodyflow,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 50.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: localization.fullName,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localization.fullNameRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: localization.email,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localization.emailRequired;
                          }
                          final emailRegex = RegExp(localization.emailRegex);
                          if (!emailRegex.hasMatch(value)) {
                            return localization.invalidEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: localization.password,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: IconButton(
                            onPressed: viewModel.toggleObscureText,
                            icon: Icon(
                              viewModel.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        obscureText: viewModel.obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localization.passwordRequired;
                          }
                          if (value.length < 6) {
                            return localization.passwordTooShort;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: localization.repeatPassword,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          prefixIcon: IconButton(
                            onPressed: viewModel.toggleObscureText,
                            icon: Icon(
                              viewModel.obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        obscureText: viewModel.obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localization.confirmPasswordRequired;
                          }
                          if (value != viewModel.passwordController.text) {
                            return localization.passwordsDoNotMatch;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Checkbox(
                            value: viewModel.termsAccepted,
                            onChanged: (value) {
                              viewModel.setTermsAccepted(value ?? false);
                            },
                          ),
                          TextButton(
                            onPressed: () =>
                                viewModel.openTermsAndConditions(context),
                            child: Text(
                              '${localization.iAccept} ${localization.termsAndConditions}',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () => viewModel.openPrivacyPolicy(context),
                        child: Text(
                          '${localization.iAccept} ${localization.privacyPolicy}',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Text(
                        localization.disclaimer,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 66.0),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: viewModel.createAccount,
                              style: Theme.of(
                                context,
                              ).elevatedButtonTheme.style,
                              child: Text(localization.createAccount),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const SizedBox(height: 16.0),
                          TextButton(
                            onPressed: () {
                              context.push(Routes.login);
                            },
                            child: Text(localization.alreadyHaveAccount),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
