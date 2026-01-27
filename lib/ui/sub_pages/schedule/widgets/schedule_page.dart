import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/core/themes/colors.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/sub_pages/schedule/view_models/schedule_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SchedulePage extends StatelessWidget {
  final ScheduleViewModel model;

  // Default values
  static const String _defaultHeroImage = 'assets/images/squat.jpg';
  static const int _defaultDurationMinutes = 45;

  const SchedulePage({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: model,
          builder: (context, _) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Image Section
                  Container(
                    padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_defaultHeroImage),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withValues(alpha: 0.5),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model.schedule.name,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimens.paddingVertical),

                  // Current Schedule Section
                  Padding(
                    padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.currentSchedule,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: Dimens.paddingVerticalSmall),
                        Row(
                          children: [
                            IconButton(
                              onPressed: model.goToPreviousWeek,
                              icon: Icon(Icons.chevron_left),
                            ),
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            SizedBox(height: Dimens.paddingVerticalSmall),
                            Text(
                              '${localization.week} ${model.currentWeekIndex + 1}/${model.schedule.weeks.length}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            IconButton(
                              onPressed: model.goToNextWeek,
                              icon: Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimens.paddingVerticalSmall),
                        Text(
                          model.schedule.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.7),
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimens.paddingVertical),

                  // Workout Cards Section
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                    child: Row(
                      children: model.getSessionsForWeek().map((daySessionMap) {
                        final day = daySessionMap.keys.first;
                        final session = daySessionMap.values.first;
                        return _buildSessionCard(context, session, day.name);
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: Dimens.paddingVertical),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => model.deleteSchedule(context),
                      child: Text(
                        localization.deleteSchedule,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSessionCard(BuildContext context, Session session, String day) {
    return InkWell(
      onTap: () {
        context.push(Routes.session, extra: session);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

              child: Text(
                day,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.appBlue.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  session.name.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            // Duration Info
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  Icon(
                    Icons.timer,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '${session.durationMinutes ?? _defaultDurationMinutes} ${AppLocalization.of(context).minutesText}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            // Exercise Info
            SizedBox(
              width: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      session.exercises?.map((e) => e.name).join(', ') ??
                          AppLocalization.of(context).squats,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
