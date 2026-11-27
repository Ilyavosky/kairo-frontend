import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_input.freezed.dart';
part 'reminder_input.g.dart';

@freezed
abstract class ReminderInput with _$ReminderInput {
  const factory ReminderInput({
    @JsonKey(name: 'momento') required DateTime moment,
    @JsonKey(name: 'actividad_id') String? activityId,
    @JsonKey(name: 'evento_id') String? eventId,
    @JsonKey(name: 'meta_id') String? goalId,
  }) = _ReminderInput;

  factory ReminderInput.fromJson(Map<String, dynamic> json) =>
      _$ReminderInputFromJson(json);
}
