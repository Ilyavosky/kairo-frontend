import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/app/kairo_app.dart';
import 'package:kairo/core/api/health_api.dart';
import 'package:kairo/core/api/models/health_status.dart';
import 'package:kairo/core/storage/token_storage.dart';
import 'package:kairo/features/account/data/account_api.dart';
import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/capture/data/capture_api.dart';
import 'package:kairo/features/capture/data/shared_text_source.dart';
import 'package:kairo/features/events/data/events_api.dart';
import 'package:kairo/features/goals/data/goals_api.dart';
import 'package:kairo/features/home/data/calendar_api.dart';
import 'package:kairo/features/reminders/data/reminders_api.dart';
import 'package:kairo/features/reports/data/reports_api.dart';
import 'package:kairo/features/self_assessment/data/self_assessment_api.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';
import 'package:kairo/features/telegram/data/link_opener.dart';
import 'package:kairo/features/telegram/data/telegram_api.dart';
import 'package:kairo/features/telegram/presentation/controllers/telegram_controller.dart';
import 'package:kairo/features/time_tracking/data/time_records_api.dart';
import 'package:kairo/features/time_tracking/data/timer_api.dart';

import 'fake_account_api.dart';
import 'fake_activities_api.dart';
import 'fake_calendar_api.dart';
import 'fake_capture_api.dart';
import 'fake_categories_api.dart';
import 'fake_events_api.dart';
import 'fake_goals_api.dart';
import 'fake_link_opener.dart';
import 'fake_reminders_api.dart';
import 'fake_reports_api.dart';
import 'fake_self_assessment_api.dart';
import 'fake_shared_text_source.dart';
import 'fake_subjects_api.dart';
import 'fake_telegram_api.dart';
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
  FakeRemindersApi? remindersApi,
  FakeEventsApi? eventsApi,
  FakeSelfAssessmentApi? selfAssessmentApi,
  FakeReportsApi? reportsApi,
  FakeAccountApi? accountApi,
  FakeTelegramApi? telegramApi,
  FakeLinkOpener? linkOpener,
  String telegramBot = '',
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
        remindersApiProvider.overrideWithValue(
          remindersApi ?? FakeRemindersApi(),
        ),
        eventsApiProvider.overrideWithValue(eventsApi ?? FakeEventsApi()),
        selfAssessmentApiProvider.overrideWithValue(
          selfAssessmentApi ?? FakeSelfAssessmentApi(),
        ),
        reportsApiProvider.overrideWithValue(reportsApi ?? FakeReportsApi()),
        accountApiProvider.overrideWithValue(accountApi ?? FakeAccountApi()),
        telegramApiProvider.overrideWithValue(telegramApi ?? FakeTelegramApi()),
        linkOpenerProvider.overrideWithValue(linkOpener ?? FakeLinkOpener()),
        telegramBotProvider.overrideWithValue(telegramBot),
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
