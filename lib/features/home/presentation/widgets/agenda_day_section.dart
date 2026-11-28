import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/home/data/models/calendar_event.dart';
import 'package:kairo/features/home/domain/agenda.dart';

class AgendaDaySection extends StatelessWidget {
  const AgendaDaySection({
    required this.day,
    required this.now,
    required this.subjectNames,
    required this.onActivityTap,
    super.key,
  });

  final AgendaDay day;
  final DateTime now;
  final Map<String, String> subjectNames;
  final ValueChanged<Activity> onActivityTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              Agenda.dayTitle(day.date, now),
              style: theme.textTheme.titleMedium?.copyWith(
                color: scheme.primary,
              ),
            ),
            const SizedBox(width: KairoSpacing.sm),
            Text(
              Agenda.isNear(day.date, now)
                  ? DueLabel.shortDate(day.date)
                  : DueLabel.dayMonth(day.date),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: KairoSpacing.sm),
        if (day.isEmpty)
          Text(
            'Nada para este día',
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        for (final event in day.events) ...[
          _EventTile(event: event),
          const SizedBox(height: KairoSpacing.sm),
        ],
        for (final event in day.personalEvents) ...[
          _PersonalEventTile(event: event, day: day.date),
          const SizedBox(height: KairoSpacing.sm),
        ],
        for (final activity in day.activities) ...[
          _ActivityTile(
            activity: activity,
            subjectName: subjectNames[activity.subjectId],
            overdue: activity.dueAt!.isBefore(now),
            onTap: () => onActivityTap(activity),
          ),
          const SizedBox(height: KairoSpacing.sm),
        ],
      ],
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(KairoSpacing.radiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.md),
        child: Row(
          children: [
            Icon(Icons.event_note, color: scheme.secondary),
            const SizedBox(width: KairoSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.description, style: theme.textTheme.titleSmall),
                  const SizedBox(height: KairoSpacing.xs),
                  Text(
                    Agenda.eventLabels[event.type] ?? 'Calendario académico',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonalEventTile extends StatelessWidget {
  const _PersonalEventTile({required this.event, required this.day});

  final Event event;
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final start = event.start.toLocal();
    final startsToday =
        start.year == day.year &&
        start.month == day.month &&
        start.day == day.day;
    final place = event.place;
    final detail = [
      if (!startsToday) 'Continúa',
      event.type.label,
      if (place != null && place.isNotEmpty) place,
    ].join(' · ');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.md),
        child: Row(
          children: [
            SizedBox(
              width: 52,
              child: Text(
                startsToday ? DueLabel.hour(start) : '—',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: scheme.secondary,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: theme.textTheme.titleSmall),
                  const SizedBox(height: KairoSpacing.xs),
                  Text(detail, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            Icon(Icons.event, color: scheme.secondary),
          ],
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.activity,
    required this.subjectName,
    required this.overdue,
    required this.onTap,
  });

  final Activity activity;
  final String? subjectName;
  final bool overdue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(KairoSpacing.md),
          child: Row(
            children: [
              SizedBox(
                width: 52,
                child: Text(
                  DueLabel.hour(activity.dueAt!.toLocal()),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: overdue ? scheme.error : scheme.secondary,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(activity.title, style: theme.textTheme.titleSmall),
                    const SizedBox(height: KairoSpacing.xs),
                    Text(
                      subjectName ?? 'Sin materia',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
