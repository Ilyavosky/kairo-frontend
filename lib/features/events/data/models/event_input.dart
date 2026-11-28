import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kairo/features/events/domain/event_type.dart';

part 'event_input.freezed.dart';
part 'event_input.g.dart';

@freezed
abstract class EventInput with _$EventInput {
  const factory EventInput({
    @JsonKey(name: 'titulo') required String title,
    @JsonKey(name: 'tipo') required EventType type,
    @JsonKey(name: 'inicio') required DateTime start,
    @JsonKey(name: 'fin') required DateTime end,
    @JsonKey(name: 'lugar') String? place,
    @JsonKey(name: 'descripcion') String? description,
    @JsonKey(name: 'materia_id') String? subjectId,
    @JsonKey(name: 'actividad_id') String? activityId,
  }) = _EventInput;

  factory EventInput.fromJson(Map<String, dynamic> json) =>
      _$EventInputFromJson(json);
}
