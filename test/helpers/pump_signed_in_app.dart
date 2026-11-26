import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/app/kairo_app.dart';
import 'package:kairo/core/api/health_api.dart';
import 'package:kairo/core/api/models/health_status.dart';
import 'package:kairo/core/storage/token_storage.dart';
import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/capture/data/capture_api.dart';
import 'package:kairo/features/capture/data/shared_text_source.dart';
import 'package:kairo/features/goals/data/goals_api.dart';
import 'package:kairo/features/home/data/calendar_api.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';
import 'package:kairo/features/time_tracking/data/time_records_api.dart';
import 'package:kairo/features/time_tracking/data/timer_api.dart';

import 'fake_activities_api.dart';
import 'fake_calendar_api.dart';
import 'fake_capture_api.dart';
import 'fake_categories_api.dart';
import 'fake_goals_api.dart';
import 'fake_shared_text_source.dart';
import 'fake_subjects_api.dart';
import 'fake_time_records_api.dart';
import 'fake_timer_api.dart';
import 'memory_token_storage.dart';

Future<MemoryTokenStorage> pumpSignedInApp(
  WidgetTester tester, {
  FakeSubjectsApi? subjectsApi,
  FakeActivitiesApi? activitiesApi,
  FakeCategoriesApi? categoriesApi,
  FakeCalendarApi? calendarApi,
  FakeTimerApi? timerApi,
  FakeTimeRecordsApi? timeRecordsApi,
  FakeGoalsApi? goalsApi,
  FakeCaptureApi? captureApi,
  FakeSharedTextSource? sharedText,
  bool settle = true,
}) async {
  final storage = MemoryTokenStorage('token-guardado');
  await tester.pumpWidget(
    ProviderScope(
      retry: (retryCount, error) => null,
      overrides: [
        tokenStorageProvider.overrideWithValue(storage),
        subjectsApiProvider.overrideWithValue(subjectsApi ?? FakeSubjectsApi()),
        activitiesApiProvider.overrideWithValue(
          activitiesApi ?? FakeActivitiesApi(),
        ),
        categoriesApiProvider.overrideWithValue(
          categoriesApi ?? FakeCategoriesApi(),
        ),
        calendarApiProvider.overrideWithValue(calendarApi ?? FakeCalendarApi()),
        timerApiProvider.overrideWithValue(timerApi ?? FakeTimerApi()),
        timeRecordsApiProvider.overrideWithValue(
          timeRecordsApi ?? FakeTimeRecordsApi(),
        ),
        goalsApiProvider.overrideWithValue(goalsApi ?? FakeGoalsApi()),
        captureApiProvider.overrideWithValue(captureApi ?? FakeCaptureApi()),
        sharedTextSourceProvider.overrideWithValue(
          sharedText ?? FakeSharedTextSource(),
        ),
        healthStatusProvider.overrideWith(
          (ref) => Future.value(const HealthStatus(status: 'healthy')),
        ),
      ],
      child: const KairoApp(),
    ),
  );
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }
  return storage;
}
