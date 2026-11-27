import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment_input.dart';
import 'package:kairo/features/self_assessment/data/self_assessment_api.dart';

final selfAssessmentsProvider = FutureProvider<List<SelfAssessment>>((
  ref,
) async {
  final items = await ref.watch(selfAssessmentApiProvider).list();
  return [...items]..sort((a, b) => b.weekStart.compareTo(a.weekStart));
});

class SelfAssessmentFormController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> save(DateTime weekStart, SelfAssessmentInput input) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await ref.read(selfAssessmentApiProvider).save(weekStart, input);
      ref.invalidate(selfAssessmentsProvider);
    });
    if (ref.mounted) {
      state = result;
    }
    return !result.hasError;
  }
}

final selfAssessmentFormControllerProvider =
    AsyncNotifierProvider<SelfAssessmentFormController, void>(
      SelfAssessmentFormController.new,
      isAutoDispose: true,
    );
