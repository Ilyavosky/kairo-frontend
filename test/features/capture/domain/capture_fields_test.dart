import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/capture/data/models/capture.dart';
import 'package:kairo/features/capture/domain/capture_fields.dart';
import 'package:kairo/features/capture/domain/capture_kind.dart';

void main() {
  const lookups = (
    categories: {'c1': 'Ejercicio'},
    subjects: <String, String>{},
    activities: <String, String>{},
  );

  test('ordena los campos según el tipo y deja ver los pendientes', () {
    const capture = Capture(
      id: 'c',
      message: 'm',
      kind: CaptureKind.goal,
      status: 'pendiente',
      fields: {
        'objetivo': 120,
        'categoria_id': 'c1',
        'tipo': 'tiempo_acumulado',
      },
      pending: ['periodo'],
    );

    expect(CaptureFields.keysOf(capture), [
      'categoria_id',
      'tipo',
      'periodo',
      'objetivo',
    ]);
    expect(CaptureFields.isPending(capture, 'periodo'), isTrue);
    expect(
      CaptureFields.display(capture, 'categoria_id', lookups),
      'Ejercicio',
    );
    expect(CaptureFields.display(capture, 'tipo', lookups), 'Tiempo');
    expect(CaptureFields.display(capture, 'objetivo', lookups), '2 h');
  });

  test('muestra fechas en hora local y la prioridad con su nombre', () {
    final local = DateTime(2026, 11, 27, 23, 59);
    final capture = Capture(
      id: 'c',
      message: 'm',
      kind: CaptureKind.activity,
      status: 'pendiente',
      fields: {'vence_en': local.toUtc().toIso8601String(), 'prioridad': 4},
      pending: const [],
    );

    expect(
      CaptureFields.display(capture, 'vence_en', lookups),
      'Vie 27 nov, 23:59',
    );
    expect(CaptureFields.display(capture, 'prioridad', lookups), '4 · Alta');
  });
}
