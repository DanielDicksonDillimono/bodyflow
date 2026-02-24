import 'package:bodyflow/ui/core/wigets/loading.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/main_pages/generator/view_models/generator_page_viewmodel.dart';
import 'package:bodyflow/ui/main_pages/generator/widgets/body_part_selection_grid.dart';
import 'package:bodyflow/ui/main_pages/generator/widgets/day_selection_grid.dart';
import 'package:flutter/material.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';

class GeneratorPage extends StatelessWidget {
  final GeneratorPageViewModel model;
  const GeneratorPage({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
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
                                  localization.generator,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                                Text(
                                  localization.generatorSubtitle,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(color: Colors.white70),
                                ),
                                Text(
                                  localization.generatorDescription,
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
                                    localization.session,
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
                                    localization.schedule,
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
                            child:
                                model.activityType ==
                                    ActivityType
                                        .schedule //TODO: Extract session and schedule widgets
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      RichText(
                                        text: TextSpan(
                                          text: localization.numberOfWeeks,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                          children: [
                                            TextSpan(
                                              text: localization.weeksRange,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: model.weekController,
                                        decoration: InputDecoration(
                                          hintText:
                                              localization.enterNumberOfWeeks,
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          final weeks =
                                              int.tryParse(value) ?? 1;
                                          if (weeks > 12) {
                                            model.showTooManyWeeksMessage(
                                              context,
                                            );
                                          } else if (weeks > 0) {
                                            model.setNumberOfWeeks(weeks);
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      RichText(
                                        text: TextSpan(
                                          text: localization.sessionLength,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                          children: [
                                            TextSpan(
                                              text: localization.timeInMinutes,
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
                                        decoration: InputDecoration(
                                          hintText:
                                              localization.enterSessionLength,
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
                                      FittedBox(
                                        child: Row(
                                          children: [
                                            Text(
                                              localization
                                                  .includeBodyweightExercises,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleLarge,
                                            ),
                                            const SizedBox(width: 16),
                                            Checkbox(
                                              value: model
                                                  .includeBodyweightExercises,
                                              onChanged: (value) {
                                                model
                                                    .setIncludeBodyweightExercises(
                                                      value ?? false,
                                                    );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            localization.includeWarmup,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleLarge,
                                          ),
                                          const SizedBox(width: 16),
                                          Checkbox(
                                            value: model.includeWarmup,
                                            onChanged: (value) {
                                              model.setIncludeWarmup(
                                                value ?? false,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            localization.varyWeeklySessions,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleLarge,
                                          ),
                                          const SizedBox(width: 16),
                                          Checkbox(
                                            value: model.varyWeeklySessions,
                                            onChanged: (value) {
                                              model.setVaryWeeklySessions(
                                                value ?? false,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        localization.split,
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
                                        localization.days,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      const SizedBox(height: 16),
                                      DaySelectionGrid(
                                        selectedDays: model.selectedDays,
                                        onDayToggle: model.addOrRemoveDay,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        localization.extraNotes,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      TextFormField(
                                        controller: model.notesController,
                                        decoration: InputDecoration(
                                          hintText:
                                              localization.enterExtraNotes,
                                        ),
                                        maxLines: 3,
                                        onChanged: (value) {
                                          model.setExtraNotes(value);
                                        },
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
                                          text: localization.time,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                          children: [
                                            TextSpan(
                                              text: localization.timeInMinutes,
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
                                        decoration: InputDecoration(
                                          hintText:
                                              localization.enterSessionLength,
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
                                      FittedBox(
                                        child: Row(
                                          children: [
                                            Text(
                                              localization
                                                  .includeBodyweightExercises,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleLarge,
                                            ),
                                            const SizedBox(width: 16),
                                            Checkbox(
                                              value: model
                                                  .includeBodyweightExercises,
                                              onChanged: (value) {
                                                model
                                                    .setIncludeBodyweightExercises(
                                                      value ?? false,
                                                    );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            localization.includeWarmup,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleLarge,
                                          ),
                                          const SizedBox(width: 16),
                                          Checkbox(
                                            value: model.includeWarmup,
                                            onChanged: (value) {
                                              model.setIncludeWarmup(
                                                value ?? false,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        localization.target,
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
                                      const SizedBox(height: 16),
                                      Text(
                                        localization.extraNotes,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      TextFormField(
                                        controller: model.notesController,
                                        decoration: InputDecoration(
                                          hintText:
                                              localization.enterExtraNotes,
                                        ),
                                        maxLines: 3,
                                        onChanged: (value) {
                                          model.setExtraNotes(value);
                                        },
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
                label: Text(localization.generate),
                icon: const Icon(Icons.fitness_center),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
