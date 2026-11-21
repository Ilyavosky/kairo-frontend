import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/app/kairo_app.dart';
import 'package:kairo/core/api/health_api.dart';
import 'package:kairo/core/api/models/health_status.dart';
import 'package:kairo/core/storage/token_storage.dart';
import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';

import 'fake_activities_api.dart';
import 'fake_categories_api.dart';
import 'fake_subjects_api.dart';
import 'memory_token_storage.dart';

Future<MemoryTokenStorage> pumpSignedInApp(
  WidgetTester tester, {
  FakeSubjectsApi? subjectsApi,
  FakeActivitiesApi? activitiesApi,
  FakeCategoriesApi? categoriesApi,
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
        healthStatusProvider.overrideWith(
          (ref) => Future.value(const HealthStatus(status: 'healthy')),
        ),
      ],
      child: const KairoApp(),
    ),
  );
  await tester.pumpAndSettle();
  return storage;
}
