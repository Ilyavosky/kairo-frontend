import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kairo/features/activities/domain/activity_modality.dart';

part 'activity_input.freezed.dart';
part 'activity_input.g.dart';

@freezed
abstract class ActivityInput with _$ActivityInput {
  const factory ActivityInput({
    @JsonKey(name: 'titulo') required String title,
    @JsonKey(name: 'prioridad') required int priority,
    @JsonKey(name: 'modalidad') required ActivityModality modality,
    @JsonKey(name: 'categoria_id') required String categoryId,
    @JsonKey(name: 'descripcion') String? description,
    @JsonKey(name: 'vence_en') DateTime? dueAt,
    @JsonKey(name: 'materia_id') String? subjectId,
  }) = _ActivityInput;

  factory ActivityInput.fromJson(Map<String, dynamic> json) =>
      _$ActivityInputFromJson(json);
}
