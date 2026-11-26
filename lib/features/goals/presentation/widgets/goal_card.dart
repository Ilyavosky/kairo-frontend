import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/goals/domain/goal_format.dart';
import 'package:kairo/features/goals/presentation/controllers/goals_controller.dart';
import 'package:kairo/features/goals/presentation/widgets/goal_status.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    required this.item,
    required this.categoryName,
    this.onTap,
    super.key,
  });

  final GoalWithProgress item;
  final String? categoryName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final goal = item.goal;
    final progress = item.progress;
    final amount = GoalFormat.progress(
      goal.type,
      progress.progress,
      progress.target,
    );
    final percent = GoalFormat.percent(progress.percent);
    final name = categoryName ?? 'Categoría';

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(KairoSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(name, style: theme.textTheme.titleMedium),
                  ),
                  GoalStatus(
                    achieved: progress.achieved,
                    pendingLabel: 'En progreso',
                  ),
                ],
              ),
              const SizedBox(height: KairoSpacing.xs),
              Text(
                '${goal.period.label} · ${goal.type.label} · '
                '${goal.period.current}',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: KairoSpacing.md),
              ClipRRect(
                borderRadius: BorderRadius.circular(KairoSpacing.radiusMd),
                child: LinearProgressIndicator(
                  value: GoalFormat.ratio(progress.percent),
                  minHeight: 10,
                  backgroundColor: scheme.surfaceContainerHighest,
                  semanticsLabel: 'Progreso de $name: $amount, $percent',
                ),
              ),
              const SizedBox(height: KairoSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: Text(amount, style: theme.textTheme.bodyMedium),
                  ),
                  Text(
                    percent,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: scheme.primary,
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
