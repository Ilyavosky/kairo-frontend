import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/tags/domain/tag_validator.dart';

void main() {
  test('pide un nombre de hasta 50 caracteres', () {
    expect(TagValidator.name(''), 'Escribe el nombre de la etiqueta');
    expect(TagValidator.name('  '), 'Escribe el nombre de la etiqueta');
    expect(TagValidator.name('Urgente'), isNull);
    expect(TagValidator.name('a' * 51), isNotNull);
  });
}
