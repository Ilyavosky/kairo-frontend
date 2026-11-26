import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kairo/features/capture/domain/capture_kind.dart';

part 'capture.freezed.dart';
part 'capture.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
abstract class Capture with _$Capture {
  const factory Capture({
    required String id,
    @JsonKey(name: 'mensaje') required String message,
    @JsonKey(name: 'entidad_tipo') required CaptureKind kind,
    @JsonKey(name: 'estado') required String status,
    @JsonKey(name: 'campos') required Map<String, dynamic> fields,
    @JsonKey(name: 'pendientes') required List<String> pending,
    @JsonKey(name: 'confianza') double? confidence,
    @JsonKey(name: 'resultado_id') String? resultId,
  }) = _Capture;

  factory Capture.fromJson(Map<String, dynamic> json) =>
      _$CaptureFromJson(json);
}
