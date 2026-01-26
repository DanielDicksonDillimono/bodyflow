import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/core/themes/colors.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/core/wigets/stats_card.dart';
import 'package:bodyflow/ui/main_pages/view_models/profile_page_viewmodel.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final ProfilePageViewmodel viewModel;
  const ProfilePage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, child) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 16),
                          Container(
                            padding: Dimens.of(
                              context,
                            ).edgeInsetsScreenHorizontal,
                            child: Text(
                              '${localization.allAboutYou}: ${viewModel.userName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: Dimens.of(
                              context,
                            ).edgeInsetsScreenHorizontal,
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
                                  localization.lastMonthsStats,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
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
                                Image(
                                  image: AssetImage('assets/images/logo.png'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      viewModel.showAboutPage(context),
                                  child: Text(localization.aboutBodyflow),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: Dimens.of(
                              context,
                            ).edgeInsetsScreenHorizontal,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (viewModel.userEmail.isNotEmpty)
                                  Text(
                                    viewModel.userEmail,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge,
                                  ),
                                if (viewModel.userEmail.isNotEmpty)
                                  SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => viewModel.signOut(context),
                                    style: Theme.of(
                                      context,
                                    ).elevatedButtonTheme.style,
                                    child: Text(localization.signOut),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      viewModel.deleteAccount(context),
                                  child: Text(
                                    localization.deleteAccount,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
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
              );
            },
          ),
        ),
      ),
    );
  }
}
