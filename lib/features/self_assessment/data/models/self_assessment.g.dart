// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_assessment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SelfAssessment _$SelfAssessmentFromJson(Map<String, dynamic> json) =>
    _SelfAssessment(
      weekStart: DateTime.parse(json['semana_desde'] as String),
      mood: (json['estado_animo'] as num).toInt(),
      satisfaction: (json['satisfaccion'] as num).toInt(),
      createdAt: DateTime.parse(json['creada_en'] as String),
      updatedAt: DateTime.parse(json['actualizada_en'] as String),
      note: json['nota'] as String?,
    );

Map<String, dynamic> _$SelfAssessmentToJson(_SelfAssessment instance) =>
    <String, dynamic>{
      'semana_desde': instance.weekStart.toIso8601String(),
      'estado_animo': instance.mood,
      'satisfaccion': instance.satisfaction,
      'creada_en': instance.createdAt.toIso8601String(),
      'actualizada_en': instance.updatedAt.toIso8601String(),
      'nota': instance.note,
    };
