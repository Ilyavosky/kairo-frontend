// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeRecord _$TimeRecordFromJson(Map<String, dynamic> json) => _TimeRecord(
  id: json['id'] as String,
  categoryId: json['categoria_id'] as String,
  start: DateTime.parse(json['inicio'] as String),
  end: DateTime.parse(json['fin'] as String),
  origin: json['origen'] as String,
  activityId: json['actividad_id'] as String?,
  note: json['nota'] as String?,
);

Map<String, dynamic> _$TimeRecordToJson(_TimeRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoria_id': instance.categoryId,
      'inicio': instance.start.toIso8601String(),
      'fin': instance.end.toIso8601String(),
      'origen': instance.origin,
      'actividad_id': instance.activityId,
      'nota': instance.note,
    };
