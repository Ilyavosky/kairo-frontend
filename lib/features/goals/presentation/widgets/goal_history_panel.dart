import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/empty_state.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/goals/domain/goal_format.dart';
import 'package:kairo/features/goals/domain/goal_period.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';
import 'package:kairo/features/goals/presentation/controllers/goals_controller.dart';
import 'package:kairo/features/goals/presentation/widgets/goal_status.dart';

class GoalHistoryPanel extends ConsumerWidget {
  const GoalHistoryPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(goalHistoryProvider);
    final categories =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    final names = {
      for (final category in categories) category.id: category.name,
    };

    return switch (history) {
      AsyncData(:final value) when value.isEmpty => const EmptyState(
        icon: Icons.history,
        title: 'Aún no hay periodos evaluados',
        message:
            'Cuando termine el primer periodo de una meta verás aquí '
            'si la cumpliste.',
      ),
      AsyncData(:final value) => RefreshIndicator(
        onRefresh: () => ref.refresh(goalHistoryProvider.future),
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            KairoSpacing.page,
            KairoSpacing.md,
            KairoSpacing.page,
            KairoSpacing.xl,
          ),
          itemCount: value.length,
          separatorBuilder: (_, _) => const SizedBox(height: KairoSpacing.sm),
          itemBuilder: (context, index) => GoalHistoryTile(
            entry: value[index],
            categoryName: names[value[index].goal?.categoryId],
          ),
        ),
      ),
      AsyncError(:final error) => ErrorView(
        message: toAppException(error).message,
        onRetry: () => ref.invalidate(goalHistoryProvider),
      ),
      _ => const Center(
        child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
      ),
    };
  }
}

class GoalHistoryTile extends StatelessWidget {
  const GoalHistoryTile({
    required this.entry,
    required this.categoryName,
    super.key,
  });

  final GoalHistoryEntry entry;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final evaluation = entry.evaluation;
    final goal = entry.goal;
    final type = goal?.type ?? GoalType.time;
    final period = goal?.period ?? GoalPeriod.week;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryName ?? 'Meta',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: KairoSpacing.xs),
                  Text(
                    GoalFormat.periodRange(
                      period,
                      evaluation.periodStart,
                      evaluation.periodEnd,
                    ),
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: KairoSpacing.xs),
                  Text(
                    GoalFormat.progress(
                      type,
                      evaluation.achievedValue,
                      evaluation.target,
                    ),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            GoalStatus(
              achieved: evaluation.achieved,
              pendingLabel: 'No cumplida',
              pendingIcon: Icons.cancel_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
