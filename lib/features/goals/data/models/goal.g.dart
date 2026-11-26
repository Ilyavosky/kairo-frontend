// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Goal _$GoalFromJson(Map<String, dynamic> json) => _Goal(
  id: json['id'] as String,
  categoryId: json['categoria_id'] as String,
  type: $enumDecode(_$GoalTypeEnumMap, json['tipo']),
  period: $enumDecode(_$GoalPeriodEnumMap, json['periodo']),
  target: (json['objetivo'] as num).toInt(),
  validFrom: DateTime.parse(json['vigente_desde'] as String),
  active: json['activa'] as bool,
  validUntil: json['vigente_hasta'] == null
      ? null
      : DateTime.parse(json['vigente_hasta'] as String),
);

Map<String, dynamic> _$GoalToJson(_Goal instance) => <String, dynamic>{
  'id': instance.id,
  'categoria_id': instance.categoryId,
  'tipo': _$GoalTypeEnumMap[instance.type]!,
  'periodo': _$GoalPeriodEnumMap[instance.period]!,
  'objetivo': instance.target,
  'vigente_desde': instance.validFrom.toIso8601String(),
  'activa': instance.active,
  'vigente_hasta': instance.validUntil?.toIso8601String(),
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
