import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kairo/features/goals/domain/goal_period.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';

part 'goal_report.freezed.dart';
part 'goal_report.g.dart';

@freezed
abstract class GoalReport with _$GoalReport {
  const factory GoalReport({
    @JsonKey(name: 'meta_id') required String goalId,
    @JsonKey(name: 'categoria') required String category,
    @JsonKey(name: 'tipo') required GoalType type,
    @JsonKey(name: 'periodo') required GoalPeriod period,
    @JsonKey(name: 'objetivo') required int target,
    @JsonKey(name: 'progreso') required double progress,
    @JsonKey(name: 'porcentaje') required double percent,
    @JsonKey(name: 'cumplida') required bool achieved,
  }) = _GoalReport;

  factory GoalReport.fromJson(Map<String, dynamic> json) =>
      _$GoalReportFromJson(json);
}
