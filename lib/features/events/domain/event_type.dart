import 'package:json_annotation/json_annotation.dart';

enum EventType {
  @JsonValue('clase')
  lecture('clase', 'Clase'),
  @JsonValue('examen')
  exam('examen', 'Examen'),
  @JsonValue('entrega')
  delivery('entrega', 'Entrega'),
  @JsonValue('reunion')
  meeting('reunion', 'Reunión'),
  @JsonValue('personal')
  personal('personal', 'Personal');

  const EventType(this.apiValue, this.label);

  final String apiValue;
  final String label;
}
