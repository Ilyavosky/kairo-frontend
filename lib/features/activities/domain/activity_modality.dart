import 'package:json_annotation/json_annotation.dart';

enum ActivityModality {
  @JsonValue('presencial')
  inPerson('Presencial'),
  @JsonValue('en_linea')
  online('En línea'),
  @JsonValue('mixta')
  hybrid('Mixta');

  const ActivityModality(this.label);

  final String label;
}
