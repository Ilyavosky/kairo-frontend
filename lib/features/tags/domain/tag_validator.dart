abstract final class TagValidator {
  static const nameMaxLength = 50;

  static String? name(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Escribe el nombre de la etiqueta';
    }
    if (text.length > nameMaxLength) {
      return 'No puede tener más de $nameMaxLength caracteres';
    }
    return null;
  }
}
