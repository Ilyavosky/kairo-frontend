// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_record_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeRecordInput _$TimeRecordInputFromJson(Map<String, dynamic> json) =>
    _TimeRecordInput(
      categoryId: json['categoria_id'] as String,
      start: DateTime.parse(json['inicio'] as String),
      end: DateTime.parse(json['fin'] as String),
      activityId: json['actividad_id'] as String?,
      note: json['nota'] as String?,
    );

Map<String, dynamic> _$TimeRecordInputToJson(_TimeRecordInput instance) =>
    <String, dynamic>{
      'categoria_id': instance.categoryId,
      'inicio': instance.start.toIso8601String(),
      'fin': instance.end.toIso8601String(),
      'actividad_id': instance.activityId,
      'nota': instance.note,
    };
