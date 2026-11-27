import 'package:json_annotation/json_annotation.dart';

enum ReminderStatus {
  @JsonValue('pendiente')
  pending('Pendiente'),
  @JsonValue('enviado')
  sent('Enviado'),
  @JsonValue('fallido')
  failed('No se pudo enviar'),
  @JsonValue('cancelado')
  cancelled('Cancelado');

  const ReminderStatus(this.label);

  final String label;
}
