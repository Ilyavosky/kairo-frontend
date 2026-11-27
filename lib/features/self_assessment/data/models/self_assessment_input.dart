import 'package:freezed_annotation/freezed_annotation.dart';

part 'self_assessment_input.freezed.dart';
part 'self_assessment_input.g.dart';

@freezed
abstract class SelfAssessmentInput with _$SelfAssessmentInput {
  const factory SelfAssessmentInput({
    @JsonKey(name: 'estado_animo') required int mood,
    @JsonKey(name: 'satisfaccion') required int satisfaction,
    @JsonKey(name: 'nota') String? note,
  }) = _SelfAssessmentInput;

  factory SelfAssessmentInput.fromJson(Map<String, dynamic> json) =>
      _$SelfAssessmentInputFromJson(json);
}
