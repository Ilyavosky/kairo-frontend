import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_input.dart';
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
  final List<ActivityInput> created = [];
  final Map<String, ActivityInput> updated = {};
  var _nextId = 1;

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
  Future<List<Activity>> listDueBetween(DateTime from, DateTime to) async {
    final error = listError;
    if (error != null) {
      throw error;
    }
    return [
      for (final activity in _activities)
        if (activity.dueAt != null &&
            !activity.dueAt!.isBefore(from) &&
            !activity.dueAt!.isAfter(to))
          activity,
    ];
  }

  @override
  Future<Activity> create(ActivityInput input) async {
    created.add(input);
    final activity = Activity(
      id: 'nueva-${_nextId++}',
      categoryId: input.categoryId,
      title: input.title,
      priority: input.priority,
      modality: input.modality,
      status: ActivityStatus.pending,
      createdAt: DateTime.now(),
      subjectId: input.subjectId,
      description: input.description,
      dueAt: input.dueAt,
    );
    _activities.add(activity);
    return activity;
  }

  @override
  Future<Activity> update(String id, ActivityInput input) async {
    updated[id] = input;
    final index = _activities.indexWhere((activity) => activity.id == id);
    final saved = _activities[index].copyWith(
      categoryId: input.categoryId,
      title: input.title,
      priority: input.priority,
      modality: input.modality,
      subjectId: input.subjectId,
      description: input.description,
      dueAt: input.dueAt,
    );
    _activities[index] = saved;
    return saved;
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
