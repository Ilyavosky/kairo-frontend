// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserResponse _$UserResponseFromJson(Map<String, dynamic> json) =>
    _UserResponse(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['nombre'] as String,
      timezone: json['zona_horaria'] as String,
      registeredAt: DateTime.parse(json['fecha_registro'] as String),
      active: json['activo'] as bool,
      telegramId: (json['telegram_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserResponseToJson(_UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nombre': instance.name,
      'zona_horaria': instance.timezone,
      'fecha_registro': instance.registeredAt.toIso8601String(),
      'activo': instance.active,
      'telegram_id': instance.telegramId,
    };
