import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/core/themes/colors.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  final Schedule schedule;

  const SchedulePage({required this.schedule, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    
    // Get current week sessions (using first week for demo)
    final currentWeekIndex = 0;
    final currentWeek = schedule.weeks.isNotEmpty ? schedule.weeks[currentWeekIndex] : [];
    
    // Extract sessions from the week
    List<Session> sessions = [];
    for (var dayMap in currentWeek) {
      sessions.addAll(dayMap.values);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    image: AssetImage('assets/images/squat.jpg'),
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
                      schedule.name,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localization.currentSchedule,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '${localization.week} ${currentWeekIndex + 1}/${schedule.weeks.length}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimens.paddingVerticalSmall),
                    Text(
                      schedule.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
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
                  children: sessions.map((session) {
                    return _buildWorkoutCard(context, session);
                  }).toList(),
                ),
              ),
              SizedBox(height: Dimens.paddingVertical),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, Session session) {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
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
                  '${session.durationMinutes ?? 45} ${AppLocalization.of(context).minutesText}',
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
                    session.exercises
                            ?.map((e) => e.name)
                            .join(', ') ??
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
    );
  }
}
