import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kairo/features/goals/domain/goal_period.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

@freezed
abstract class Goal with _$Goal {
  const factory Goal({
    required String id,
    @JsonKey(name: 'categoria_id') required String categoryId,
    @JsonKey(name: 'tipo') required GoalType type,
    @JsonKey(name: 'periodo') required GoalPeriod period,
    @JsonKey(name: 'objetivo') required int target,
    @JsonKey(name: 'vigente_desde') required DateTime validFrom,
    @JsonKey(name: 'activa') required bool active,
    @JsonKey(name: 'vigente_hasta') DateTime? validUntil,
  }) = _Goal;

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
}
