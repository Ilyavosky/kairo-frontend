import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/capture/domain/capture_correction.dart';

void main() {
  const original = <String, dynamic>{
    'titulo': 'Entregar reporte',
    'prioridad': 3,
    'vence_en': '2026-11-27T17:00:00-06:00',
    'materia_id': null,
  };

  test('sin cambios no manda nada', () {
    final changes = CaptureCorrection.changes(original, {
      'titulo': 'Entregar reporte',
      'prioridad': 3,
      'vence_en': '2026-11-27T23:00:00.000Z',
      'materia_id': null,
      'modalidad': null,
    });

    expect(changes, isEmpty);
  });

  test('solo manda los campos que cambiaron', () {
    final changes = CaptureCorrection.changes(original, {
      'titulo': 'Entregar reporte final',
      'prioridad': 3,
      'vence_en': '2026-11-28T23:00:00.000Z',
      'materia_id': 'materia-redes',
    });

    expect(changes, {
      'titulo': 'Entregar reporte final',
      'vence_en': '2026-11-28T23:00:00.000Z',
      'materia_id': 'materia-redes',
    });
  });

  test('quitar un dato lo manda vacío', () {
    final changes = CaptureCorrection.changes(original, {
      'titulo': 'Entregar reporte',
      'prioridad': null,
    });

    expect(changes, {'prioridad': null});
  });
}
