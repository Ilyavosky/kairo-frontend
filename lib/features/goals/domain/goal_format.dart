import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/goals/domain/goal_period.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';
import 'package:kairo/features/time_tracking/domain/duration_format.dart';

abstract final class GoalFormat {
  static const _months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];

  static String amount(GoalType type, num value) {
    final rounded = value.round();
    return switch (type) {
      GoalType.time =>
        rounded < 60
            ? '$rounded min'
            : DurationFormat.short(Duration(minutes: rounded)),
      GoalType.events => rounded == 1 ? '1 registro' : '$rounded registros',
    };
  }

  static String progress(GoalType type, num value, int target) =>
      switch (type) {
        GoalType.time => '${amount(type, value)} de ${amount(type, target)}',
        GoalType.events => '${value.round()} de ${amount(type, target)}',
      };

  static String percent(double percent) {
    final rounded = percent.roundToDouble() == percent
        ? percent.toStringAsFixed(0)
        : percent.toStringAsFixed(1);
    return '$rounded %';
  }

  static double ratio(double percent) => (percent / 100).clamp(0.0, 1.0);

  static String periodRange(GoalPeriod period, DateTime start, DateTime end) {
    final from = start.toLocal();
    final to = end.toLocal().subtract(const Duration(microseconds: 1));
    return switch (period) {
      GoalPeriod.day => DueLabel.shortDate(from),
      GoalPeriod.week =>
        '${DueLabel.dayMonth(from)} – ${DueLabel.dayMonth(to)}',
      GoalPeriod.month => '${_months[from.month - 1]} ${from.year}',
    };
  }
}
