import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/activities/domain/due_label.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    required this.activity,
    required this.subjectName,
    required this.now,
    required this.onToggle,
    this.onTap,
    super.key,
  });

  final Activity activity;
  final String? subjectName;
  final DateTime now;
  final VoidCallback onToggle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final completed = activity.status == ActivityStatus.completed;
    final due = DueLabel.of(
      dueAt: activity.dueAt,
      now: now,
      completed: completed,
    );
    final dueColor = due.overdue ? scheme.error : scheme.onSurfaceVariant;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            KairoSpacing.xs,
            KairoSpacing.sm,
            KairoSpacing.lg,
            KairoSpacing.sm,
          ),
          child: Row(
            children: [
              Checkbox(
                value: completed,
                onChanged: (_) => onToggle(),
                semanticLabel: completed
                    ? 'Marcar como pendiente ${activity.title}'
                    : 'Completar ${activity.title}',
                shape: const CircleBorder(),
              ),
              const SizedBox(width: KairoSpacing.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        decoration: completed
                            ? TextDecoration.lineThrough
                            : null,
                        color: completed ? scheme.onSurfaceVariant : null,
                      ),
                    ),
                    const SizedBox(height: KairoSpacing.xs),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            subjectName ?? 'Sin materia',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(width: KairoSpacing.sm),
                        Text(
                          due.text,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: dueColor,
                            fontWeight: due.overdue ? FontWeight.w600 : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
