import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_progress.freezed.dart';
part 'goal_progress.g.dart';

@freezed
abstract class GoalProgress with _$GoalProgress {
  const factory GoalProgress({
    @JsonKey(name: 'meta_id') required String goalId,
    @JsonKey(name: 'objetivo') required int target,
    @JsonKey(name: 'periodo_desde') required DateTime periodStart,
    @JsonKey(name: 'periodo_hasta') required DateTime periodEnd,
    @JsonKey(name: 'progreso') required double progress,
    @JsonKey(name: 'porcentaje') required double percent,
    @JsonKey(name: 'cumplida') required bool achieved,
  }) = _GoalProgress;

  factory GoalProgress.fromJson(Map<String, dynamic> json) =>
      _$GoalProgressFromJson(json);
}
