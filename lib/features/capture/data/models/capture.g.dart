// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Capture _$CaptureFromJson(Map<String, dynamic> json) => _Capture(
  id: json['id'] as String,
  message: json['mensaje'] as String,
  kind: $enumDecode(_$CaptureKindEnumMap, json['entidad_tipo']),
  status: json['estado'] as String,
  fields: json['campos'] as Map<String, dynamic>,
  pending: (json['pendientes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  confidence: (json['confianza'] as num?)?.toDouble(),
  resultId: json['resultado_id'] as String?,
);

Map<String, dynamic> _$CaptureToJson(_Capture instance) => <String, dynamic>{
  'id': instance.id,
  'mensaje': instance.message,
  'entidad_tipo': _$CaptureKindEnumMap[instance.kind]!,
  'estado': instance.status,
  'campos': instance.fields,
  'pendientes': instance.pending,
  'confianza': instance.confidence,
  'resultado_id': instance.resultId,
};

const _$CaptureKindEnumMap = {
  CaptureKind.activity: 'actividad',
  CaptureKind.timeRecord: 'registro_tiempo',
  CaptureKind.goal: 'meta',
};
