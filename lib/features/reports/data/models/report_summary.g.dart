// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportSummary _$ReportSummaryFromJson(Map<String, dynamic> json) =>
    _ReportSummary(
      generatedAt: DateTime.parse(json['generado_en'] as String),
      text: json['texto'] as String?,
      reason: json['motivo_sin_texto'] as String?,
    );

Map<String, dynamic> _$ReportSummaryToJson(_ReportSummary instance) =>
    <String, dynamic>{
      'generado_en': instance.generatedAt.toIso8601String(),
      'texto': instance.text,
      'motivo_sin_texto': instance.reason,
    };
