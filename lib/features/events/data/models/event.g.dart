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
  subjectId: json['materia_id'] as String?,
  place: json['lugar'] as String?,
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.title,
  'inicio': instance.start.toIso8601String(),
  'fin': instance.end.toIso8601String(),
  'materia_id': instance.subjectId,
  'lugar': instance.place,
};
