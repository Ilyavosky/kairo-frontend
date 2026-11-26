import 'package:kairo/features/goals/data/goals_api.dart';
import 'package:kairo/features/goals/data/models/goal.dart';
import 'package:kairo/features/goals/data/models/goal_evaluation.dart';
import 'package:kairo/features/goals/data/models/goal_input.dart';
import 'package:kairo/features/goals/data/models/goal_progress.dart';

class FakeGoalsApi implements GoalsApi {
  FakeGoalsApi({
    List<Goal> goals = const [],
    this.progressById = const {},
    this.evaluations = const [],
    this.listError,
    this.createError,
  }) : _goals = [...goals],
       _progress = {...progressById};

  final List<Goal> _goals;
  final Map<String, GoalProgress> progressById;
  final Map<String, GoalProgress> _progress;
  final Exception? createError;
  final List<GoalInput> created = [];
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
  Future<Goal> create(GoalInput input) async {
    final error = createError;
    if (error != null) {
      throw error;
    }
    created.add(input);
    final goal = Goal(
      id: 'nueva-${created.length}',
      categoryId: input.categoryId,
      type: input.type,
      period: input.period,
      target: input.target,
      validFrom: DateTime(2026, 11, 25),
      active: true,
    );
    _goals.add(goal);
    _progress[goal.id] = GoalProgress(
      goalId: goal.id,
      target: input.target,
      periodStart: DateTime(2026, 11, 23),
      periodEnd: DateTime(2026, 11, 30),
      progress: 0,
      percent: 0,
      achieved: false,
    );
    return goal;
  }

  @override
  Future<GoalProgress> progress(String goalId) async => _progress[goalId]!;

  @override
  Future<List<GoalEvaluation>> history({String? goalId}) async => [
    for (final evaluation in evaluations)
      if (goalId == null || evaluation.goalId == goalId) evaluation,
  ];
}
