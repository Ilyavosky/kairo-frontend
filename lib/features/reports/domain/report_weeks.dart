import 'package:flutter/foundation.dart';
import 'package:kairo/features/reports/data/models/rest_week.dart';
import 'package:kairo/features/reports/data/models/weekly_load.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';

@immutable
class SubjectLoad {
  const SubjectLoad({
    required this.name,
    required this.deliveries,
    required this.pending,
    required this.minutes,
  });

  final String name;
  final int deliveries;
  final int pending;
  final double minutes;
}

@immutable
class TrendWeek {
  const TrendWeek({
    required this.weekStart,
    required this.deliveries,
    required this.sleepMinutes,
    required this.exerciseMinutes,
    this.days = 7,
  });

  final DateTime weekStart;
  final int deliveries;
  final double sleepMinutes;
  final double exerciseMinutes;
  final int days;

  bool get inProgress => days < 7;

  double get sleepHoursPerNight => sleepMinutes / 60 / days;

  double get exerciseHours => exerciseMinutes / 60;
}

abstract final class ReportWeeks {
  static const minimumWeeks = 3;
  static const noSubject = 'Sin materia';

  static bool enoughData(List<RestWeek> rest) => rest.length >= minimumWeeks;

  static List<DateTime> available(
    List<WeeklyLoad> loads,
    List<RestWeek> rest,
    DateTime now,
  ) {
    final weeks = <DateTime>[Week.mondayOf(now)];
    for (final date in [
      for (final load in loads) load.weekStart,
      for (final week in rest) week.weekStart,
    ]) {
      final monday = Week.mondayOf(date);
      if (!weeks.any((week) => Week.same(week, monday))) {
        weeks.add(monday);
      }
    }
    return weeks..sort();
  }

  static List<SubjectLoad> subjects(List<WeeklyLoad> loads, DateTime week) {
    final items = [
      for (final load in loads)
        if (Week.same(load.weekStart, week) &&
            (load.deliveries > 0 || load.minutes > 0))
          SubjectLoad(
            name: load.subject ?? noSubject,
            deliveries: load.deliveries,
            pending: load.pending,
            minutes: load.minutes,
          ),
    ];
    return items..sort((a, b) => b.deliveries.compareTo(a.deliveries));
  }

  static List<TrendWeek> trend(
    List<WeeklyLoad> loads,
    List<RestWeek> rest,
    DateTime now,
  ) {
    final currentWeek = Week.mondayOf(now);
    final sorted = [...rest]
      ..sort((a, b) => a.weekStart.compareTo(b.weekStart));
    return [
      for (final week in sorted)
        TrendWeek(
          weekStart: Week.mondayOf(week.weekStart),
          deliveries: [
            for (final load in loads)
              if (Week.same(load.weekStart, week.weekStart)) load.deliveries,
          ].fold(0, (sum, value) => sum + value),
          sleepMinutes: week.sleepMinutes,
          exerciseMinutes: week.exerciseMinutes,
          days: Week.same(week.weekStart, currentWeek) ? now.weekday : 7,
        ),
    ];
  }

  static String hours(double value) {
    final rounded = (value * 10).round() / 10;
    final text = rounded == rounded.roundToDouble()
        ? rounded.toStringAsFixed(0)
        : rounded.toStringAsFixed(1);
    return '$text h';
  }

  static String minutes(double value) {
    final total = value.round();
    if (total <= 0) {
      return '0 min';
    }
    final h = total ~/ 60;
    final m = total % 60;
    if (h == 0) {
      return '$m min';
    }
    return m == 0 ? '$h h' : '$h h $m min';
  }

  static String deliveries(int count) =>
      count == 1 ? '1 entrega' : '$count entregas';
}
