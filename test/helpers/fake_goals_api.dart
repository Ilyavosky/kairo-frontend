import 'package:kairo/features/goals/data/goals_api.dart';
import 'package:kairo/features/goals/data/models/goal.dart';
import 'package:kairo/features/goals/data/models/goal_evaluation.dart';
import 'package:kairo/features/goals/data/models/goal_progress.dart';

class FakeGoalsApi implements GoalsApi {
  FakeGoalsApi({
    List<Goal> goals = const [],
    this.progressById = const {},
    this.evaluations = const [],
    this.listError,
  }) : _goals = [...goals];

  final List<Goal> _goals;
  final Map<String, GoalProgress> progressById;
  final List<GoalEvaluation> evaluations;
  final Exception? listError;

  @override
  Future<List<Goal>> list({bool? active}) async {
    final error = listError;
    if (error != null) {
      throw error;
    }
    return [
      for (final goal in _goals)
        if (active == null || goal.active == active) goal,
    ];
  }

  @override
  Future<GoalProgress> progress(String goalId) async => progressById[goalId]!;

  @override
  Future<List<GoalEvaluation>> history({String? goalId}) async => [
    for (final evaluation in evaluations)
      if (goalId == null || evaluation.goalId == goalId) evaluation,
  ];
}
