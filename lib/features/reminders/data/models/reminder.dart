import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kairo/features/reminders/domain/reminder_status.dart';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

@freezed
abstract class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    @JsonKey(name: 'momento') required DateTime moment,
    @JsonKey(name: 'estado_envio') required ReminderStatus status,
    @JsonKey(name: 'creado_en') required DateTime createdAt,
    @JsonKey(name: 'actividad_id') String? activityId,
    @JsonKey(name: 'evento_id') String? eventId,
    @JsonKey(name: 'meta_id') String? goalId,
    @JsonKey(name: 'intentos') @Default(0) int attempts,
    @JsonKey(name: 'enviado_en') DateTime? sentAt,
  }) = _Reminder;

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
}
