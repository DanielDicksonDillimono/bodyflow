import 'package:bodyflow/domain/models/exercise.dart';
import 'package:bodyflow/navigation/routes.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/core/themes/colors.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/sub_pages/session/view_models/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionPage extends StatelessWidget {
  final SessionViewModel model;

  const SessionPage({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Section with Back Button
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: model.session.imagePath.isNotEmpty
                            ? AssetImage(model.session.imagePath)
                                  as ImageProvider
                            : AssetImage('assets/images/workout_hero.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withValues(alpha: 0.3),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                  // Back Button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Workout Details Section
              Padding(
                padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimens.paddingVertical),
                    // Workout Title
                    Text(
                      model.session.name,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                    SizedBox(height: Dimens.paddingVerticalSmall),
                    // Duration
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        SizedBox(width: 8),
                        Text(
                          model.session.durationMinutes != null
                              ? '${model.session.durationMinutes} ${localization.minutesText}'
                              : localization.durationNotSpecified,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    SizedBox(height: Dimens.paddingVerticalSmall),
                    // Exercises List
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.fitness_center,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            model.session.exercises!
                                .map((exercise) => exercise.name)
                                .join(' |'),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimens.paddingVertical),
                  ],
                ),
              ),
              // Exercise Cards Section
              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                  itemCount: model.session.exercises?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: Dimens.paddingHorizontal),
                  itemBuilder: (context, index) {
                    final exercise =
                        model.session.exercises?[index] ??
                        Exercise(name: localization.unknownExercise);
                    return _buildExerciseCard(context, exercise: exercise);
                  },
                ),
              ),
              SizedBox(height: Dimens.paddingVertical),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    model.deleteSession(context);
                  },
                  child: Text(
                    localization.deleteSession,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard(
    BuildContext context, {
    required Exercise exercise,
  }) {
    // Format display text for the card
    String displayText;
    if (exercise.durationMinutes != null) {
      displayText = '${exercise.durationMinutes} minutes';
    } else if (exercise.sets != null && exercise.reps != null) {
      displayText = '${exercise.sets} sets of ${exercise.reps} reps';
    } else if (exercise.sets != null) {
      displayText = '${exercise.sets} sets';
    } else if (exercise.reps != null) {
      displayText = '${exercise.reps} reps';
    } else {
      displayText = '';
    }

    return InkWell(
      onTap: () {
        context.push(Routes.exercise, extra: exercise);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise Image
            Container(
              width: Dimens.textCardWidth(context),
              height: Dimens.textCardHeight(context),
              decoration: BoxDecoration(
                color: AppColors.appBlue.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  exercise.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Exercise Details
            Container(
              padding: const EdgeInsets.all(12),
              width: Dimens.textCardWidth(context),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    exercise.durationMinutes != null
                        ? Icons.access_time
                        : Icons.fitness_center,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      displayText,
                      style: Theme.of(context).textTheme.bodySmall,
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
