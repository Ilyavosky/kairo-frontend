import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/empty_state.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';

class SubjectsScreen extends ConsumerWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.watch(subjectsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(title: 'Materias', onBack: () => context.pop()),
        Expanded(
          child: switch (subjects) {
            AsyncData(:final value) when value.isEmpty => EmptyState(
              icon: Icons.menu_book,
              title: 'Aún no tienes materias',
              message:
                  'Agrega las materias de tu periodo para organizar '
                  'tus actividades.',
              actionLabel: 'Agregar materia',
              onAction: () => context.go(AppRoutes.newSubject),
            ),
            AsyncData(:final value) => _SubjectList(
              subjects: value,
              onRefresh: () => ref.refresh(subjectsProvider.future),
            ),
            AsyncError(:final error) => ErrorView(
              message: toAppException(error).message,
              onRetry: () => ref.invalidate(subjectsProvider),
            ),
            _ => const Center(
              child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
            ),
          },
        ),
      ],
    );
  }
}

class _SubjectList extends StatelessWidget {
  const _SubjectList({required this.subjects, required this.onRefresh});

  final List<Subject> subjects;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.md,
          KairoSpacing.page,
          KairoSpacing.xl,
        ),
        children: [
          for (final subject in subjects) ...[
            _SubjectCard(subject: subject),
            const SizedBox(height: KairoSpacing.sm),
          ],
          const SizedBox(height: KairoSpacing.md),
          OutlinedButton.icon(
            onPressed: () => context.go(AppRoutes.newSubject),
            icon: const Icon(Icons.add),
            label: const Text('Agregar materia'),
          ),
        ],
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  const _SubjectCard({required this.subject});

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final teacher = subject.teacher;
    final code = subject.code;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(AppRoutes.subject(subject.id)),
        child: Padding(
          padding: const EdgeInsets.all(KairoSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subject.name, style: theme.textTheme.titleSmall),
                    const SizedBox(height: KairoSpacing.xs),
                    Text(
                      teacher ?? 'Sin docente',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: KairoSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (code != null)
                    Text(
                      code,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(height: KairoSpacing.xs),
                  Text(subject.period, style: theme.textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
