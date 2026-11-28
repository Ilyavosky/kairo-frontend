import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/goals/domain/goal_format.dart';
import 'package:kairo/features/goals/presentation/widgets/goal_status.dart';
import 'package:kairo/features/reports/data/models/goal_report.dart';
import 'package:kairo/features/reports/presentation/widgets/report_card.dart';

class GoalsReportCard extends StatelessWidget {
  const GoalsReportCard({required this.goals, super.key});

  final List<GoalReport> goals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReportCard(
      title: 'Progreso de metas',
      subtitle: 'Cómo vas en el periodo actual de cada meta',
      child: goals.isEmpty
          ? Text(
              'No tienes metas activas. Crea una en Metas para ver aquí tu '
              'avance.',
              style: theme.textTheme.bodyMedium,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final goal in goals) ...[
                  _GoalRow(goal: goal),
                  if (goal != goals.last)
                    const SizedBox(height: KairoSpacing.lg),
                ],
              ],
            ),
    );
  }
}

class _GoalRow extends StatelessWidget {
  const _GoalRow({required this.goal});

  final GoalReport goal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final amount = GoalFormat.progress(goal.type, goal.progress, goal.target);
    final percent = GoalFormat.percent(goal.percent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${goal.category} · ${goal.period.label}',
                style: theme.textTheme.titleSmall,
              ),
            ),
            GoalStatus(achieved: goal.achieved, pendingLabel: 'En progreso'),
          ],
        ),
        const SizedBox(height: KairoSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(KairoSpacing.radiusMd),
          child: LinearProgressIndicator(
            value: GoalFormat.ratio(goal.percent),
            minHeight: 10,
            backgroundColor: scheme.surfaceContainerHighest,
            semanticsLabel: 'Progreso de ${goal.category}: $amount, $percent',
          ),
        ),
        const SizedBox(height: KairoSpacing.xs),
        Row(
          children: [
            Expanded(child: Text(amount, style: theme.textTheme.bodySmall)),
            Text(
              percent,
              style: theme.textTheme.titleSmall?.copyWith(
                color: scheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
