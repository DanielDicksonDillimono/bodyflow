import 'package:bodyflow/domain/models/exercise.dart';
import 'package:bodyflow/ui/core/themes/dimens.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  final Exercise exercise;

  const ExercisePage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
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
                      image: exercise.imagePath != null
                          ? DecorationImage(
                              image: AssetImage(exercise.imagePath!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withValues(alpha: 0.3),
                                BlendMode.darken,
                              ),
                            )
                          : null,
                      color: exercise.imagePath == null
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                    ),
                    child: exercise.imagePath == null
                        ? Center(
                            child: Icon(
                              Icons.fitness_center,
                              size: 80,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          )
                        : null,
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
              // Exercise Details Section
              Padding(
                padding: Dimens.of(context).edgeInsetsScreenHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimens.paddingVertical),
                    // Exercise Title
                    Text(
                      exercise.name.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                    ),
                    SizedBox(height: Dimens.paddingVerticalSmall),
                    // Difficulty badge
                    if (exercise.difficulty != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(context, exercise.difficulty!),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          exercise.difficulty!.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      SizedBox(height: Dimens.paddingVertical),
                    ],
                    // Description
                    if (exercise.description != null) ...[
                      Text(
                        exercise.description!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: Dimens.paddingVertical),
                    ],
                    // Exercise Stats
                    if (exercise.sets != null || exercise.reps != null || exercise.durationMinutes != null)
                      _buildStatsSection(context),
                    // Instructions
                    if (exercise.instructions != null) ...[
                      SizedBox(height: Dimens.paddingVertical),
                      Text(
                        'Instructions',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: Dimens.paddingVerticalSmall),
                      Text(
                        exercise.instructions!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    SizedBox(height: Dimens.paddingVertical),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (exercise.sets != null)
            _buildStatItem(
              context,
              icon: Icons.repeat,
              label: 'Sets',
              value: '${exercise.sets}',
            ),
          if (exercise.reps != null)
            _buildStatItem(
              context,
              icon: Icons.fitness_center,
              label: 'Reps',
              value: '${exercise.reps}',
            ),
          if (exercise.durationMinutes != null)
            _buildStatItem(
              context,
              icon: Icons.access_time,
              label: 'Duration',
              value: '${exercise.durationMinutes} min',
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Color _getDifficultyColor(BuildContext context, String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }
}
