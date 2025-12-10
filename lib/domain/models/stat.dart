import 'package:bodyflow/domain/misc/globalenums.dart';

class Stat {
  late final String title;
  final String value;
  final StatType statType;

  Stat({required this.statType, required this.value}) {
    switch (statType) {
      case StatType.workouts:
        title = "Total Workouts Completed";
        break;
      case StatType.calories:
        title = "Total Calories Burned";
        break;
      case StatType.hours:
        title = "Total Hours Trained";
        break;
      case StatType.day:
        title = "Day with Most Activity";
        break;
      case StatType.bodyPart:
        title = "Most Trained Body Part";
        break;
    }
  }
}
