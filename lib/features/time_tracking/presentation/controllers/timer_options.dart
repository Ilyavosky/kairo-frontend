import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/activity_filter.dart';

final openActivitiesProvider = FutureProvider<List<Activity>>((ref) async {
  final activities = await ref
      .watch(activitiesApiProvider)
      .list(const ActivityFilter());
  return [
    for (final activity in activities)
      if (activity.status.isOpen) activity,
  ];
}, isAutoDispose: true);
