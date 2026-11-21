import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';
part 'calendar_event.g.dart';

@freezed
abstract class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent({
    required String id,
    @JsonKey(name: 'periodo') required String period,
    @JsonKey(name: 'tipo') required String type,
    @JsonKey(name: 'fecha') required DateTime date,
    @JsonKey(name: 'descripcion') required String description,
    @JsonKey(name: 'fecha_fin') DateTime? endDate,
  }) = _CalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);
}
