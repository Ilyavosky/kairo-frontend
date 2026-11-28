import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/events/domain/event_type.dart';

void main() {
  Map<String, dynamic> json(String? type) => {
    'id': 'evento-1',
    'titulo': 'Examen de redes',
    'inicio': '2026-11-30T14:00:00Z',
    'fin': '2026-11-30T16:00:00Z',
    'materia_id': null,
    'lugar': 'Aula 3',
    'tipo': ?type,
    'actividad_id': null,
  };

  test('lee el tipo de evento que manda la API', () {
    expect(Event.fromJson(json('examen')).type, EventType.exam);
    expect(Event.fromJson(json('reunion')).type, EventType.meeting);
  });

  test('un tipo desconocido o ausente se toma como personal', () {
    expect(Event.fromJson(json('congreso')).type, EventType.personal);
    expect(Event.fromJson(json(null)).type, EventType.personal);
  });

  test('cada tipo se manda a la API con su valor en español', () {
    expect(EventType.values.map((type) => type.apiValue), [
      'clase',
      'examen',
      'entrega',
      'reunion',
      'personal',
    ]);
  });
}
