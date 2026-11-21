import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kairo/features/activities/domain/activity_modality.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
abstract class Activity with _$Activity {
  const factory Activity({
    required String id,
    @JsonKey(name: 'categoria_id') required String categoryId,
    @JsonKey(name: 'titulo') required String title,
    @JsonKey(name: 'prioridad') required int priority,
    @JsonKey(name: 'modalidad') required ActivityModality modality,
    @JsonKey(name: 'estado') required ActivityStatus status,
    @JsonKey(name: 'creada_en') required DateTime createdAt,
    @JsonKey(name: 'materia_id') String? subjectId,
    @JsonKey(name: 'descripcion') String? description,
    @JsonKey(name: 'vence_en') DateTime? dueAt,
    @JsonKey(name: 'completada_en') DateTime? completedAt,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
