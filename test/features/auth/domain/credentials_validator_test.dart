import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/auth/domain/credentials_validator.dart';

void main() {
  group('CredentialsValidator.email', () {
    test('pide el correo si viene vacío', () {
      expect(CredentialsValidator.email(''), 'Escribe tu correo');
      expect(CredentialsValidator.email('   '), 'Escribe tu correo');
    });

    test('rechaza un correo sin formato válido', () {
      expect(CredentialsValidator.email('aurora'), 'Escribe un correo válido');
      expect(
        CredentialsValidator.email('aurora@correo'),
        'Escribe un correo válido',
      );
    });

    test('acepta un correo válido', () {
      expect(CredentialsValidator.email('aurora@correo.com'), isNull);
    });
  });

  group('CredentialsValidator.password', () {
    test('pide la contraseña si viene vacía', () {
      expect(CredentialsValidator.password(''), 'Escribe tu contraseña');
    });

    test('rechaza contraseñas de menos de 8 caracteres', () {
      expect(
        CredentialsValidator.password('1234567'),
        'La contraseña debe tener al menos 8 caracteres',
      );
    });

    test('rechaza contraseñas de más de 128 caracteres', () {
      expect(CredentialsValidator.password('a' * 129), isNotNull);
    });

    test('acepta una contraseña de 8 caracteres', () {
      expect(CredentialsValidator.password('12345678'), isNull);
    });
  });
}
