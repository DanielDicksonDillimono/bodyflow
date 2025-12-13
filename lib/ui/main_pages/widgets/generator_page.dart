import 'package:bodyflow/ui/core/loading.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:bodyflow/ui/main_pages/view_models/generator_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GeneratorPageViewModel>(context, listen: false);
    //final double height = MediaQuery.of(context).size.height * 0.8;
    return Scaffold(
      body: SafeArea(
        // child: CustomScrollView(
        //   slivers: [
        //     SliverPersistentHeader(
        //       delegate: GeneratorPageHeader(height),
        //       pinned: true,
        //     ),
        //     ListenableBuilder(
        //       listenable: model,
        //       builder: (context, child) => SliverFloatingHeader(
        //         child: Padding(
        //           padding: Dimens.of(context).edgeInsetsScreenHorizontal,
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        //             children: [
        //               ElevatedButton(
        //                 onPressed: () {
        //                   model.setActivityAsSession();
        //                 },
        //                 style: ButtonStyle(
        //                   backgroundColor: WidgetStateProperty.all(
        //                     model.activityType == ActivityType.session
        //                         ? Theme.of(context).colorScheme.primary
        //                         : Theme.of(
        //                             context,
        //                           ).colorScheme.primaryContainer,
        //                   ),
        //                 ),
        //                 child: Text('Session'),
        //               ),
        //               ElevatedButton(
        //                 onPressed: () {
        //                   model.setActivityAsSchedule();
        //                 },
        //                 style: ButtonStyle(
        //                   backgroundColor: WidgetStateProperty.all(
        //                     model.activityType == ActivityType.schedule
        //                         ? Theme.of(context).colorScheme.primary
        //                         : Theme.of(
        //                             context,
        //                           ).colorScheme.primaryContainer,
        //                   ),
        //                 ),
        //                 child: Text('Schedule'),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //     SliverList.builder(
        //       itemCount: model.items.length,
        //       itemBuilder: (context, index) {
        //         final item = model.items[index];
        //         return ListTile(
        //           title: Text(item.title ?? ''),
        //           subtitle: Text(item.subtitle ?? ''),
        //         );
        //       },
        //     ),
        //   ],
        // ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListenableBuilder(
            listenable: model,
            builder: (context, value) {
              return model.isGenerating
                  ? Loading()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
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
                                //SizedBox(height: 8),
                                Text(
                                  'Create workout sessions or schedules',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(color: Colors.white70),
                                ),
                                Text(
                                  'Sessions are one-time workouts,'
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
                                    'Session',
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
                                        'Select Body Parts',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      const SizedBox(height: 16),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        // padding: Dimens.of(
                                        //   context,
                                        // ).edgeInsetsScreenHorizontal,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: 3,
                                            ),
                                        itemCount: BodyPart.values.length,
                                        itemBuilder: (context, index) {
                                          final bodyPart =
                                              BodyPart.values[index];
                                          return ElevatedButton(
                                            onPressed: () {
                                              // Handle button press
                                              model.addOrRemoveBodyPart(
                                                bodyPart,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                    model.selectedBodyParts
                                                            .contains(bodyPart)
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
                                                Theme.of(
                                                      context,
                                                    ).buttonTheme.shape
                                                    as OutlinedBorder,
                                              ),
                                              elevation: WidgetStatePropertyAll(
                                                0,
                                              ),
                                            ),
                                            child: FittedBox(
                                              child: Text(
                                                bodyPart.name,
                                                style: TextStyle(
                                                  color:
                                                      model.selectedBodyParts
                                                          .contains(bodyPart)
                                                      ? Colors.white
                                                      : Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 32),
                                      Text(
                                        'Select Days',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      const SizedBox(height: 16),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        // padding: Dimens.of(
                                        //   context,
                                        // ).edgeInsetsScreenHorizontal,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 16,
                                              crossAxisSpacing: 16,
                                              childAspectRatio: 3,
                                            ),
                                        itemCount: Days.values.length,
                                        itemBuilder: (context, index) {
                                          final day = Days.values[index];
                                          return ElevatedButton(
                                            onPressed: () {
                                              // Handle button press
                                              model.addOrRemoveDay(day);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                    model.selectedDays.contains(
                                                          day,
                                                        )
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
                                                Theme.of(
                                                      context,
                                                    ).buttonTheme.shape
                                                    as OutlinedBorder,
                                              ),
                                              elevation: WidgetStatePropertyAll(
                                                0,
                                              ),
                                            ),
                                            child: FittedBox(
                                              child: Text(
                                                day.name,
                                                style: TextStyle(
                                                  color:
                                                      model.selectedDays
                                                          .contains(day)
                                                      ? Colors.white
                                                      : Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                ),
                                              ),
                                            ),
                                          );
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
                                          text: 'Session Length',
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
                                        key: model.timeKey,
                                        controller: model.timeController,

                                        decoration: InputDecoration(
                                          hintText:
                                              'Enter session length in minutes',
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          final minutes =
                                              int.tryParse(value) ?? 0;
                                          minutes > 120
                                              ? model.showGetALifeMessage(
                                                  context,
                                                )
                                              : model.setSessionLength(minutes);
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
                                      GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: 3,
                                            ),
                                        itemCount: BodyPart.values.length,
                                        itemBuilder: (context, index) {
                                          final bodyPart =
                                              BodyPart.values[index];
                                          return ElevatedButton(
                                            onPressed: () {
                                              // Handle button press
                                              model.addOrRemoveBodyPart(
                                                bodyPart,
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                    model.selectedBodyParts
                                                            .contains(bodyPart)
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
                                                Theme.of(
                                                      context,
                                                    ).buttonTheme.shape
                                                    as OutlinedBorder,
                                              ),
                                              elevation: WidgetStatePropertyAll(
                                                0,
                                              ),
                                            ),
                                            child: FittedBox(
                                              child: Text(
                                                bodyPart.name,
                                                style: TextStyle(
                                                  color:
                                                      model.selectedBodyParts
                                                          .contains(bodyPart)
                                                      ? Colors.white
                                                      : Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                          ),
                          SizedBox(height: 80),
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
            ? SizedBox()
            : FloatingActionButton.extended(
                onPressed: () {
                  model.generateWorkout();
                },
                label: Text('Generate'),
                icon: const Icon(Icons.fitness_center),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
