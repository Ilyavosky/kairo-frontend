// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) =>
    _CalendarEvent(
      id: json['id'] as String,
      period: json['periodo'] as String,
      type: json['tipo'] as String,
      date: DateTime.parse(json['fecha'] as String),
      description: json['descripcion'] as String,
      endDate: json['fecha_fin'] == null
          ? null
          : DateTime.parse(json['fecha_fin'] as String),
    );

Map<String, dynamic> _$CalendarEventToJson(_CalendarEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'periodo': instance.period,
      'tipo': instance.type,
      'fecha': instance.date.toIso8601String(),
      'descripcion': instance.description,
      'fecha_fin': instance.endDate?.toIso8601String(),
    };
