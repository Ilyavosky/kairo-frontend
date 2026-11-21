// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityCategory _$ActivityCategoryFromJson(Map<String, dynamic> json) =>
    _ActivityCategory(
      id: json['id'] as String,
      name: json['nombre'] as String,
      scope: json['ambito'] as String,
      system: json['del_sistema'] as bool,
    );

Map<String, dynamic> _$ActivityCategoryToJson(_ActivityCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.name,
      'ambito': instance.scope,
      'del_sistema': instance.system,
    };
