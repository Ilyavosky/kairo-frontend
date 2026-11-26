import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/capture/data/models/capture.dart';
import 'package:kairo/features/capture/domain/capture_fields.dart';
import 'package:kairo/features/capture/domain/capture_kind.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_options.dart';

class CaptureReviewCard extends ConsumerWidget {
  const CaptureReviewCard({required this.capture, super.key});

  final Capture capture;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final categories =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    final subjects = ref.watch(subjectsProvider).value ?? const <Subject>[];
    final activities =
        ref.watch(openActivitiesProvider).value ?? const <Activity>[];
    final lookups = (
      categories: {for (final c in categories) c.id: c.name},
      subjects: {for (final s in subjects) s.id: s.name},
      activities: {for (final a in activities) a.id: a.title},
    );
    final confidence = capture.confidence;
    final percent = confidence == null ? null : (confidence * 100).round();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Chip(
                  avatar: Icon(_iconOf(capture.kind), size: 18),
                  label: Text(capture.kind.label),
                  visualDensity: VisualDensity.compact,
                ),
                const Spacer(),
                if (capture.pending.isNotEmpty)
                  Text(
                    capture.pending.length == 1
                        ? '1 dato pendiente'
                        : '${capture.pending.length} datos pendientes',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.error,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: KairoSpacing.sm),
            Text(
              'Esto es lo que entendió Kairo. Revísalo antes de guardar.',
              style: theme.textTheme.bodySmall,
            ),
            if (percent != null) ...[
              const SizedBox(height: KairoSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        KairoSpacing.radiusMd,
                      ),
                      child: LinearProgressIndicator(
                        value: confidence!.clamp(0.0, 1.0),
                        minHeight: 8,
                        backgroundColor: scheme.surfaceContainerHighest,
                        semanticsLabel:
                            'Confianza de la interpretación: '
                            '$percent %',
                      ),
                    ),
                  ),
                  const SizedBox(width: KairoSpacing.md),
                  Text(
                    'Confianza $percent %',
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ],
            const SizedBox(height: KairoSpacing.md),
            const Divider(height: 1),
            for (final key in CaptureFields.keysOf(capture))
              _FieldRow(
                label: CaptureFields.label(key),
                value: CaptureFields.display(capture, key, lookups),
                pending: CaptureFields.isPending(capture, key),
              ),
            const Divider(height: 1),
            Theme(
              data: theme.copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: const EdgeInsets.only(bottom: KairoSpacing.sm),
                title: Text(
                  'Mensaje original',
                  style: theme.textTheme.titleSmall,
                ),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SelectableText(
                      capture.message,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconOf(CaptureKind kind) => switch (kind) {
    CaptureKind.activity => Icons.assignment_outlined,
    CaptureKind.timeRecord => Icons.timer_outlined,
    CaptureKind.goal => Icons.flag_outlined,
  };
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.label,
    required this.value,
    required this.pending,
  });

  final String label;
  final String? value;
  final bool pending;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = value;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: KairoSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: theme.textTheme.bodySmall),
          ),
          Expanded(
            child: pending
                ? Row(
                    children: [
                      Icon(Icons.error_outline, size: 16, color: scheme.error),
                      const SizedBox(width: KairoSpacing.xs),
                      Expanded(
                        child: Text(
                          text == null ? 'Pendiente' : '$text · Pendiente',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.error,
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(text ?? '—', style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
