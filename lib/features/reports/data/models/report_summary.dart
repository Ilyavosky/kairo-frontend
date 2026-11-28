import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_summary.freezed.dart';
part 'report_summary.g.dart';

@freezed
abstract class ReportSummary with _$ReportSummary {
  const factory ReportSummary({
    @JsonKey(name: 'generado_en') required DateTime generatedAt,
    @JsonKey(name: 'texto') String? text,
    @JsonKey(name: 'motivo_sin_texto') String? reason,
  }) = _ReportSummary;

  factory ReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryFromJson(json);
}
