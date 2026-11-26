import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/empty_state.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/goals/presentation/controllers/goals_controller.dart';
import 'package:kairo/features/goals/presentation/widgets/goal_card.dart';

class ActiveGoalsPanel extends ConsumerWidget {
  const ActiveGoalsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(activeGoalsProvider);
    final categories =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    final names = {
      for (final category in categories) category.id: category.name,
    };

    return Stack(
      children: [
        Positioned.fill(child: _content(ref, goals, names)),
        Positioned(
          right: KairoSpacing.page,
          bottom: KairoSpacing.lg,
          child: FloatingActionButton(
            onPressed: () => context.go(AppRoutes.newGoal),
            tooltip: 'Nueva meta',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _content(
    WidgetRef ref,
    AsyncValue<List<GoalWithProgress>> goals,
    Map<String, String> names,
  ) {
    return switch (goals) {
      AsyncData(:final value) when value.isEmpty => const EmptyState(
        icon: Icons.flag_outlined,
        title: 'Aún no tienes metas',
        message:
            'Una meta te ayuda a ver si cumples lo que te propones, '
            'por ejemplo estudiar 5 horas a la semana. '
            'Toca + para crear la primera.',
      ),
      AsyncData(:final value) => RefreshIndicator(
        onRefresh: () => ref.refresh(activeGoalsProvider.future),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            KairoSpacing.page,
            KairoSpacing.md,
            KairoSpacing.page,
            96,
          ),
          itemCount: value.length,
          separatorBuilder: (_, _) => const SizedBox(height: KairoSpacing.md),
          itemBuilder: (context, index) => GoalCard(
            item: value[index],
            categoryName: names[value[index].goal.categoryId],
          ),
        ),
      ),
      AsyncError(:final error) => ErrorView(
        message: toAppException(error).message,
        onRetry: () => ref.invalidate(activeGoalsProvider),
      ),
      _ => const Center(
        child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
      ),
    };
  }
}
