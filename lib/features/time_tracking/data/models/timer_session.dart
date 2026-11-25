import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_session.freezed.dart';
part 'timer_session.g.dart';

@freezed
abstract class TimerSession with _$TimerSession {
  const factory TimerSession({
    required String id,
    @JsonKey(name: 'categoria_id') required String categoryId,
    @JsonKey(name: 'iniciada_en') required DateTime startedAt,
    @JsonKey(name: 'transcurrido_s') required int elapsedSeconds,
    @JsonKey(name: 'actividad_id') String? activityId,
  }) = _TimerSession;

  factory TimerSession.fromJson(Map<String, dynamic> json) =>
      _$TimerSessionFromJson(json);
}
