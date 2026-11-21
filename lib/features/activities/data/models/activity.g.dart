// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Activity _$ActivityFromJson(Map<String, dynamic> json) => _Activity(
  id: json['id'] as String,
  categoryId: json['categoria_id'] as String,
  title: json['titulo'] as String,
  priority: (json['prioridad'] as num).toInt(),
  modality: $enumDecode(_$ActivityModalityEnumMap, json['modalidad']),
  status: $enumDecode(_$ActivityStatusEnumMap, json['estado']),
  createdAt: DateTime.parse(json['creada_en'] as String),
  subjectId: json['materia_id'] as String?,
  description: json['descripcion'] as String?,
  dueAt: json['vence_en'] == null
      ? null
      : DateTime.parse(json['vence_en'] as String),
  completedAt: json['completada_en'] == null
      ? null
      : DateTime.parse(json['completada_en'] as String),
);

Map<String, dynamic> _$ActivityToJson(_Activity instance) => <String, dynamic>{
  'id': instance.id,
  'categoria_id': instance.categoryId,
  'titulo': instance.title,
  'prioridad': instance.priority,
  'modalidad': _$ActivityModalityEnumMap[instance.modality]!,
  'estado': _$ActivityStatusEnumMap[instance.status]!,
  'creada_en': instance.createdAt.toIso8601String(),
  'materia_id': instance.subjectId,
  'descripcion': instance.description,
  'vence_en': instance.dueAt?.toIso8601String(),
  'completada_en': instance.completedAt?.toIso8601String(),
};

const _$ActivityModalityEnumMap = {
  ActivityModality.inPerson: 'presencial',
  ActivityModality.online: 'en_linea',
  ActivityModality.hybrid: 'mixta',
};

const _$ActivityStatusEnumMap = {
  ActivityStatus.pending: 'pendiente',
  ActivityStatus.inProgress: 'en_progreso',
  ActivityStatus.completed: 'completada',
  ActivityStatus.cancelled: 'cancelada',
};
