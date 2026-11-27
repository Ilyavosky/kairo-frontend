import 'package:freezed_annotation/freezed_annotation.dart';

part 'self_assessment.freezed.dart';
part 'self_assessment.g.dart';

@freezed
abstract class SelfAssessment with _$SelfAssessment {
  const factory SelfAssessment({
    @JsonKey(name: 'semana_desde') required DateTime weekStart,
    @JsonKey(name: 'estado_animo') required int mood,
    @JsonKey(name: 'satisfaccion') required int satisfaction,
    @JsonKey(name: 'creada_en') required DateTime createdAt,
    @JsonKey(name: 'actualizada_en') required DateTime updatedAt,
    @JsonKey(name: 'nota') String? note,
  }) = _SelfAssessment;

  factory SelfAssessment.fromJson(Map<String, dynamic> json) =>
      _$SelfAssessmentFromJson(json);
}
