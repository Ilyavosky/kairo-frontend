import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject.freezed.dart';
part 'subject.g.dart';

@freezed
abstract class Subject with _$Subject {
  const factory Subject({
    required String id,
    @JsonKey(name: 'nombre') required String name,
    @JsonKey(name: 'periodo') required String period,
    @JsonKey(name: 'activa') required bool active,
    @JsonKey(name: 'docente') String? teacher,
    @JsonKey(name: 'clave') String? code,
  }) = _Subject;

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
}
