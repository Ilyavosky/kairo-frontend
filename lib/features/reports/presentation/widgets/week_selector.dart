import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';

class WeekSelector extends StatelessWidget {
  const WeekSelector({
    required this.weeks,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<DateTime> weeks;
  final DateTime selected;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final index = weeks.indexWhere((week) => Week.same(week, selected));
    final current = Week.same(selected, Week.mondayOf(DateTime.now()));

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KairoSpacing.xs,
          vertical: KairoSpacing.sm,
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: index > 0 ? () => onChanged(weeks[index - 1]) : null,
              tooltip: 'Semana anterior',
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    current ? 'Esta semana' : 'Semana',
                    style: theme.textTheme.labelMedium,
                  ),
                  const SizedBox(height: KairoSpacing.xs),
                  Text(
                    Week.label(selected),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: index >= 0 && index < weeks.length - 1
                  ? () => onChanged(weeks[index + 1])
                  : null,
              tooltip: 'Semana siguiente',
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
