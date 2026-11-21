import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_input.freezed.dart';
part 'subject_input.g.dart';

@freezed
abstract class SubjectInput with _$SubjectInput {
  const factory SubjectInput({
    @JsonKey(name: 'nombre') required String name,
    @JsonKey(name: 'periodo') required String period,
    @JsonKey(name: 'docente') String? teacher,
    @JsonKey(name: 'clave') String? code,
  }) = _SubjectInput;

  factory SubjectInput.fromJson(Map<String, dynamic> json) =>
      _$SubjectInputFromJson(json);
}
