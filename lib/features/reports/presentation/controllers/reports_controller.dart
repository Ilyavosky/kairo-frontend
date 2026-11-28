import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/reports/data/models/goal_report.dart';
import 'package:kairo/features/reports/data/models/report_summary.dart';
import 'package:kairo/features/reports/data/models/rest_week.dart';
import 'package:kairo/features/reports/data/models/weekly_load.dart';
import 'package:kairo/features/reports/data/reports_api.dart';

@immutable
class ReportsData {
  const ReportsData({
    required this.loads,
    required this.rest,
    required this.goals,
  });

  final List<WeeklyLoad> loads;
  final List<RestWeek> rest;
  final List<GoalReport> goals;
}

final reportsProvider = FutureProvider<ReportsData>((ref) async {
  final api = ref.watch(reportsApiProvider);
  final results = await Future.wait<Object>([
    api.weeklyLoad(),
    api.loadVsRest(),
    api.goals(),
  ]);
  return ReportsData(
    loads: results[0] as List<WeeklyLoad>,
    rest: results[1] as List<RestWeek>,
    goals: results[2] as List<GoalReport>,
  );
}, isAutoDispose: true);

final reportSummaryProvider = FutureProvider<ReportSummary>(
  (ref) => ref.watch(reportsApiProvider).summary(),
  isAutoDispose: true,
);

class SelectedReportWeek extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  DateTime? get week => state;

  set week(DateTime? value) => state = value;
}

final selectedReportWeekProvider =
    NotifierProvider<SelectedReportWeek, DateTime?>(
      SelectedReportWeek.new,
      isAutoDispose: true,
    );
