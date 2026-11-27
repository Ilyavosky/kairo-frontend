// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reminder _$ReminderFromJson(Map<String, dynamic> json) => _Reminder(
  id: json['id'] as String,
  moment: DateTime.parse(json['momento'] as String),
  status: $enumDecode(_$ReminderStatusEnumMap, json['estado_envio']),
  createdAt: DateTime.parse(json['creado_en'] as String),
  activityId: json['actividad_id'] as String?,
  eventId: json['evento_id'] as String?,
  goalId: json['meta_id'] as String?,
  attempts: (json['intentos'] as num?)?.toInt() ?? 0,
  sentAt: json['enviado_en'] == null
      ? null
      : DateTime.parse(json['enviado_en'] as String),
);

Map<String, dynamic> _$ReminderToJson(_Reminder instance) => <String, dynamic>{
  'id': instance.id,
  'momento': instance.moment.toIso8601String(),
  'estado_envio': _$ReminderStatusEnumMap[instance.status]!,
  'creado_en': instance.createdAt.toIso8601String(),
  'actividad_id': instance.activityId,
  'evento_id': instance.eventId,
  'meta_id': instance.goalId,
  'intentos': instance.attempts,
  'enviado_en': instance.sentAt?.toIso8601String(),
};

const _$ReminderStatusEnumMap = {
  ReminderStatus.pending: 'pendiente',
  ReminderStatus.sent: 'enviado',
  ReminderStatus.failed: 'fallido',
  ReminderStatus.cancelled: 'cancelado',
};
