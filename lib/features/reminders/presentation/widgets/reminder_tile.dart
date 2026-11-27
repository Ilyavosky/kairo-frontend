import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/reminders/data/models/reminder.dart';
import 'package:kairo/features/reminders/domain/reminder_groups.dart';
import 'package:kairo/features/reminders/domain/reminder_status.dart';
import 'package:kairo/features/reminders/domain/reminder_target.dart';

class ReminderTile extends StatelessWidget {
  const ReminderTile({
    required this.reminder,
    required this.title,
    this.onCancel,
    super.key,
  });

  final Reminder reminder;
  final String title;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final when = (reminder.sentAt ?? reminder.moment).toLocal();
    final pending = reminder.status == ReminderStatus.pending;
    final detail = [
      reminder.target.label,
      '${DueLabel.shortDate(when)}, ${DueLabel.hour(when)}',
      if (!pending) reminder.status.label,
    ].join(' · ');
    final cancel = onCancel;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.md,
          KairoSpacing.md,
          KairoSpacing.xs,
          KairoSpacing.md,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: scheme.secondary.withValues(alpha: 0.12),
              child: Icon(_iconOf(reminder.target), color: scheme.primary),
            ),
            const SizedBox(width: KairoSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleSmall),
                  const SizedBox(height: KairoSpacing.xs),
                  Text(
                    detail,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: reminder.status == ReminderStatus.failed
                          ? scheme.error
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            if (cancel != null)
              IconButton(
                onPressed: cancel,
                tooltip: 'Quitar recordatorio',
                icon: const Icon(Icons.close),
              ),
          ],
        ),
      ),
    );
  }

  IconData _iconOf(ReminderTarget target) => switch (target) {
    ReminderTarget.activity => Icons.assignment_outlined,
    ReminderTarget.event => Icons.event_outlined,
    ReminderTarget.goal => Icons.flag_outlined,
  };
}
