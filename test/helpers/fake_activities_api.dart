import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/activity_filter.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';

class FakeActivitiesApi implements ActivitiesApi {
  FakeActivitiesApi({
    List<Activity> activities = const [],
    this.listError,
    this.completeError,
  }) : _activities = [...activities];

  final List<Activity> _activities;
  final Exception? listError;
  final Exception? completeError;
  final List<ActivityFilter> filters = [];
  final List<String> completedIds = [];
  final List<String> reopenedIds = [];

  @override
  Future<List<Activity>> list(ActivityFilter filter) async {
    filters.add(filter);
    final error = listError;
    if (error != null) {
      throw error;
    }
    return [
      for (final activity in _activities)
        if ((filter.status == null || activity.status == filter.status) &&
            (filter.subjectId == null ||
                activity.subjectId == filter.subjectId))
          activity,
    ];
  }

  @override
  Future<Activity> complete(String id) async {
    completedIds.add(id);
    final error = completeError;
    if (error != null) {
      throw error;
    }
    final index = _activities.indexWhere((activity) => activity.id == id);
    final completed = _activities[index].copyWith(
      status: ActivityStatus.completed,
      completedAt: DateTime.now(),
    );
    _activities[index] = completed;
    return completed;
  }

  @override
  Future<Activity> reopen(String id) async {
    reopenedIds.add(id);
    final error = completeError;
    if (error != null) {
      throw error;
    }
    final index = _activities.indexWhere((activity) => activity.id == id);
    final reopened = _activities[index].copyWith(
      status: ActivityStatus.pending,
    );
    _activities[index] = reopened;
    return reopened;
  }
}
