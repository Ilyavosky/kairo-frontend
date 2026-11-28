import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/events/domain/event_validator.dart';

void main() {
  final start = DateTime(2026, 11, 30, 8);

  test('pide el nombre del evento', () {
    expect(EventValidator.title(''), 'Escribe el nombre del evento');
    expect(EventValidator.title('   '), 'Escribe el nombre del evento');
    expect(EventValidator.title('Examen de redes'), isNull);
    expect(EventValidator.title('a' * 201), isNotNull);
  });

  test('pide inicio y un fin posterior al inicio', () {
    expect(EventValidator.start(null), 'Elige cuándo empieza');
    expect(EventValidator.end(start, null), 'Elige cuándo termina');
    expect(
      EventValidator.end(start, start),
      'Debe terminar después de que empieza',
    );
    expect(
      EventValidator.end(start, start.subtract(const Duration(hours: 1))),
      'Debe terminar después de que empieza',
    );
    expect(
      EventValidator.end(start, start.add(const Duration(hours: 2))),
      isNull,
    );
  });

  test('los campos opcionales vacíos se mandan como nulos', () {
    expect(EventValidator.clean('  '), isNull);
    expect(EventValidator.clean(' Aula 3 '), 'Aula 3');
  });
}
