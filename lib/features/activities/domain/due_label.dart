class DueLabel {
  const DueLabel(this.text, {this.overdue = false});

  factory DueLabel.of({
    required DateTime? dueAt,
    required DateTime now,
    bool completed = false,
  }) {
    if (completed) {
      return const DueLabel('Completada');
    }
    if (dueAt == null) {
      return const DueLabel('Sin fecha de entrega');
    }

    final due = dueAt.toLocal();
    final current = now.toLocal();
    final days = _dateOnly(due).difference(_dateOnly(current)).inDays;
    final time = hour(due);

    if (due.isBefore(current)) {
      final text = switch (days) {
        0 => 'Venció hoy, $time',
        -1 => 'Venció ayer',
        _ => 'Venció hace ${-days} días',
      };
      return DueLabel(text, overdue: true);
    }

    return DueLabel(switch (days) {
      0 => 'Hoy, $time',
      1 => 'Mañana, $time',
      _ => '${shortDate(due)}, $time',
    });
  }

  final String text;
  final bool overdue;

  static const _weekdays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
  static const _months = [
    'ene',
    'feb',
    'mar',
    'abr',
    'may',
    'jun',
    'jul',
    'ago',
    'sep',
    'oct',
    'nov',
    'dic',
  ];

  static String shortDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    return '${_weekdays[date.weekday - 1]} $day ${_months[date.month - 1]}';
  }

  static String hour(DateTime date) {
    final hours = date.hour.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
