import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/goals/data/goals_api.dart';
import 'package:kairo/features/goals/data/models/goal.dart';
import 'package:kairo/features/goals/data/models/goal_evaluation.dart';
import 'package:kairo/features/goals/data/models/goal_progress.dart';

@immutable
class GoalWithProgress {
  const GoalWithProgress({required this.goal, required this.progress});

  final Goal goal;
  final GoalProgress progress;
}

@immutable
class GoalHistoryEntry {
  const GoalHistoryEntry({required this.evaluation, required this.goal});

  final GoalEvaluation evaluation;
  final Goal? goal;
}

final activeGoalsProvider = FutureProvider<List<GoalWithProgress>>((ref) async {
  final api = ref.watch(goalsApiProvider);
  final goals = await api.list(active: true);
  final progress = await Future.wait([
    for (final goal in goals) api.progress(goal.id),
  ]);
  return [
    for (var i = 0; i < goals.length; i++)
      GoalWithProgress(goal: goals[i], progress: progress[i]),
  ];
});

final goalHistoryProvider = FutureProvider<List<GoalHistoryEntry>>((ref) async {
  final api = ref.watch(goalsApiProvider);
  final goals = await api.list();
  final evaluations = await api.history();
  final byId = {for (final goal in goals) goal.id: goal};
  final sorted = [...evaluations]
    ..sort((a, b) => b.periodStart.compareTo(a.periodStart));
  return [
    for (final evaluation in sorted)
      GoalHistoryEntry(evaluation: evaluation, goal: byId[evaluation.goalId]),
  ];
});
