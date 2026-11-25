import 'package:flutter/foundation.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';

@immutable
class RecordGroup {
  const RecordGroup({required this.title, required this.records});

  final String title;
  final List<TimeRecord> records;

  Duration get total =>
      records.fold(Duration.zero, (sum, record) => sum + record.duration);
}

abstract final class RecordGroups {
  static List<RecordGroup> of(List<TimeRecord> records, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(today.year, today.month, today.day - 1);
    final sorted = [...records]..sort((a, b) => b.start.compareTo(a.start));
    final todays = <TimeRecord>[];
    final yesterdays = <TimeRecord>[];
    final older = <TimeRecord>[];

    for (final record in sorted) {
      final start = record.start.toLocal();
      final day = DateTime(start.year, start.month, start.day);
      if (!day.isBefore(today)) {
        todays.add(record);
      } else if (day == yesterday) {
        yesterdays.add(record);
      } else {
        older.add(record);
      }
    }

    return [
      if (todays.isNotEmpty) RecordGroup(title: 'Hoy', records: todays),
      if (yesterdays.isNotEmpty)
        RecordGroup(title: 'Ayer', records: yesterdays),
      if (older.isNotEmpty) RecordGroup(title: 'Anteriores', records: older),
    ];
  }
}
