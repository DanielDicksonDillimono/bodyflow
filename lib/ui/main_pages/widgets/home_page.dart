import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/core/themes/colors.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/main_pages/view_models/home_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' as router;

class HomePage extends StatelessWidget {
  final HomePageViewModel viewModel;

  const HomePage({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.welcome,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Dimens.paddingVerticalLarge),

              // Recently Generated Workouts Schedules Section
              Container(
                padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/schedule.jpg'),
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
                      localization.generatedSchedules,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(color: Colors.white),
                    ),
                    Spacer(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StreamBuilder(
                        stream: viewModel.scheduleStream,
                        builder: (context, snapshot) =>
                            snapshot.connectionState == ConnectionState.waiting
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.appBlue,
                                ),
                              )
                            : snapshot.hasData
                            ? Row(
                                children: buildScheduleCards(
                                  snapshot.data,
                                  context,
                                  localization,
                                ),
                              )
                            : Center(
                                child: Text(
                                  localization.noGeneratedSchedules,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: Dimens.paddingVerticalSmall),
                  ],
                ),
              ),

              // SizedBox(height: Dimens.paddingVerticalLarge),

              // Recently Generated Workouts session Section
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
                      localization.generatedSessions,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(color: Colors.white),
                    ),
                    Spacer(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StreamBuilder(
                        stream: viewModel.sessionStream,
                        builder: (context, snapshot) =>
                            snapshot.connectionState == ConnectionState.waiting
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.appBlue,
                                ),
                              )
                            : snapshot.hasData
                            ? Row(
                                children: buildSessionCards(
                                  snapshot.data,
                                  context,
                                  localization,
                                ),
                              )
                            : Center(
                                child: Text(
                                  localization.noGeneratedSessions,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: Dimens.paddingVerticalSmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: Extract to a widget later.
  Widget sessionCard(Session session, context, AppLocalization localization) {
    return InkWell(
      onTap: () => {
        router.GoRouter.of(context).push(Routes.session, extra: session),
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
                color: AppColors.appBlue.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  session.name,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.grey1),
                ),
              ),
            ),
            SizedBox(
              width: Dimens.textCardWidth(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.white, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(
                        session.durationMinutes.toString(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
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
                        ' ${session.exercises!.length} ${localization.exercises}',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
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
    );
  }

  Widget scheduleCard(
    Schedule schedule,
    context,
    AppLocalization localization,
  ) {
    return InkWell(
      onTap: () => {
        router.GoRouter.of(context).push(Routes.schedule, extra: schedule),
      },
      splashColor: AppColors.appBlue,
      child: Container(
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Dimens.textCardWidth(context),
              height: Dimens.textCardHeight(context),
              decoration: BoxDecoration(
                color: AppColors.appBlue.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  schedule.name,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.grey1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: Dimens.textCardWidth(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_view_month,
                        color: Colors.white,
                        size: 16.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        "${schedule.weeks.length.toString()} ${localization.week}",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildSessionCards(
    List<Session> sessions,
    context,
    AppLocalization localization,
  ) {
    return sessions
        .map((session) => sessionCard(session, context, localization))
        .toList();
  }

  List<Widget> buildScheduleCards(
    List<Schedule> schedules,
    context,
    AppLocalization localization,
  ) {
    return schedules
        .map((schedule) => scheduleCard(schedule, context, localization))
        .toList();
  }
}
