import 'package:flutter/foundation.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';

@immutable
class RecordGroup {
  const RecordGroup({required this.title, required this.records});

  final String title;
  final List<TimeRecord> records;

  Duration get total =>
      records.fold(Duration.zero, (sum, record) => sum + record.duration);

  List<({String categoryId, Duration total})> get categoryTotals {
    final totals = <String, Duration>{};
    for (final record in records) {
      totals[record.categoryId] =
          (totals[record.categoryId] ?? Duration.zero) + record.duration;
    }
    final entries = [
      for (final entry in totals.entries)
        (categoryId: entry.key, total: entry.value),
    ]..sort((a, b) => b.total.compareTo(a.total));
    return entries;
  }
}

abstract final class RecordGroups {
  static List<RecordGroup> of(List<TimeRecord> records, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final sorted = [...records]..sort((a, b) => b.start.compareTo(a.start));
    final byDay = <DateTime, List<TimeRecord>>{};

    for (final record in sorted) {
      final start = record.start.toLocal();
      final day = DateTime(start.year, start.month, start.day);
      byDay.putIfAbsent(day, () => []).add(record);
    }

    return [
      for (final entry in byDay.entries)
        RecordGroup(title: _title(entry.key, today), records: entry.value),
    ];
  }

  static String _title(DateTime day, DateTime today) {
    final offset = today.difference(day).inDays;
    return switch (offset) {
      <= 0 => 'Hoy',
      1 => 'Ayer',
      _ => DueLabel.shortDate(day),
    };
  }
}
