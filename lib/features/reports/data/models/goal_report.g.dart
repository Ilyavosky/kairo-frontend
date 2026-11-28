// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalReport _$GoalReportFromJson(Map<String, dynamic> json) => _GoalReport(
  goalId: json['meta_id'] as String,
  category: json['categoria'] as String,
  type: $enumDecode(_$GoalTypeEnumMap, json['tipo']),
  period: $enumDecode(_$GoalPeriodEnumMap, json['periodo']),
  target: (json['objetivo'] as num).toInt(),
  progress: (json['progreso'] as num).toDouble(),
  percent: (json['porcentaje'] as num).toDouble(),
  achieved: json['cumplida'] as bool,
);

Map<String, dynamic> _$GoalReportToJson(_GoalReport instance) =>
    <String, dynamic>{
      'meta_id': instance.goalId,
      'categoria': instance.category,
      'tipo': _$GoalTypeEnumMap[instance.type]!,
      'periodo': _$GoalPeriodEnumMap[instance.period]!,
      'objetivo': instance.target,
      'progreso': instance.progress,
      'porcentaje': instance.percent,
      'cumplida': instance.achieved,
    };

const _$GoalTypeEnumMap = {
  GoalType.time: 'tiempo_acumulado',
  GoalType.events: 'numero_eventos',
};

const _$GoalPeriodEnumMap = {
  GoalPeriod.day: 'dia',
  GoalPeriod.week: 'semana',
  GoalPeriod.month: 'mes',
};
