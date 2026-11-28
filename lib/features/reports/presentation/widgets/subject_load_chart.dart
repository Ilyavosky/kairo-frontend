import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/reports/domain/report_weeks.dart';
import 'package:kairo/features/reports/presentation/widgets/report_card.dart';

class SubjectLoadChart extends StatelessWidget {
  const SubjectLoadChart({required this.items, super.key});

  final List<SubjectLoad> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReportCard(
      title: 'Carga por materia',
      subtitle: 'Entregas que vencen en la semana elegida',
      child: items.isEmpty
          ? Text(
              'No tienes entregas ni tiempo registrado en esta semana.',
              style: theme.textTheme.bodyMedium,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (items.any((item) => item.deliveries > 0)) ...[
                  _chart(context),
                  const SizedBox(height: KairoSpacing.lg),
                ],
                for (final item in items) _row(context, item),
              ],
            ),
    );
  }

  Widget _chart(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final top = items
        .map((item) => item.deliveries)
        .reduce((a, b) => a > b ? a : b);
    final summary = [
      for (final item in items)
        '${item.name}: ${ReportWeeks.deliveries(item.deliveries)}',
    ].join(', ');

    return Semantics(
      label: 'Gráfica de entregas por materia. $summary',
      excludeSemantics: true,
      child: SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            maxY: (top < 4 ? 4 : top + 1).toDouble(),
            alignment: BarChartAlignment.spaceAround,
            barTouchData: const BarTouchData(enabled: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              drawVerticalLine: false,
              horizontalInterval: 1,
              getDrawingHorizontalLine: (_) =>
                  FlLine(color: scheme.outlineVariant, strokeWidth: 1),
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(),
              rightTitles: const AxisTitles(),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 1,
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    meta: meta,
                    child: Text(
                      value.toInt().toString(),
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= items.length) {
                      return const SizedBox.shrink();
                    }
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        _short(items[index].name),
                        style: theme.textTheme.bodySmall,
                      ),
                    );
                  },
                ),
              ),
            ),
            barGroups: [
              for (var i = 0; i < items.length; i++)
                BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: items[i].deliveries.toDouble(),
                      width: 22,
                      color: scheme.primary,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(6),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(BuildContext context, SubjectLoad item) {
    final theme = Theme.of(context);
    final detail = [
      ReportWeeks.deliveries(item.deliveries),
      if (item.pending == 1)
        '1 pendiente'
      else if (item.pending > 1)
        '${item.pending} pendientes',
      '${ReportWeeks.minutes(item.minutes)} registradas',
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: KairoSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(detail, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  String _short(String name) =>
      name.length <= 10 ? name : '${name.substring(0, 9)}…';
}
