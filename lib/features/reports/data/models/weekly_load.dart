import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_load.freezed.dart';
part 'weekly_load.g.dart';

@freezed
abstract class WeeklyLoad with _$WeeklyLoad {
  const factory WeeklyLoad({
    @JsonKey(name: 'semana_desde') required DateTime weekStart,
    @JsonKey(name: 'actividades_con_vencimiento') required int deliveries,
    @JsonKey(name: 'actividades_pendientes') required int pending,
    @JsonKey(name: 'minutos_registrados') required double minutes,
    @JsonKey(name: 'materia_id') String? subjectId,
    @JsonKey(name: 'materia') String? subject,
  }) = _WeeklyLoad;

  factory WeeklyLoad.fromJson(Map<String, dynamic> json) =>
      _$WeeklyLoadFromJson(json);
}
