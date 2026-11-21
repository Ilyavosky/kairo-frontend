abstract final class ActivityValidator {
  static const titleMaxLength = 200;
  static const descriptionMaxLength = 2000;

  static const Map<int, String> priorityLabels = {
    1: 'Muy baja',
    2: 'Baja',
    3: 'Media',
    4: 'Alta',
    5: 'Muy alta',
  };

  static String? title(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Escribe el título de la actividad';
    }
    if (text.length > titleMaxLength) {
      return 'No puede tener más de $titleMaxLength caracteres';
    }
    return null;
  }

  static String? description(String? value) {
    if ((value?.trim().length ?? 0) > descriptionMaxLength) {
      return 'No puede tener más de $descriptionMaxLength caracteres';
    }
    return null;
  }

  static String? category(String? categoryId) =>
      categoryId == null ? 'Elige una categoría' : null;

  static String? clean(String value) {
    final text = value.trim();
    return text.isEmpty ? null : text;
  }
}
