// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_load.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeeklyLoad _$WeeklyLoadFromJson(Map<String, dynamic> json) => _WeeklyLoad(
  weekStart: DateTime.parse(json['semana_desde'] as String),
  deliveries: (json['actividades_con_vencimiento'] as num).toInt(),
  pending: (json['actividades_pendientes'] as num).toInt(),
  minutes: (json['minutos_registrados'] as num).toDouble(),
  subjectId: json['materia_id'] as String?,
  subject: json['materia'] as String?,
);

Map<String, dynamic> _$WeeklyLoadToJson(_WeeklyLoad instance) =>
    <String, dynamic>{
      'semana_desde': instance.weekStart.toIso8601String(),
      'actividades_con_vencimiento': instance.deliveries,
      'actividades_pendientes': instance.pending,
      'minutos_registrados': instance.minutes,
      'materia_id': instance.subjectId,
      'materia': instance.subject,
    };
