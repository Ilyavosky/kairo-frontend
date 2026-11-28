import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/reports/domain/report_weeks.dart';
import 'package:kairo/features/reports/presentation/widgets/report_card.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';

class TrendChart extends StatelessWidget {
  const TrendChart({
    required this.weeks,
    required this.selected,
    required this.enough,
    super.key,
  });

  final List<TrendWeek> weeks;
  final DateTime selected;
  final bool enough;

  @override
  Widget build(BuildContext context) {
    return ReportCard(
      title: 'Entregas contra descanso',
      subtitle: 'Entregas por semana junto a tus horas de sueño y de ejercicio',
      child: enough ? _content(context) : _notEnough(context),
    );
  }

  Widget _notEnough(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      children: [
        Icon(Icons.insights_outlined, size: 40, color: scheme.primary),
        const SizedBox(height: KairoSpacing.sm),
        Text(
          'Necesitas más semanas de datos',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleSmall,
        ),
        const SizedBox(height: KairoSpacing.xs),
        Text(
          'Registra tu sueño y tu ejercicio en Tiempo durante al menos '
          '${ReportWeeks.minimumWeeks} semanas para ver cómo se relacionan '
          'con tus entregas. Llevas ${weeks.length} de '
          '${ReportWeeks.minimumWeeks}.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _content(BuildContext context) {
    final theme = Theme.of(context);
    final colors = _SeriesColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _chart(context, colors),
        const SizedBox(height: KairoSpacing.md),
        Wrap(
          spacing: KairoSpacing.lg,
          runSpacing: KairoSpacing.xs,
          children: [
            _Legend(color: colors.deliveries, label: 'Entregas'),
            _Legend(
              color: colors.sleep,
              label: 'Sueño (h por noche)',
              dashed: true,
            ),
            _Legend(
              color: colors.exercise,
              label: 'Ejercicio (h en la semana)',
              dashed: true,
            ),
          ],
        ),
        const SizedBox(height: KairoSpacing.lg),
        Text('Detalle por semana', style: theme.textTheme.titleSmall),
        const SizedBox(height: KairoSpacing.xs),
        for (final week in weeks.reversed) _row(context, week),
      ],
    );
  }

  Widget _chart(BuildContext context, _SeriesColors colors) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final values = [
      for (final week in weeks) ...[
        week.deliveries.toDouble(),
        week.sleepHoursPerNight,
        week.exerciseHours,
      ],
    ];
    final top = values.reduce((a, b) => a > b ? a : b);
    final maxY = (((top < 4 ? 4 : top + 1) / 2).ceil() * 2).toDouble();
    final selectedIndex = weeks.indexWhere(
      (week) => Week.same(week.weekStart, selected),
    );
    final summary = weeks.map(_describe).join('. ');

    return Semantics(
      label: 'Gráfica de entregas contra descanso. $summary',
      excludeSemantics: true,
      child: SizedBox(
        height: 220,
        child: LineChart(
          LineChartData(
            minX: -0.4,
            maxX: weeks.length - 0.6,
            minY: 0,
            maxY: maxY,
            lineTouchData: const LineTouchData(enabled: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              drawVerticalLine: false,
              horizontalInterval: 2,
              getDrawingHorizontalLine: (_) =>
                  FlLine(color: scheme.outlineVariant, strokeWidth: 1),
            ),
            extraLinesData: ExtraLinesData(
              verticalLines: [
                if (selectedIndex >= 0)
                  VerticalLine(
                    x: selectedIndex.toDouble(),
                    color: scheme.outline,
                    strokeWidth: 1,
                    dashArray: const [4, 4],
                  ),
              ],
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(),
              rightTitles: const AxisTitles(),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 2,
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    meta: meta,
                    child: Text(
                      meta.formattedValue,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 1,
                  minIncluded: false,
                  maxIncluded: false,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 ||
                        index >= weeks.length ||
                        value != index.toDouble()) {
                      return const SizedBox.shrink();
                    }
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        DueLabel.dayMonth(weeks[index].weekStart),
                        style: theme.textTheme.bodySmall,
                      ),
                    );
                  },
                ),
              ),
            ),
            lineBarsData: [
              _line(
                [for (final w in weeks) w.deliveries.toDouble()],
                colors.deliveries,
                null,
              ),
              _line(
                [for (final w in weeks) w.sleepHoursPerNight],
                colors.sleep,
                const [8, 4],
              ),
              _line(
                [for (final w in weeks) w.exerciseHours],
                colors.exercise,
                const [3, 3],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _describe(TrendWeek week) {
    final date = DueLabel.dayMonth(week.weekStart);
    final deliveries = ReportWeeks.deliveries(week.deliveries);
    final sleep = ReportWeeks.hours(week.sleepHoursPerNight);
    final exercise = ReportWeeks.hours(week.exerciseHours);
    return '$date: $deliveries, sueño $sleep por noche, ejercicio $exercise';
  }

  LineChartBarData _line(List<double> values, Color color, List<int>? dash) {
    return LineChartBarData(
      spots: [
        for (var i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i]),
      ],
      color: color,
      barWidth: 3,
      dashArray: dash,
      isStrokeCapRound: true,
    );
  }

  Widget _row(BuildContext context, TrendWeek week) {
    final theme = Theme.of(context);
    final isSelected = Week.same(week.weekStart, selected);
    final title = week.inProgress
        ? '${Week.label(week.weekStart)} (en curso)'
        : Week.label(week.weekStart);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: KairoSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            '${ReportWeeks.deliveries(week.deliveries)} · '
            'sueño ${ReportWeeks.minutes(week.sleepMinutes)} '
            '(${ReportWeeks.hours(week.sleepHoursPerNight)} por noche) · '
            'ejercicio ${ReportWeeks.minutes(week.exerciseMinutes)}',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _SeriesColors {
  const _SeriesColors(this.deliveries, this.sleep, this.exercise);

  factory _SeriesColors.of(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    return _SeriesColors(
      theme.colorScheme.primary,
      dark ? const Color(0xFF90CAF9) : const Color(0xFF1565C0),
      dark ? const Color(0xFFA5D6A7) : const Color(0xFF2E7D32),
    );
  }

  final Color deliveries;
  final Color sleep;
  final Color exercise;
}

class _Legend extends StatelessWidget {
  const _Legend({
    required this.color,
    required this.label,
    this.dashed = false,
  });

  final Color color;
  final String label;
  final bool dashed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < (dashed ? 2 : 1); i++) ...[
              if (i > 0) const SizedBox(width: 3),
              Container(width: dashed ? 8 : 19, height: 3, color: color),
            ],
          ],
        ),
        const SizedBox(width: KairoSpacing.xs),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
