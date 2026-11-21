// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityInput _$ActivityInputFromJson(Map<String, dynamic> json) =>
    _ActivityInput(
      title: json['titulo'] as String,
      priority: (json['prioridad'] as num).toInt(),
      modality: $enumDecode(_$ActivityModalityEnumMap, json['modalidad']),
      categoryId: json['categoria_id'] as String,
      description: json['descripcion'] as String?,
      dueAt: json['vence_en'] == null
          ? null
          : DateTime.parse(json['vence_en'] as String),
      subjectId: json['materia_id'] as String?,
    );

Map<String, dynamic> _$ActivityInputToJson(_ActivityInput instance) =>
    <String, dynamic>{
      'titulo': instance.title,
      'prioridad': instance.priority,
      'modalidad': _$ActivityModalityEnumMap[instance.modality]!,
      'categoria_id': instance.categoryId,
      'descripcion': instance.description,
      'vence_en': instance.dueAt?.toIso8601String(),
      'materia_id': instance.subjectId,
    };

const _$ActivityModalityEnumMap = {
  ActivityModality.inPerson: 'presencial',
  ActivityModality.online: 'en_linea',
  ActivityModality.hybrid: 'mixta',
};
