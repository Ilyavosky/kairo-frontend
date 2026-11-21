import 'package:flutter/foundation.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';

@immutable
class ActivityFilter {
  const ActivityFilter({this.status, this.subjectId});

  final ActivityStatus? status;
  final String? subjectId;

  ActivityFilter withStatus(ActivityStatus? status) =>
      ActivityFilter(status: status, subjectId: subjectId);

  ActivityFilter withSubject(String? subjectId) =>
      ActivityFilter(status: status, subjectId: subjectId);

  @override
  bool operator ==(Object other) =>
      other is ActivityFilter &&
      other.status == status &&
      other.subjectId == subjectId;

  @override
  int get hashCode => Object.hash(status, subjectId);
}
