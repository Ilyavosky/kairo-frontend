import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/empty_state.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/activity_filter.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/activities/presentation/controllers/activities_controller.dart';
import 'package:kairo/features/activities/presentation/widgets/activity_card.dart';
import 'package:kairo/features/activities/presentation/widgets/activity_filters.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';

class ActivitiesScreen extends ConsumerWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activitiesControllerProvider);
    final filter = ref.watch(activityFilterProvider);

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const KairoHeader(title: 'Actividades'),
            const ActivityFilters(),
            Expanded(
              child: switch (activities) {
                AsyncData(:final value) when value.isEmpty => _EmptyActivities(
                  filter: filter,
                ),
                AsyncData(:final value) => _ActivityList(activities: value),
                AsyncError(:final error) => ErrorView(
                  message: toAppException(error).message,
                  onRetry: () => ref.invalidate(activitiesControllerProvider),
                ),
                _ => const Center(
                  child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
                ),
              },
            ),
          ],
        ),
        Positioned(
          right: KairoSpacing.page,
          bottom: KairoSpacing.lg,
          child: FloatingActionButton(
            onPressed: () => context.go(AppRoutes.newActivity),
            tooltip: 'Nueva actividad',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class _EmptyActivities extends StatelessWidget {
  const _EmptyActivities({required this.filter});

  final ActivityFilter filter;

  @override
  Widget build(BuildContext context) {
    final filtered = filter.status != null || filter.subjectId != null;

    return filtered
        ? const EmptyState(
            icon: Icons.filter_alt_off,
            title: 'Nada por aquí',
            message: 'No hay actividades con estos filtros.',
          )
        : const EmptyState(
            icon: Icons.checklist,
            title: 'Aún no tienes actividades',
            message: 'Agrega tareas, exámenes o proyectos para verlos aquí.',
          );
  }
}

class _ActivityList extends ConsumerWidget {
  const _ActivityList({required this.activities});

  final List<Activity> activities;

  Future<void> _toggle(
    BuildContext context,
    WidgetRef ref,
    Activity activity,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final action = activity.status == ActivityStatus.completed
        ? 'marcar como pendiente'
        : 'completar';
    final error = await ref
        .read(activitiesControllerProvider.notifier)
        .toggleCompleted(activity.id);
    if (error != null) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'No se pudo $action "${activity.title}". ${error.message}',
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.watch(subjectsProvider).value ?? const [];
    final names = {for (final subject in subjects) subject.id: subject.name};
    final now = DateTime.now();

    return RefreshIndicator(
      onRefresh: () => ref.refresh(activitiesControllerProvider.future),
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.sm,
          KairoSpacing.page,
          96,
        ),
        itemCount: activities.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: KairoSpacing.sm),
        itemBuilder: (context, index) {
          final activity = activities[index];
          final subjectId = activity.subjectId;
          return ActivityCard(
            key: ValueKey(activity.id),
            activity: activity,
            subjectName: subjectId == null ? null : names[subjectId],
            now: now,
            onToggle: () => _toggle(context, ref, activity),
            onTap: () => context.go(AppRoutes.activity(activity.id)),
          );
        },
      ),
    );
  }
}
