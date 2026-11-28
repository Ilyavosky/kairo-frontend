// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_week.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestWeek _$RestWeekFromJson(Map<String, dynamic> json) => _RestWeek(
  weekStart: DateTime.parse(json['semana_desde'] as String),
  academicMinutes: (json['minutos_academicos'] as num).toDouble(),
  sleepMinutes: (json['minutos_sueno'] as num).toDouble(),
  exerciseMinutes: (json['minutos_ejercicio'] as num).toDouble(),
  mood: (json['estado_animo'] as num?)?.toInt(),
  satisfaction: (json['satisfaccion'] as num?)?.toInt(),
);

Map<String, dynamic> _$RestWeekToJson(_RestWeek instance) => <String, dynamic>{
  'semana_desde': instance.weekStart.toIso8601String(),
  'minutos_academicos': instance.academicMinutes,
  'minutos_sueno': instance.sleepMinutes,
  'minutos_ejercicio': instance.exerciseMinutes,
  'estado_animo': instance.mood,
  'satisfaccion': instance.satisfaction,
};
