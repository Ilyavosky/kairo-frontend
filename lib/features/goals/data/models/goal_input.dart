import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kairo/features/goals/domain/goal_period.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';

part 'goal_input.freezed.dart';
part 'goal_input.g.dart';

@freezed
abstract class GoalInput with _$GoalInput {
  const factory GoalInput({
    @JsonKey(name: 'categoria_id') required String categoryId,
    @JsonKey(name: 'tipo') required GoalType type,
    @JsonKey(name: 'periodo') required GoalPeriod period,
    @JsonKey(name: 'objetivo') required int target,
  }) = _GoalInput;

  factory GoalInput.fromJson(Map<String, dynamic> json) =>
      _$GoalInputFromJson(json);
}
