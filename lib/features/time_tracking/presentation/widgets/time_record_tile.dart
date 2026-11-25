import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/domain/duration_format.dart';

class TimeRecordTile extends StatelessWidget {
  const TimeRecordTile({
    required this.record,
    required this.categoryName,
    required this.activityTitle,
    required this.onTap,
    super.key,
  });

  final TimeRecord record;
  final String? categoryName;
  final String? activityTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final start = record.start.toLocal();
    final end = record.end.toLocal();
    final fromTimer = record.origin == 'temporizador';
    final detail = [
      '${DueLabel.hour(start)} – ${DueLabel.hour(end)}',
      activityTitle ?? record.note,
    ].whereType<String>().join(' · ');

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(KairoSpacing.md),
          child: Row(
            children: [
              Icon(
                fromTimer ? Icons.timer_outlined : Icons.edit_calendar,
                color: scheme.secondary,
                semanticLabel: fromTimer ? 'Temporizador' : 'Manual',
              ),
              const SizedBox(width: KairoSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName ?? 'Categoría',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: KairoSpacing.xs),
                    Text(
                      detail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: KairoSpacing.sm),
              Text(
                DurationFormat.short(record.duration),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: scheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
