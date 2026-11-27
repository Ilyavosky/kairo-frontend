// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_assessment_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SelfAssessmentInput _$SelfAssessmentInputFromJson(Map<String, dynamic> json) =>
    _SelfAssessmentInput(
      mood: (json['estado_animo'] as num).toInt(),
      satisfaction: (json['satisfaccion'] as num).toInt(),
      note: json['nota'] as String?,
    );

Map<String, dynamic> _$SelfAssessmentInputToJson(
  _SelfAssessmentInput instance,
) => <String, dynamic>{
  'estado_animo': instance.mood,
  'satisfaccion': instance.satisfaction,
  'nota': instance.note,
};
