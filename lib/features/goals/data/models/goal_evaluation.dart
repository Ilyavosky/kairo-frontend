import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_evaluation.freezed.dart';
part 'goal_evaluation.g.dart';

@freezed
abstract class GoalEvaluation with _$GoalEvaluation {
  const factory GoalEvaluation({
    required String id,
    @JsonKey(name: 'meta_id') required String goalId,
    @JsonKey(name: 'periodo_desde') required DateTime periodStart,
    @JsonKey(name: 'periodo_hasta') required DateTime periodEnd,
    @JsonKey(name: 'objetivo') required int target,
    @JsonKey(name: 'valor_logrado') required double achievedValue,
    @JsonKey(name: 'cumplida') required bool achieved,
  }) = _GoalEvaluation;

  factory GoalEvaluation.fromJson(Map<String, dynamic> json) =>
      _$GoalEvaluationFromJson(json);
}
