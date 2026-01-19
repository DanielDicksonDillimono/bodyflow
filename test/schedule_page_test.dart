import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/exercise.dart';
import 'package:bodyflow/domain/models/schedule.dart';
import 'package:bodyflow/domain/models/session.dart';
import 'package:bodyflow/ui/core/localization/applocalization.dart';
import 'package:bodyflow/ui/sub_pages/schedule/view_models/schedule_viewmodel.dart';
import 'package:bodyflow/ui/sub_pages/schedule/widgets/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SchedulePage Widget Tests', () {
    testWidgets('SchedulePage renders with schedule data', (
      WidgetTester tester,
    ) async {
      // Create sample data
      final exercises = [
        Exercise(name: 'squats'),
        Exercise(name: 'deadlifts'),
        Exercise(name: 'lunges'),
      ];

      final legsSession = Session(
        name: 'Legs',
        description: 'Leg workout',
        imagePath: 'assets/images/squat.jpg',
        durationMinutes: 45,
        exercises: exercises,
      );

      final shouldersSession = Session(
        name: 'Shoulders',
        description: 'Shoulder workout',
        imagePath: 'assets/images/barbell.jpg',
        durationMinutes: 45,
        exercises: exercises,
      );

      final schedule = Schedule(
        name: 'Body Blaster',
        description:
            'Yada Daba du. Something about this workout schedule. It is about goal and efficiency.',
        weeks: [
          [
            {Days.monday: legsSession},
            {Days.wednesday: shouldersSession},
          ],
          [
            {Days.monday: legsSession},
            {Days.wednesday: shouldersSession},
          ],
        ],
      );

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [AppLocalizationDelegate()],
          home: SchedulePage(model: ScheduleViewModel(schedule: schedule)),
        ),
      );

      // Verify the schedule name is displayed
      expect(find.text('Body Blaster'), findsOneWidget);

      // Verify the Current Schedule heading is displayed
      expect(find.text('Current Schedule'), findsOneWidget);

      // Verify the week indicator is displayed
      expect(find.textContaining('week'), findsOneWidget);

      // Verify session names are displayed
      expect(find.text('LEGS'), findsOneWidget);
      expect(find.text('SHOULDERS'), findsOneWidget);
    });
  });
}
