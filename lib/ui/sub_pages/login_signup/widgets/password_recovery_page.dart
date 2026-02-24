import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/view_models/password_recovery_viewmodel.dart';
import 'package:flutter/material.dart';

class PasswordRecoveryPage extends StatelessWidget {
  final PasswordRecoveryViewModel viewModel;
  const PasswordRecoveryPage({super.key, required this.viewModel});
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return viewModel.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 100.0),
                          Text(
                            localization.passwordRecovery,
                            style:
                                Theme.of(context).brightness == Brightness.dark
                                ? Theme.of(context).textTheme.headlineLarge
                                : Theme.of(context).textTheme.headlineLarge
                                      ?.copyWith(color: Colors.black),
                          ),
                          SizedBox(height: 50.0),
                          Text(
                            localization.passwordResetInstruction,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: viewModel.emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => viewModel.email = value,
                            decoration: InputDecoration(
                              labelText: localization.email,
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                viewModel.resetPassword(context);
                              },
                              style: Theme.of(
                                context,
                              ).elevatedButtonTheme.style,
                              child: Text(localization.reset),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
