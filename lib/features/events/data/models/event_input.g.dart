// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventInput _$EventInputFromJson(Map<String, dynamic> json) => _EventInput(
  title: json['titulo'] as String,
  type: $enumDecode(_$EventTypeEnumMap, json['tipo']),
  start: DateTime.parse(json['inicio'] as String),
  end: DateTime.parse(json['fin'] as String),
  place: json['lugar'] as String?,
  description: json['descripcion'] as String?,
  subjectId: json['materia_id'] as String?,
  activityId: json['actividad_id'] as String?,
);

Map<String, dynamic> _$EventInputToJson(_EventInput instance) =>
    <String, dynamic>{
      'titulo': instance.title,
      'tipo': _$EventTypeEnumMap[instance.type]!,
      'inicio': instance.start.toIso8601String(),
      'fin': instance.end.toIso8601String(),
      'lugar': instance.place,
      'descripcion': instance.description,
      'materia_id': instance.subjectId,
      'actividad_id': instance.activityId,
    };

const _$EventTypeEnumMap = {
  EventType.lecture: 'clase',
  EventType.exam: 'examen',
  EventType.delivery: 'entrega',
  EventType.meeting: 'reunion',
  EventType.personal: 'personal',
};
