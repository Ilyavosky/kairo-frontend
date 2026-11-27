import 'package:kairo/features/activities/domain/due_label.dart';

abstract final class Week {
  static DateTime mondayOf(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    return DateTime(day.year, day.month, day.day - (day.weekday - 1));
  }

  static String key(DateTime weekStart) {
    final month = weekStart.month.toString().padLeft(2, '0');
    final day = weekStart.day.toString().padLeft(2, '0');
    return '${weekStart.year}-$month-$day';
  }

  static DateTime? parse(String key) {
    final parsed = DateTime.tryParse(key);
    if (parsed == null) {
      return null;
    }
    return DateTime(parsed.year, parsed.month, parsed.day);
  }

  static bool same(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static String label(DateTime weekStart) {
    final end = DateTime(weekStart.year, weekStart.month, weekStart.day + 6);
    return '${DueLabel.shortDate(weekStart)} – ${DueLabel.shortDate(end)}';
  }
}
