import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/reports/data/models/report_summary.dart';
import 'package:kairo/features/reports/presentation/controllers/reports_controller.dart';
import 'package:kairo/features/reports/presentation/widgets/report_card.dart';

class SummaryCard extends ConsumerWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(reportSummaryProvider);

    return ReportCard(
      title: 'Resumen de tu semana',
      subtitle: 'Redactado a partir de tus cifras',
      child: switch (summary) {
        AsyncData(:final value) => _text(context, ref, value),
        AsyncError(:final error) => _message(
          context,
          ref,
          toAppException(error).message,
        ),
        _ => const _SummarySkeleton(key: ValueKey('resumen-cargando')),
      },
    );
  }

  Widget _text(BuildContext context, WidgetRef ref, ReportSummary summary) {
    final text = summary.text;
    if (text == null || text.trim().isEmpty) {
      return _message(
        context,
        ref,
        'Por ahora no se pudo redactar el resumen. Tus gráficas sí están '
        'al día.',
      );
    }
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }

  Widget _message(BuildContext context, WidgetRef ref, String message) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(message, style: theme.textTheme.bodyMedium),
        const SizedBox(height: KairoSpacing.sm),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => ref.invalidate(reportSummaryProvider),
            child: const Text('Intentar de nuevo'),
          ),
        ),
      ],
    );
  }
}

class _SummarySkeleton extends StatelessWidget {
  const _SummarySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;

    return Semantics(
      label: 'Redactando el resumen',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final widthFactor in const [1.0, 0.9, 0.6]) ...[
            FractionallySizedBox(
              widthFactor: widthFactor,
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: KairoSpacing.sm),
          ],
        ],
      ),
    );
  }
}
