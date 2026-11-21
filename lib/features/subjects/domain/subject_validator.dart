abstract final class SubjectValidator {
  static const maxLength = 120;

  static String? name(String? value) => _required(value, 'el nombre');

  static String? period(String? value) => _required(value, 'el periodo');

  static String? optional(String? value) {
    if ((value?.trim().length ?? 0) > maxLength) {
      return 'No puede tener más de $maxLength caracteres';
    }
    return null;
  }

  static String? _required(String? value, String field) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Escribe $field de la materia';
    }
    return optional(text);
  }

  static String? clean(String value) {
    final text = value.trim();
    return text.isEmpty ? null : text;
  }
}
