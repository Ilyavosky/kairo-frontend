// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalInput _$GoalInputFromJson(Map<String, dynamic> json) => _GoalInput(
  categoryId: json['categoria_id'] as String,
  type: $enumDecode(_$GoalTypeEnumMap, json['tipo']),
  period: $enumDecode(_$GoalPeriodEnumMap, json['periodo']),
  target: (json['objetivo'] as num).toInt(),
);

Map<String, dynamic> _$GoalInputToJson(_GoalInput instance) =>
    <String, dynamic>{
      'categoria_id': instance.categoryId,
      'tipo': _$GoalTypeEnumMap[instance.type]!,
      'periodo': _$GoalPeriodEnumMap[instance.period]!,
      'objetivo': instance.target,
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
