import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment.dart';
import 'package:kairo/features/self_assessment/domain/self_assessment_scale.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';
import 'package:kairo/features/self_assessment/presentation/controllers/self_assessment_controller.dart';
import 'package:kairo/features/self_assessment/presentation/widgets/self_assessment_tile.dart';

class SelfAssessmentScreen extends ConsumerWidget {
  const SelfAssessmentScreen({super.key});

  void _open(BuildContext context, DateTime week, SelfAssessment? existing) {
    context.go(AppRoutes.selfAssessmentWeek(Week.key(week)), extra: existing);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assessments = ref.watch(selfAssessmentsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(
          title: 'Autoevaluación semanal',
          onBack: () => context.pop(),
        ),
        Expanded(
          child: switch (assessments) {
            AsyncData(:final value) => _content(context, ref, value),
            AsyncError(:final error) => ErrorView(
              message: toAppException(error).message,
              onRetry: () => ref.invalidate(selfAssessmentsProvider),
            ),
            _ => const Center(
              child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
            ),
          },
        ),
      ],
    );
  }

  Widget _content(
    BuildContext context,
    WidgetRef ref,
    List<SelfAssessment> assessments,
  ) {
    final theme = Theme.of(context);
    final monday = Week.mondayOf(DateTime.now());
    SelfAssessment? current;
    final previous = <SelfAssessment>[];
    for (final assessment in assessments) {
      if (Week.same(assessment.weekStart, monday)) {
        current = assessment;
      } else {
        previous.add(assessment);
      }
    }

    return RefreshIndicator(
      onRefresh: () => ref.refresh(selfAssessmentsProvider.future),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.md,
          KairoSpacing.page,
          KairoSpacing.xl,
        ),
        children: [
          _CurrentWeekCard(
            monday: monday,
            assessment: current,
            onOpen: () => _open(context, monday, current),
          ),
          const SizedBox(height: KairoSpacing.xl),
          Text('Semanas anteriores', style: theme.textTheme.titleMedium),
          const SizedBox(height: KairoSpacing.sm),
          if (previous.isEmpty)
            Text(
              'Aún no tienes semanas anteriores evaluadas. Aquí verás cómo '
              'te fue cada semana.',
              style: theme.textTheme.bodyMedium,
            )
          else
            for (final assessment in previous) ...[
              SelfAssessmentTile(
                assessment: assessment,
                onTap: () => _open(context, assessment.weekStart, assessment),
              ),
              const SizedBox(height: KairoSpacing.sm),
            ],
        ],
      ),
    );
  }
}

class _CurrentWeekCard extends StatelessWidget {
  const _CurrentWeekCard({
    required this.monday,
    required this.assessment,
    required this.onOpen,
  });

  final DateTime monday;
  final SelfAssessment? assessment;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final done = assessment;
    final note = done?.note;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Esta semana', style: theme.textTheme.titleMedium),
            const SizedBox(height: KairoSpacing.xs),
            Text(Week.label(monday), style: theme.textTheme.bodySmall),
            const SizedBox(height: KairoSpacing.md),
            if (done == null)
              Text(
                '¿Cómo te fue esta semana? Tómate un minuto para calificar '
                'tu ánimo y qué tan satisfecho estás con lo que lograste.',
                style: theme.textTheme.bodyMedium,
              )
            else ...[
              Text(
                SelfAssessmentScale.summary(done.mood, done.satisfaction),
                style: theme.textTheme.bodyMedium,
              ),
              if (note != null && note.isNotEmpty) ...[
                const SizedBox(height: KairoSpacing.xs),
                Text(note, style: theme.textTheme.bodySmall),
              ],
            ],
            const SizedBox(height: KairoSpacing.lg),
            if (done == null)
              FilledButton(
                onPressed: onOpen,
                child: const Text('Evaluar mi semana'),
              )
            else
              OutlinedButton(
                onPressed: onOpen,
                child: const Text('Editar evaluación'),
              ),
          ],
        ),
      ),
    );
  }
}
