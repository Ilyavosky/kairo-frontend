import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/activities/domain/due_label.dart';

void main() {
  final now = DateTime(2026, 11, 2, 10);

  DueLabel label(DateTime? dueAt, {bool completed = false}) =>
      DueLabel.of(dueAt: dueAt, now: now, completed: completed);

  test('marca completada sin importar la fecha', () {
    expect(label(DateTime(2026, 11), completed: true).text, 'Completada');
  });

  test('avisa cuando no hay fecha de entrega', () {
    expect(label(null).text, 'Sin fecha de entrega');
  });

  test('describe hoy, mañana y los días siguientes', () {
    expect(label(DateTime(2026, 11, 2, 23, 59)).text, 'Hoy, 23:59');
    expect(label(DateTime(2026, 11, 3, 11)).text, 'Mañana, 11:00');
    expect(label(DateTime(2026, 11, 6, 9, 5)).text, 'Vie 06 nov, 09:05');
  });

  test('marca como vencidas las fechas pasadas', () {
    final today = label(DateTime(2026, 11, 2, 8));
    expect(today.text, 'Venció hoy, 08:00');
    expect(today.overdue, isTrue);
    expect(label(DateTime(2026, 11, 1, 20)).text, 'Venció ayer');
    expect(label(DateTime(2026, 10, 30, 20)).text, 'Venció hace 3 días');
  });
}
