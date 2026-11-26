import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/goals/data/goals_api.dart';
import 'package:kairo/features/goals/data/models/goal_input.dart';
import 'package:kairo/features/goals/presentation/controllers/goals_controller.dart';

class GoalFormController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> create(GoalInput input) =>
      _run(() => ref.read(goalsApiProvider).create(input));

  Future<bool> updateTarget(String goalId, int target) =>
      _run(() => ref.read(goalsApiProvider).updateTarget(goalId, target));

  Future<bool> deactivate(String goalId) =>
      _run(() => ref.read(goalsApiProvider).deactivate(goalId));

  Future<bool> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await action();
      ref
        ..invalidate(activeGoalsProvider)
        ..invalidate(goalHistoryProvider);
    });
    if (ref.mounted) {
      state = result;
    }
    return !result.hasError;
  }
}

final goalFormControllerProvider =
    AsyncNotifierProvider<GoalFormController, void>(
      GoalFormController.new,
      isAutoDispose: true,
    );
