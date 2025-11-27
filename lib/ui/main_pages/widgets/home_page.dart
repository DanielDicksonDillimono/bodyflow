import 'package:bodyflow/ui/core/themes/colors.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/sub_pages/login_signup/widgets/workout_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Dimens.paddingVerticalLarge),
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
                      'Recently generated',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(color: Colors.white),
                    ),
                    Spacer(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          //turn this into a listview builde. Using this as a card.
                          InkWell(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WorkoutPage(),
                                ),
                              ),
                            },
                            splashColor: AppColors.appBlue,
                            child: Container(
                              margin: const EdgeInsets.only(right: 12.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: Dimens.textCardWidth(context),
                                    height: Dimens.textCardHeight(context),
                                    decoration: BoxDecoration(
                                      color: AppColors.appBlue.withValues(
                                        alpha: 0.8,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Workout A',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: AppColors.grey1),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimens.textCardWidth(context),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer,
                                              color: Colors.white,
                                              size: 16.0,
                                            ),
                                            SizedBox(width: 4.0),
                                            Text(
                                              '45 mins',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.fitness_center,
                                              color: Colors.white,
                                              size: 16.0,
                                            ),
                                            Text(
                                              'Full Body Blast',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Colors.white,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 12.0),
                            child: Column(
                              children: [
                                Container(
                                  width: Dimens.textCardWidth(context),
                                  height: Dimens.textCardHeight(context),
                                  decoration: BoxDecoration(
                                    color: AppColors.appBlue.withValues(
                                      alpha: 0.8,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Workout A',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: AppColors.grey1),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimens.textCardWidth(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            color: Colors.white,
                                            size: 16.0,
                                          ),
                                          SizedBox(width: 4.0),
                                          Text(
                                            '45 mins',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.fitness_center,
                                            color: Colors.white,
                                            size: 16.0,
                                          ),
                                          Text(
                                            'Full Body Blast',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 12.0),
                            child: Column(
                              children: [
                                Container(
                                  width: Dimens.textCardWidth(context),
                                  height: Dimens.textCardHeight(context),
                                  decoration: BoxDecoration(
                                    color: AppColors.appBlue.withValues(
                                      alpha: 0.8,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Workout A',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: AppColors.grey1),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimens.textCardWidth(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            color: Colors.white,
                                            size: 16.0,
                                          ),
                                          SizedBox(width: 4.0),
                                          Text(
                                            '45 mins',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.fitness_center,
                                            color: Colors.white,
                                            size: 16.0,
                                          ),
                                          Text(
                                            'Full Body Blast',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimens.paddingVerticalSmall),
                  ],
                ),
              ),
              // SizedBox(height: Dimens.paddingVerticalLarge),
              Container(
                padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/boxjump.jpg'),
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
                      'Quick Workouts',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
