// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectInput _$SubjectInputFromJson(Map<String, dynamic> json) =>
    _SubjectInput(
      name: json['nombre'] as String,
      period: json['periodo'] as String,
      teacher: json['docente'] as String?,
      code: json['clave'] as String?,
    );

Map<String, dynamic> _$SubjectInputToJson(_SubjectInput instance) =>
    <String, dynamic>{
      'nombre': instance.name,
      'periodo': instance.period,
      'docente': instance.teacher,
      'clave': instance.code,
    };
