abstract final class ReminderValidator {
  static String? target(String? targetId) =>
      targetId == null ? 'Elige a qué se refiere el recordatorio' : null;

  static String? moment(DateTime? moment, DateTime now) {
    if (moment == null) {
      return 'Elige la fecha y hora del aviso';
    }
    if (!moment.isAfter(now)) {
      return 'La fecha y hora deben ser futuras';
    }
    return null;
  }
}
