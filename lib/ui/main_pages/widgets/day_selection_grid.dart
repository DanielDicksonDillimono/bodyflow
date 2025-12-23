import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:flutter/material.dart';

class DaySelectionGrid extends StatelessWidget {
  final List<Days> selectedDays;
  final Function(Days) onDayToggle;

  const DaySelectionGrid({
    super.key,
    required this.selectedDays,
    required this.onDayToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 3,
      ),
      itemCount: Days.values.length,
      itemBuilder: (context, index) {
        final day = Days.values[index];
        final isSelected = selectedDays.contains(day);
        
        return ElevatedButton(
          onPressed: () => onDayToggle(day),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
            ),
            side: WidgetStatePropertyAll(
              BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            shape: WidgetStatePropertyAll(
              Theme.of(context).buttonTheme.shape as OutlinedBorder,
            ),
            elevation: const WidgetStatePropertyAll(0),
          ),
          child: FittedBox(
            child: Text(
              day.name,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
