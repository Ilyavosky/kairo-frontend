import 'package:freezed_annotation/freezed_annotation.dart';

part 'rest_week.freezed.dart';
part 'rest_week.g.dart';

@freezed
abstract class RestWeek with _$RestWeek {
  const factory RestWeek({
    @JsonKey(name: 'semana_desde') required DateTime weekStart,
    @JsonKey(name: 'minutos_academicos') required double academicMinutes,
    @JsonKey(name: 'minutos_sueno') required double sleepMinutes,
    @JsonKey(name: 'minutos_ejercicio') required double exerciseMinutes,
    @JsonKey(name: 'estado_animo') int? mood,
    @JsonKey(name: 'satisfaccion') int? satisfaction,
  }) = _RestWeek;

  factory RestWeek.fromJson(Map<String, dynamic> json) =>
      _$RestWeekFromJson(json);
}
