// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      name: json['nombre'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      timezone: json['zona_horaria'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'nombre': instance.name,
      'email': instance.email,
      'password': instance.password,
      'zona_horaria': instance.timezone,
    };
