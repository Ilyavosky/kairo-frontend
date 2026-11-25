abstract final class TimeRecordValidator {
  static const noteMaxLength = 2000;

  static String? category(String? categoryId) =>
      categoryId == null ? 'Elige una categoría' : null;

  static String? range(
    DateTime? start,
    DateTime? end,
    DateTime now, {
    DateTime? originalEnd,
  }) {
    if (start == null || end == null) {
      return 'Indica cuándo empezó y cuándo terminó';
    }
    if (!end.isAfter(start)) {
      return 'El fin debe ser después del inicio';
    }
    if (end != originalEnd && end.isAfter(now)) {
      return 'El fin no puede estar en el futuro';
    }
    return null;
  }

  static String? note(String? value) {
    if ((value?.trim().length ?? 0) > noteMaxLength) {
      return 'No puede tener más de $noteMaxLength caracteres';
    }
    return null;
  }
}
