abstract final class CredentialsValidator {
  static const minPasswordLength = 8;
  static const maxPasswordLength = 128;
  static const maxNameLength = 100;

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? name(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return 'Escribe tu nombre';
    }
    if (name.length > maxNameLength) {
      return 'El nombre no puede tener más de $maxNameLength caracteres';
    }
    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Escribe tu correo';
    }
    if (!_emailPattern.hasMatch(email)) {
      return 'Escribe un correo válido';
    }
    return null;
  }

  static String? password(String? value) {
    final password = value ?? '';
    if (password.isEmpty) {
      return 'Escribe tu contraseña';
    }
    if (password.length < minPasswordLength) {
      return 'La contraseña debe tener al menos $minPasswordLength caracteres';
    }
    if (password.length > maxPasswordLength) {
      return 'La contraseña no puede tener más de $maxPasswordLength '
          'caracteres';
    }
    return null;
  }
}
