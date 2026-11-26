abstract final class GoalValidator {
  static const maxTarget = 100000;

  static String? category(String? categoryId) =>
      categoryId == null ? 'Elige una categoría' : null;

  static int? wholeNumber(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 0;
    }
    return int.tryParse(text);
  }

  static String? numberField(String? value) {
    final number = wholeNumber(value);
    if (number == null || number < 0) {
      return 'Escribe un número entero';
    }
    return null;
  }

  static String? minutesField(String? value) {
    final number = wholeNumber(value);
    if (number == null || number < 0 || number > 59) {
      return 'De 0 a 59';
    }
    return null;
  }

  static String? target(int? target) {
    if (target == null || target < 1) {
      return 'El objetivo debe ser mayor que cero';
    }
    if (target > maxTarget) {
      return 'El objetivo es demasiado grande';
    }
    return null;
  }

  static int? timeTarget(String hours, String minutes) {
    final h = wholeNumber(hours);
    final m = wholeNumber(minutes);
    if (h == null || m == null || h < 0 || m < 0 || m > 59) {
      return null;
    }
    return h * 60 + m;
  }
}
