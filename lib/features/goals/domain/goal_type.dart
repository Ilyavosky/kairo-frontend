import 'package:json_annotation/json_annotation.dart';

enum GoalType {
  @JsonValue('tiempo_acumulado')
  time('Tiempo'),
  @JsonValue('numero_eventos')
  events('Registros');

  const GoalType(this.label);

  final String label;
}
