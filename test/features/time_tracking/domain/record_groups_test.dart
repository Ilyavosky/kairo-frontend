import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/domain/record_groups.dart';
import 'package:kairo/features/time_tracking/domain/time_record_validator.dart';

void main() {
  final now = DateTime(2026, 11, 24, 21);

  TimeRecord record(String id, DateTime start, Duration length) => TimeRecord(
    id: id,
    categoryId: 'categoria-1',
    start: start,
    end: start.add(length),
    origin: 'temporizador',
  );

  test('agrupa en hoy, ayer y anteriores con su total', () {
    final groups = RecordGroups.of([
      record('viejo', DateTime(2026, 11, 20, 9), const Duration(hours: 1)),
      record('hoy-1', DateTime(2026, 11, 24, 8), const Duration(minutes: 30)),
      record('ayer', DateTime(2026, 11, 23, 23), const Duration(hours: 2)),
      record('hoy-2', DateTime(2026, 11, 24, 18), const Duration(minutes: 45)),
    ], now);

    expect(groups.map((group) => group.title), ['Hoy', 'Ayer', 'Anteriores']);
    expect(groups[0].records.map((r) => r.id), ['hoy-2', 'hoy-1']);
    expect(groups[0].total, const Duration(minutes: 75));
    expect(groups[1].records.single.id, 'ayer');
    expect(groups[2].records.single.id, 'viejo');
  });

  test('omite los grupos vacíos', () {
    final groups = RecordGroups.of([
      record('ayer', DateTime(2026, 11, 23, 10), const Duration(hours: 1)),
    ], now);

    expect(groups.map((group) => group.title), ['Ayer']);
  });

  test('valida que el fin sea después del inicio y no en el futuro', () {
    final start = DateTime(2026, 11, 24, 8);

    expect(
      TimeRecordValidator.range(start, start, now),
      'El fin debe ser después del inicio',
    );
    expect(
      TimeRecordValidator.range(start, DateTime(2026, 11, 24, 22), now),
      'El fin no puede estar en el futuro',
    );
    expect(
      TimeRecordValidator.range(start, DateTime(2026, 11, 24, 9), now),
      isNull,
    );
    expect(
      TimeRecordValidator.range(
        start,
        DateTime(2026, 11, 24, 22),
        now,
        originalEnd: DateTime(2026, 11, 24, 22),
      ),
      isNull,
    );
  });
}
