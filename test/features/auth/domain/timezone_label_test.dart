import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/auth/domain/timezone_label.dart';

void main() {
  test('muestra la ciudad de la zona horaria sin guiones bajos', () {
    expect(TimezoneLabel.city('America/Mexico_City'), 'Mexico City');
    expect(TimezoneLabel.city('UTC'), 'UTC');
  });

  test('busca sin importar mayúsculas ni guiones bajos', () {
    expect(TimezoneLabel.matches('America/Mexico_City', 'mexico city'), isTrue);
    expect(TimezoneLabel.matches('America/Cancun', 'tijuana'), isFalse);
    expect(TimezoneLabel.matches('America/Cancun', ''), isTrue);
  });
}
