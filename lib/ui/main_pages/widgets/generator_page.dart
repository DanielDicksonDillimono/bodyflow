import 'package:bodyflow/ui/core/loading.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/main_pages/view_models/generator_page_viewmodel.dart';
import 'package:bodyflow/ui/main_pages/widgets/body_part_selection_grid.dart';
import 'package:bodyflow/ui/main_pages/widgets/day_selection_grid.dart';
import 'package:flutter/material.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';

class GeneratorPage extends StatelessWidget {
  final GeneratorPageViewModel model;
  const GeneratorPage({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListenableBuilder(
            listenable: model,
            builder: (context, value) {
              return model.isGenerating
                  ? const Loading()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: const AssetImage(
                                  'assets/images/barbell.jpg',
                                ),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withValues(alpha: 0.5),
                                  BlendMode.darken,
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Generator',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                                Text(
                                  'Create workout sessions or schedules',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(color: Colors.white70),
                                ),
                                Text(
                                  'Workouts are one-time sessions,'
                                  'while schedules are recurring plans.',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(color: Colors.white70),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: Dimens.of(
                              context,
                            ).edgeInsetsScreenHorizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    model.setActivityAsSession();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      model.activityType == ActivityType.session
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Colors.white,
                                    ),
                                    side: WidgetStatePropertyAll(
                                      BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    shape: WidgetStatePropertyAll(
                                      Theme.of(context).buttonTheme.shape
                                          as OutlinedBorder,
                                    ),
                                    elevation: WidgetStatePropertyAll(0),
                                  ),
                                  child: Text(
                                    'Workout',
                                    style: TextStyle(
                                      color:
                                          model.activityType ==
                                              ActivityType.session
                                          ? Colors.white
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    model.setActivityAsSchedule();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      model.activityType ==
                                              ActivityType.schedule
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Colors.white,
                                    ),
                                    side: WidgetStatePropertyAll(
                                      BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    shape: WidgetStatePropertyAll(
                                      Theme.of(context).buttonTheme.shape
                                          as OutlinedBorder,
                                    ),
                                    elevation: WidgetStatePropertyAll(0),
                                  ),
                                  child: Text(
                                    'Schedule',
                                    style: TextStyle(
                                      color:
                                          model.activityType ==
                                              ActivityType.schedule
                                          ? Colors.white
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: Dimens.of(
                              context,
                            ).edgeInsetsScreenHorizontal,
                            child: model.activityType == ActivityType.schedule
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 32),
                                      Text(
                                        'Split',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      const SizedBox(height: 16),
                                      BodyPartSelectionGrid(
                                        selectedBodyParts:
                                            model.selectedBodyParts,
                                        onBodyPartToggle:
                                            model.addOrRemoveBodyPart,
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'Days',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      const SizedBox(height: 16),
                                      DaySelectionGrid(
                                        selectedDays: model.selectedDays,
                                        onDayToggle: model.addOrRemoveDay,
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Time',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                          children: [
                                            TextSpan(
                                              text: ' (in minutes)',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: model.timeController,
                                        decoration: const InputDecoration(
                                          hintText:
                                              'Enter session length in minutes',
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          final minutes =
                                              int.tryParse(value) ?? 0;
                                          if (minutes > 120) {
                                            model.showGetALifeMessage(context);
                                          } else if (minutes > 0) {
                                            model.setSessionLength(minutes);
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'Target',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      const SizedBox(height: 16),
                                      BodyPartSelectionGrid(
                                        selectedBodyParts:
                                            model.selectedBodyParts,
                                        onBodyPartToggle:
                                            model.addOrRemoveBodyPart,
                                      ),
                                    ],
                                  ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
      floatingActionButton: ListenableBuilder(
        listenable: model,
        builder: (context, value) => model.isGenerating
            ? const SizedBox()
            : FloatingActionButton.extended(
                onPressed: () {
                  model.generateWorkout(context);
                },
                label: const Text('Generate'),
                icon: const Icon(Icons.fitness_center),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
