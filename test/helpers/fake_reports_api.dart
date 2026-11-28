import 'dart:async';

import 'package:kairo/features/reports/data/models/goal_report.dart';
import 'package:kairo/features/reports/data/models/report_summary.dart';
import 'package:kairo/features/reports/data/models/rest_week.dart';
import 'package:kairo/features/reports/data/models/weekly_load.dart';
import 'package:kairo/features/reports/data/reports_api.dart';

class FakeReportsApi implements ReportsApi {
  FakeReportsApi({
    this.loads = const [],
    this.rest = const [],
    this.goalReports = const [],
    this.summaryText,
    this.loadError,
    this.summaryHold,
  });

  final List<WeeklyLoad> loads;
  final List<RestWeek> rest;
  final List<GoalReport> goalReports;
  final String? summaryText;
  final Exception? loadError;
  final Completer<void>? summaryHold;

  @override
  Future<List<WeeklyLoad>> weeklyLoad() async {
    final error = loadError;
    if (error != null) {
      throw error;
    }
    return loads;
  }

  @override
  Future<List<RestWeek>> loadVsRest() async => rest;

  @override
  Future<List<GoalReport>> goals() async => goalReports;

  @override
  Future<ReportSummary> summary() async {
    final hold = summaryHold;
    if (hold != null) {
      await hold.future;
    }
    return ReportSummary(
      generatedAt: DateTime(2026, 11, 27),
      text: summaryText,
      reason: summaryText == null ? 'proveedor_no_disponible' : null,
    );
  }
}
