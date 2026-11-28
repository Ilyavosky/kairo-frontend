import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kairo/features/events/domain/event_type.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    @JsonKey(name: 'titulo') required String title,
    @JsonKey(name: 'inicio') required DateTime start,
    @JsonKey(name: 'fin') required DateTime end,
    @JsonKey(name: 'tipo', unknownEnumValue: EventType.personal)
    @Default(EventType.personal)
    EventType type,
    @JsonKey(name: 'actividad_id') String? activityId,
    @JsonKey(name: 'materia_id') String? subjectId,
    @JsonKey(name: 'lugar') String? place,
    @JsonKey(name: 'descripcion') String? description,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
