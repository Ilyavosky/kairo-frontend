// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subject _$SubjectFromJson(Map<String, dynamic> json) => _Subject(
  id: json['id'] as String,
  name: json['nombre'] as String,
  period: json['periodo'] as String,
  active: json['activa'] as bool,
  teacher: json['docente'] as String?,
  code: json['clave'] as String?,
);

Map<String, dynamic> _$SubjectToJson(_Subject instance) => <String, dynamic>{
  'id': instance.id,
  'nombre': instance.name,
  'periodo': instance.period,
  'activa': instance.active,
  'docente': instance.teacher,
  'clave': instance.code,
};
