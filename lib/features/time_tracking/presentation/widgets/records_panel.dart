import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/empty_state.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/data/time_records_api.dart';
import 'package:kairo/features/time_tracking/domain/duration_format.dart';
import 'package:kairo/features/time_tracking/domain/record_groups.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_options.dart';
import 'package:kairo/features/time_tracking/presentation/widgets/time_record_tile.dart';

class RecordsPanel extends ConsumerWidget {
  const RecordsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final records = ref.watch(timeRecordsProvider);

    return Stack(
      children: [
        Positioned.fill(child: _content(context, ref, records)),
        Positioned(
          right: KairoSpacing.page,
          bottom: KairoSpacing.lg,
          child: FloatingActionButton(
            onPressed: () => context.go(AppRoutes.newTimeRecord),
            tooltip: 'Agregar tiempo manual',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _content(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<TimeRecord>> records,
  ) {
    return switch (records) {
      AsyncData(:final value) when value.isEmpty => const EmptyState(
        icon: Icons.history,
        title: 'Aún no tienes registros',
        message:
            'Inicia el temporizador o agrega con el botón + el tiempo '
            'que ya dedicaste.',
      ),
      AsyncData(:final value) => _RecordList(records: value),
      AsyncError(:final error) => ErrorView(
        message: toAppException(error).message,
        onRetry: () => ref.invalidate(timeRecordsProvider),
      ),
      _ => const Center(
        child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
      ),
    };
  }
}

class _RecordList extends ConsumerWidget {
  const _RecordList({required this.records});

  final List<TimeRecord> records;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final categoryList =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    final activityList =
        ref.watch(openActivitiesProvider).value ?? const <Activity>[];
    final categories = {
      for (final category in categoryList) category.id: category.name,
    };
    final activities = {
      for (final activity in activityList) activity.id: activity.title,
    };
    final groups = RecordGroups.of(records, DateTime.now());

    return RefreshIndicator(
      onRefresh: () => ref.refresh(timeRecordsProvider.future),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.md,
          KairoSpacing.page,
          96,
        ),
        children: [
          for (final group in groups) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    group.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                Text(
                  DurationFormat.short(group.total),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: KairoSpacing.xs),
            Wrap(
              spacing: KairoSpacing.sm,
              runSpacing: KairoSpacing.xs,
              children: [
                for (final item in group.categoryTotals)
                  Chip(
                    visualDensity: VisualDensity.compact,
                    label: Text(
                      '${categories[item.categoryId] ?? 'Categoría'} '
                      '${DurationFormat.short(item.total)}',
                    ),
                  ),
              ],
            ),
            const SizedBox(height: KairoSpacing.sm),
            for (final record in group.records) ...[
              TimeRecordTile(
                record: record,
                categoryName: categories[record.categoryId],
                activityTitle: activities[record.activityId],
                onTap: () =>
                    context.go(AppRoutes.timeRecord(record.id), extra: record),
              ),
              const SizedBox(height: KairoSpacing.sm),
            ],
            const SizedBox(height: KairoSpacing.lg),
          ],
        ],
      ),
    );
  }
}
