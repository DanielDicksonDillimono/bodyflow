import 'package:bodyflow/ui/core/themes/colors.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/core/wigets/stats_card.dart';
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
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SizedBox(height: 16),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image(image: AssetImage('assets/images/logo.png')),
              //         TextButton(
              //           onPressed: () => viewModel.showAboutPage(context),
              //           child: Text('About BodyFlow'),
              //         ),
              //       ],
              //     ),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           'Sign in or create an account to create workout schedules and to view your personal workout stats',
              //           textAlign: TextAlign.center,
              //           style: Theme.of(context).textTheme.bodyLarge,
              //         ),
              //         SizedBox(
              //           width: double.infinity,
              //           child: ElevatedButton(
              //             onPressed: () => viewModel.signIn(context),
              //             style: Theme.of(context).elevatedButtonTheme.style,
              //             child: const Text('Sign In'),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 16),
                      Container(
                        padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/barbell.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withValues(alpha: 0.5),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Dimens.paddingVerticalSmall),
                            Text(
                              'Last Months Stats',
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            Spacer(),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: viewModel.stats
                                    .map((stat) => StatsCard(stat: stat))
                                    .toList(),
                              ),
                            ),
                            SizedBox(height: Dimens.paddingVerticalSmall),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage('assets/images/logo.png')),
                            TextButton(
                              onPressed: () => viewModel.showAboutPage(context),
                              child: Text('About BodyFlow'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => viewModel.signOut(),
                                style: Theme.of(
                                  context,
                                ).elevatedButtonTheme.style,
                                child: const Text('Sign out'),
                              ),
                            ),
                            TextButton(
                              onPressed: () => viewModel.signOut(),
                              child: Text(
                                'Delete Account',
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(color: AppColors.red1),
                              ),
                            ),
                          ],
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
    );
  }
}
