import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    @JsonKey(name: 'titulo') required String title,
    @JsonKey(name: 'inicio') required DateTime start,
    @JsonKey(name: 'fin') required DateTime end,
    @JsonKey(name: 'materia_id') String? subjectId,
    @JsonKey(name: 'lugar') String? place,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
