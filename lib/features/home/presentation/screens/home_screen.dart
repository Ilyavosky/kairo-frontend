import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/home/domain/agenda.dart';
import 'package:kairo/features/home/presentation/controllers/agenda_controller.dart';
import 'package:kairo/features/home/presentation/widgets/agenda_day_section.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agenda = ref.watch(agendaProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const KairoHeader(title: 'Inicio'),
        Expanded(
          child: switch (agenda) {
            AsyncData(:final value) => _AgendaList(days: value),
            AsyncError(:final error) => ErrorView(
              message: toAppException(error).message,
              onRetry: () => ref.invalidate(agendaProvider),
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

class _AgendaList extends ConsumerWidget {
  const _AgendaList({required this.days});

  final List<AgendaDay> days;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final subjects = ref.watch(subjectsProvider).value ?? const [];
    final names = {for (final subject in subjects) subject.id: subject.name};
    final now = DateTime.now();
    final pending = days.fold<int>(
      0,
      (total, day) => total + day.activities.length,
    );

    return RefreshIndicator(
      onRefresh: () => ref.refresh(agendaProvider.future),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.sm,
          KairoSpacing.page,
          KairoSpacing.xl,
        ),
        children: [
          Text('Próximos 7 días', style: theme.textTheme.titleLarge),
          const SizedBox(height: KairoSpacing.xs),
          Text(switch (pending) {
            0 => 'No tienes entregas esta semana.',
            1 => 'Tienes 1 entrega esta semana.',
            _ => 'Tienes $pending entregas esta semana.',
          }, style: theme.textTheme.bodyMedium),
          const SizedBox(height: KairoSpacing.xl),
          for (final day in days) ...[
            AgendaDaySection(
              day: day,
              now: now,
              subjectNames: names,
              onActivityTap: (activity) => context.go(
                AppRoutes.homeActivity(activity.id),
                extra: activity,
              ),
            ),
            const SizedBox(height: KairoSpacing.xl),
          ],
        ],
      ),
    );
  }
}
