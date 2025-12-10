import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/domain/models/stat.dart';
import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final Stat stat;
  late final Icon icon;

  StatsCard({super.key, required this.stat}) {
    switch (stat.statType) {
      case StatType.workouts:
        icon = const Icon(Icons.fitness_center, color: Colors.white);
        break;
      case StatType.calories:
        icon = const Icon(Icons.local_fire_department, color: Colors.white);
        break;
      case StatType.hours:
        icon = const Icon(Icons.access_time, color: Colors.white);
        break;
      case StatType.day:
        icon = const Icon(Icons.calendar_today, color: Colors.white);
        break;
      case StatType.bodyPart:
        icon = const Icon(Icons.self_improvement, color: Colors.white);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle card tap if needed
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: icon,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stat.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    stat.value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
