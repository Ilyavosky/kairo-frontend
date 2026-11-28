// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  id: json['id'] as String,
  title: json['titulo'] as String,
  start: DateTime.parse(json['inicio'] as String),
  end: DateTime.parse(json['fin'] as String),
  type:
      $enumDecodeNullable(
        _$EventTypeEnumMap,
        json['tipo'],
        unknownValue: EventType.personal,
      ) ??
      EventType.personal,
  activityId: json['actividad_id'] as String?,
  subjectId: json['materia_id'] as String?,
  place: json['lugar'] as String?,
  description: json['descripcion'] as String?,
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.title,
  'inicio': instance.start.toIso8601String(),
  'fin': instance.end.toIso8601String(),
  'tipo': _$EventTypeEnumMap[instance.type]!,
  'actividad_id': instance.activityId,
  'materia_id': instance.subjectId,
  'lugar': instance.place,
  'descripcion': instance.description,
};

const _$EventTypeEnumMap = {
  EventType.lecture: 'clase',
  EventType.exam: 'examen',
  EventType.delivery: 'entrega',
  EventType.meeting: 'reunion',
  EventType.personal: 'personal',
};
