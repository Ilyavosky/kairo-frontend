import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/confirm_dialog.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/form_error_message.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/goals/data/models/goal.dart';
import 'package:kairo/features/goals/domain/goal_format.dart';
import 'package:kairo/features/goals/presentation/controllers/goal_form_controller.dart';
import 'package:kairo/features/goals/presentation/controllers/goals_controller.dart';
import 'package:kairo/features/goals/presentation/widgets/goal_card.dart';
import 'package:kairo/features/goals/presentation/widgets/goal_history_panel.dart';

class GoalDetailScreen extends ConsumerWidget {
  const GoalDetailScreen({required this.goalId, this.initial, super.key});

  final String goalId;
  final GoalWithProgress? initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(title: 'Detalle de la meta', onBack: () => context.pop()),
        Expanded(child: _body(ref)),
      ],
    );
  }

  Widget _body(WidgetRef ref) {
    final goals = ref.watch(activeGoalsProvider);
    final list = goals.value;
    GoalWithProgress? found;
    for (final item in list ?? const <GoalWithProgress>[]) {
      if (item.goal.id == goalId) {
        found = item;
      }
    }
    found ??= initial?.goal.id == goalId ? initial : null;
    if (found != null) {
      return _GoalDetail(goal: found.goal, item: found);
    }
    final history = ref.watch(goalHistoryProvider).value;
    for (final entry in history ?? const <GoalHistoryEntry>[]) {
      final goal = entry.goal;
      if (goal != null && goal.id == goalId) {
        return _GoalDetail(goal: goal);
      }
    }
    if (list != null && history != null) {
      return const Center(child: Text('Esta meta ya no está disponible.'));
    }
    final error = goals.error;
    if (error != null) {
      return ErrorView(
        message: toAppException(error).message,
        onRetry: () => ref.invalidate(activeGoalsProvider),
      );
    }
    return const Center(
      child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
    );
  }
}

class _GoalDetail extends ConsumerWidget {
  const _GoalDetail({required this.goal, this.item});

  final Goal goal;
  final GoalWithProgress? item;

  Future<void> _deactivate(
    BuildContext context,
    WidgetRef ref,
    String name,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Desactivar meta',
      message:
          'La meta de $name dejará de medirse. Su historial se conserva '
          'y después puedes crear otra igual.',
      confirmLabel: 'Desactivar',
    );
    if (!confirmed || !context.mounted) {
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    final done = await ref
        .read(goalFormControllerProvider.notifier)
        .deactivate(goal.id);
    if (done && context.mounted) {
      context.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Meta de $name desactivada.')));
    }
  }

  List<Widget> _historyItems(
    WidgetRef ref,
    ThemeData theme,
    AsyncValue<List<GoalHistoryEntry>> history,
    String? categoryName,
  ) {
    switch (history) {
      case AsyncData(:final value):
        final entries = [
          for (final entry in value)
            if (entry.evaluation.goalId == goal.id) entry,
        ];
        if (entries.isEmpty) {
          return [
            Text(
              'Todavía no termina ningún periodo de esta meta.',
              style: theme.textTheme.bodySmall,
            ),
          ];
        }
        return [
          for (final entry in entries) ...[
            GoalHistoryTile(entry: entry, categoryName: categoryName),
            const SizedBox(height: KairoSpacing.sm),
          ],
        ];
      case AsyncError(:final error):
        return [
          Text(toAppException(error).message, style: theme.textTheme.bodySmall),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => ref.invalidate(goalHistoryProvider),
              child: const Text('Reintentar'),
            ),
          ),
        ];
      default:
        return const [
          Center(child: CircularProgressIndicator(semanticsLabel: 'Cargando')),
        ];
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final current = item;
    final categories =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    var name = 'esta categoría';
    String? categoryName;
    for (final category in categories) {
      if (category.id == goal.categoryId) {
        categoryName = category.name;
        name = category.name;
      }
    }
    final history = ref.watch(goalHistoryProvider);
    final form = ref.watch(goalFormControllerProvider);
    final loading = form.isLoading;
    final error = form.hasError && !loading
        ? toAppException(form.error!).message
        : null;
    final validFrom = DueLabel.dayMonth(goal.validFrom);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        KairoSpacing.page,
        KairoSpacing.md,
        KairoSpacing.page,
        KairoSpacing.xl,
      ),
      children: [
        if (current != null)
          GoalCard(item: current, categoryName: categoryName)
        else
          _InactiveGoalCard(goal: goal, categoryName: categoryName),
        const SizedBox(height: KairoSpacing.sm),
        Text(
          current != null
              ? 'Activa desde el $validFrom ${goal.validFrom.year}'
              : 'Estuvo activa desde el $validFrom ${goal.validFrom.year}',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: KairoSpacing.xl),
        Text('Periodos anteriores', style: theme.textTheme.titleMedium),
        const SizedBox(height: KairoSpacing.sm),
        ..._historyItems(ref, theme, history, categoryName),
        if (error != null) ...[
          const SizedBox(height: KairoSpacing.lg),
          FormErrorMessage(message: error),
        ],
        if (current != null) ...[
          const SizedBox(height: KairoSpacing.xl),
          FilledButton.icon(
            onPressed: loading
                ? null
                : () => context.go(AppRoutes.editGoal(goal.id), extra: goal),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Cambiar objetivo'),
          ),
          const SizedBox(height: KairoSpacing.md),
          OutlinedButton.icon(
            onPressed: loading ? null : () => _deactivate(context, ref, name),
            icon: const Icon(Icons.pause_circle_outline),
            label: const Text('Desactivar meta'),
          ),
        ],
      ],
    );
  }
}

class _InactiveGoalCard extends StatelessWidget {
  const _InactiveGoalCard({required this.goal, required this.categoryName});

  final Goal goal;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    categoryName ?? 'Meta',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Icon(
                  Icons.pause_circle_outline,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: KairoSpacing.xs),
                Text(
                  'Desactivada',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: KairoSpacing.xs),
            Text(
              '${goal.period.label} · ${goal.type.label} · '
              'Objetivo: ${GoalFormat.amount(goal.type, goal.target)}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
