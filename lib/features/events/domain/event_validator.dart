abstract final class EventValidator {
  static const titleMaxLength = 200;
  static const placeMaxLength = 200;
  static const descriptionMaxLength = 2000;

  static String? title(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Escribe el nombre del evento';
    }
    if (text.length > titleMaxLength) {
      return 'No puede tener más de $titleMaxLength caracteres';
    }
    return null;
  }

  static String? place(String? value) {
    if ((value?.trim().length ?? 0) > placeMaxLength) {
      return 'No puede tener más de $placeMaxLength caracteres';
    }
    return null;
  }

  static String? description(String? value) {
    if ((value?.trim().length ?? 0) > descriptionMaxLength) {
      return 'No puede tener más de $descriptionMaxLength caracteres';
    }
    return null;
  }

  static String? start(DateTime? value) =>
      value == null ? 'Elige cuándo empieza' : null;

  static String? end(DateTime? start, DateTime? end) {
    if (end == null) {
      return 'Elige cuándo termina';
    }
    if (start != null && !end.isAfter(start)) {
      return 'Debe terminar después de que empieza';
    }
    return null;
  }

  static String? clean(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? null : text;
  }
}
