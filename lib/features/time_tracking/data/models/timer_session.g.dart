// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimerSession _$TimerSessionFromJson(Map<String, dynamic> json) =>
    _TimerSession(
      id: json['id'] as String,
      categoryId: json['categoria_id'] as String,
      startedAt: DateTime.parse(json['iniciada_en'] as String),
      elapsedSeconds: (json['transcurrido_s'] as num).toInt(),
      activityId: json['actividad_id'] as String?,
    );

Map<String, dynamic> _$TimerSessionToJson(_TimerSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoria_id': instance.categoryId,
      'iniciada_en': instance.startedAt.toIso8601String(),
      'transcurrido_s': instance.elapsedSeconds,
      'actividad_id': instance.activityId,
    };
