import 'package:json_annotation/json_annotation.dart';

enum GoalPeriod {
  @JsonValue('dia')
  day('Diaria', 'Hoy'),
  @JsonValue('semana')
  week('Semanal', 'Esta semana'),
  @JsonValue('mes')
  month('Mensual', 'Este mes');

  const GoalPeriod(this.label, this.current);

  final String label;
  final String current;
}
