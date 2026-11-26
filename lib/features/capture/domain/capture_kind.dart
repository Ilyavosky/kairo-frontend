import 'package:json_annotation/json_annotation.dart';

enum CaptureKind {
  @JsonValue('actividad')
  activity('Actividad'),
  @JsonValue('registro_tiempo')
  timeRecord('Registro de tiempo'),
  @JsonValue('meta')
  goal('Meta');

  const CaptureKind(this.label);

  final String label;
}
