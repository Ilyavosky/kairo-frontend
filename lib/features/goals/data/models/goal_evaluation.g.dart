// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalEvaluation _$GoalEvaluationFromJson(Map<String, dynamic> json) =>
    _GoalEvaluation(
      id: json['id'] as String,
      goalId: json['meta_id'] as String,
      periodStart: DateTime.parse(json['periodo_desde'] as String),
      periodEnd: DateTime.parse(json['periodo_hasta'] as String),
      target: (json['objetivo'] as num).toInt(),
      achievedValue: (json['valor_logrado'] as num).toDouble(),
      achieved: json['cumplida'] as bool,
    );

Map<String, dynamic> _$GoalEvaluationToJson(_GoalEvaluation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meta_id': instance.goalId,
      'periodo_desde': instance.periodStart.toIso8601String(),
      'periodo_hasta': instance.periodEnd.toIso8601String(),
      'objetivo': instance.target,
      'valor_logrado': instance.achievedValue,
      'cumplida': instance.achieved,
    };
