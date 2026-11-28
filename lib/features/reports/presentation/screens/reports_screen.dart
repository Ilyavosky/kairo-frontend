import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/reports/domain/report_weeks.dart';
import 'package:kairo/features/reports/presentation/controllers/reports_controller.dart';
import 'package:kairo/features/reports/presentation/widgets/goals_report_card.dart';
import 'package:kairo/features/reports/presentation/widgets/subject_load_chart.dart';
import 'package:kairo/features/reports/presentation/widgets/summary_card.dart';
import 'package:kairo/features/reports/presentation/widgets/trend_chart.dart';
import 'package:kairo/features/reports/presentation/widgets/week_selector.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  static const _padding = EdgeInsets.fromLTRB(
    KairoSpacing.page,
    KairoSpacing.md,
    KairoSpacing.page,
    KairoSpacing.xl,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(title: 'Reportes', onBack: () => context.pop()),
        Expanded(
          child: switch (reports) {
            AsyncData(:final value) => _content(context, ref, value),
            AsyncError(:final error) => ErrorView(
              message: toAppException(error).message,
              onRetry: () => ref.invalidate(reportsProvider),
            ),
            _ => const _ReportsSkeleton(padding: _padding),
          },
        ),
      ],
    );
  }

  Widget _content(BuildContext context, WidgetRef ref, ReportsData data) {
    final now = DateTime.now();
    final weeks = ReportWeeks.available(data.loads, data.rest, now);
    final chosen = ref.watch(selectedReportWeekProvider);
    final selected = chosen != null && weeks.any((w) => Week.same(w, chosen))
        ? chosen
        : Week.mondayOf(now);

    return RefreshIndicator(
      onRefresh: () {
        ref.invalidate(reportSummaryProvider);
        return ref.refresh(reportsProvider.future);
      },
      child: ListView(
        padding: _padding,
        children: [
          const SummaryCard(),
          const SizedBox(height: KairoSpacing.lg),
          WeekSelector(
            weeks: weeks,
            selected: selected,
            onChanged: (week) =>
                ref.read(selectedReportWeekProvider.notifier).week = week,
          ),
          const SizedBox(height: KairoSpacing.md),
          SubjectLoadChart(items: ReportWeeks.subjects(data.loads, selected)),
          const SizedBox(height: KairoSpacing.lg),
          TrendChart(
            weeks: ReportWeeks.trend(data.loads, data.rest, now),
            selected: selected,
            enough: ReportWeeks.enoughData(data.rest),
          ),
          const SizedBox(height: KairoSpacing.lg),
          GoalsReportCard(goals: data.goals),
        ],
      ),
    );
  }
}

class _ReportsSkeleton extends StatelessWidget {
  const _ReportsSkeleton({required this.padding});

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;

    return Semantics(
      label: 'Cargando reportes',
      child: ListView(
        padding: padding,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (final height in const [96.0, 64.0, 260.0, 280.0]) ...[
            Container(
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(KairoSpacing.radiusMd),
              ),
            ),
            const SizedBox(height: KairoSpacing.lg),
          ],
        ],
      ),
    );
  }
}
