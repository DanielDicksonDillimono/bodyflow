import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:flutter/material.dart';

class BodyPartSelectionGrid extends StatelessWidget {
  final List<BodyPart> selectedBodyParts;
  final Function(BodyPart) onBodyPartToggle;

  const BodyPartSelectionGrid({
    super.key,
    required this.selectedBodyParts,
    required this.onBodyPartToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3,
      ),
      itemCount: BodyPart.values.length,
      itemBuilder: (context, index) {
        final bodyPart = BodyPart.values[index];
        final isSelected = selectedBodyParts.contains(bodyPart);
        
        return ElevatedButton(
          onPressed: () => onBodyPartToggle(bodyPart),
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
              bodyPart.name,
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
