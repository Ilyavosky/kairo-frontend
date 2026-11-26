import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/capture/domain/capture_fields.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_options.dart';

final captureLookupsProvider = Provider<CaptureLookups>((ref) {
  final categories =
      ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
  final subjects = ref.watch(subjectsProvider).value ?? const <Subject>[];
  final activities =
      ref.watch(openActivitiesProvider).value ?? const <Activity>[];
  return (
    categories: {for (final c in categories) c.id: c.name},
    subjects: {for (final s in subjects) s.id: s.name},
    activities: {for (final a in activities) a.id: a.title},
  );
}, isAutoDispose: true);
