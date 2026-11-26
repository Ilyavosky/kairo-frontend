// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalProgress _$GoalProgressFromJson(Map<String, dynamic> json) =>
    _GoalProgress(
      goalId: json['meta_id'] as String,
      target: (json['objetivo'] as num).toInt(),
      periodStart: DateTime.parse(json['periodo_desde'] as String),
      periodEnd: DateTime.parse(json['periodo_hasta'] as String),
      progress: (json['progreso'] as num).toDouble(),
      percent: (json['porcentaje'] as num).toDouble(),
      achieved: json['cumplida'] as bool,
    );

Map<String, dynamic> _$GoalProgressToJson(_GoalProgress instance) =>
    <String, dynamic>{
      'meta_id': instance.goalId,
      'objetivo': instance.target,
      'periodo_desde': instance.periodStart.toIso8601String(),
      'periodo_hasta': instance.periodEnd.toIso8601String(),
      'progreso': instance.progress,
      'porcentaje': instance.percent,
      'cumplida': instance.achieved,
    };
