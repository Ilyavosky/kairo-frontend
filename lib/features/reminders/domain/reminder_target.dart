enum ReminderTarget {
  activity('Actividad'),
  event('Evento'),
  goal('Meta');

  const ReminderTarget(this.label);

  final String label;
}
