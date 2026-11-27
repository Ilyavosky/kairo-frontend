// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReminderInput _$ReminderInputFromJson(Map<String, dynamic> json) =>
    _ReminderInput(
      moment: DateTime.parse(json['momento'] as String),
      activityId: json['actividad_id'] as String?,
      eventId: json['evento_id'] as String?,
      goalId: json['meta_id'] as String?,
    );

Map<String, dynamic> _$ReminderInputToJson(_ReminderInput instance) =>
    <String, dynamic>{
      'momento': instance.moment.toIso8601String(),
      'actividad_id': instance.activityId,
      'evento_id': instance.eventId,
      'meta_id': instance.goalId,
    };
