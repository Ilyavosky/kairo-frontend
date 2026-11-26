abstract final class CaptureValidator {
  static const maxLength = 1000;

  static String? text(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Escribe o pega un mensaje';
    }
    if (text.length > maxLength) {
      return 'No puede tener más de $maxLength caracteres';
    }
    return null;
  }
}
