import 'package:json_annotation/json_annotation.dart';

enum ActivityStatus {
  @JsonValue('pendiente')
  pending('pendiente', 'Pendientes'),
  @JsonValue('en_progreso')
  inProgress('en_progreso', 'En progreso'),
  @JsonValue('completada')
  completed('completada', 'Completadas'),
  @JsonValue('cancelada')
  cancelled('cancelada', 'Canceladas');

  const ActivityStatus(this.apiValue, this.filterLabel);

  final String apiValue;
  final String filterLabel;

  bool get isOpen => this == pending || this == inProgress;

  static const List<ActivityStatus> filters = [pending, inProgress, completed];
}
