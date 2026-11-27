import 'package:kairo/features/self_assessment/data/models/self_assessment.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment_input.dart';
import 'package:kairo/features/self_assessment/data/self_assessment_api.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';

class FakeSelfAssessmentApi implements SelfAssessmentApi {
  FakeSelfAssessmentApi({
    List<SelfAssessment> assessments = const [],
    this.listError,
    this.saveError,
  }) : _assessments = [...assessments];

  final List<SelfAssessment> _assessments;
  final Exception? listError;
  final Exception? saveError;
  final List<(DateTime, SelfAssessmentInput)> saved = [];

  @override
  Future<List<SelfAssessment>> list() async {
    final error = listError;
    if (error != null) {
      throw error;
    }
    return [..._assessments];
  }

  @override
  Future<SelfAssessment> save(
    DateTime weekStart,
    SelfAssessmentInput input,
  ) async {
    saved.add((weekStart, input));
    final error = saveError;
    if (error != null) {
      throw error;
    }
    final now = DateTime.now();
    final index = _assessments.indexWhere(
      (item) => Week.same(item.weekStart, weekStart),
    );
    final result = SelfAssessment(
      weekStart: weekStart,
      mood: input.mood,
      satisfaction: input.satisfaction,
      note: input.note,
      createdAt: index == -1 ? now : _assessments[index].createdAt,
      updatedAt: now,
    );
    if (index == -1) {
      _assessments.add(result);
    } else {
      _assessments[index] = result;
    }
    return result;
  }
}
