import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/activities/domain/activity_modality.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/home/data/models/calendar_event.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/time_tracking/data/models/timer_session.dart';

import '../../../helpers/fake_activities_api.dart';
import '../../../helpers/fake_calendar_api.dart';
import '../../../helpers/fake_categories_api.dart';
import '../../../helpers/fake_subjects_api.dart';
import '../../../helpers/fake_timer_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  const security = Subject(
    id: 'materia-1',
    name: 'Seguridad informática',
    period: 'Ago - Dic 2026',
    active: true,
  );

  Activity activity(String id, String title, DateTime dueAt) => Activity(
    id: id,
    categoryId: 'categoria-1',
    title: title,
    priority: 3,
    modality: ActivityModality.inPerson,
    status: ActivityStatus.pending,
    createdAt: today,
    subjectId: 'materia-1',
    dueAt: dueAt,
  );

  testWidgets('sin entregas muestra los siete días vacíos', (tester) async {
    await pumpSignedInApp(tester);

    expect(find.text('Próximos 7 días'), findsOneWidget);
    expect(find.text('No tienes entregas esta semana.'), findsOneWidget);
    expect(find.text('Hoy'), findsOneWidget);
  });

  testWidgets('muestra las entregas y el calendario del día', (tester) async {
    await pumpSignedInApp(
      tester,
      subjectsApi: FakeSubjectsApi(subjects: [security]),
      activitiesApi: FakeActivitiesApi(
        activities: [
          activity('a1', 'Reporte de práctica 3', today.add(
            const Duration(hours: 23, minutes: 30),
          )),
          activity('a2', 'Fuera de la semana', today.add(
            const Duration(days: 9),
          )),
        ],
      ),
      calendarApi: FakeCalendarApi(
        events: [
          CalendarEvent(
            id: 'e1',
            period: 'Ago - Dic 2026',
            type: 'inhabil',
            date: today,
            description: 'Día de la Revolución',
          ),
        ],
      ),
    );

    expect(find.text('Tienes 1 entrega esta semana.'), findsOneWidget);
    expect(find.text('Reporte de práctica 3'), findsOneWidget);
    expect(find.text('23:30'), findsOneWidget);
    expect(find.text('Seguridad informática'), findsOneWidget);
    expect(find.text('Día de la Revolución'), findsOneWidget);
    expect(find.text('Día inhábil'), findsOneWidget);
    expect(find.text('Fuera de la semana'), findsNothing);
  });

  testWidgets('al tocar una entrega abre su detalle', (tester) async {
    await pumpSignedInApp(
      tester,
      activitiesApi: FakeActivitiesApi(
        activities: [
          activity('a1', 'Reporte de práctica 3', today.add(
            const Duration(hours: 23, minutes: 30),
          )),
        ],
      ),
    );

    await tester.tap(find.text('Reporte de práctica 3'));
    await tester.pumpAndSettle();

    expect(find.text('Editar actividad'), findsOneWidget);
    expect(find.text('Marcar como completada'), findsOneWidget);
  });

  testWidgets('si falla la carga muestra el error y reintentar', (
    tester,
  ) async {
    await pumpSignedInApp(
      tester,
      calendarApi: FakeCalendarApi(listError: const NetworkException()),
    );

    expect(find.text(const NetworkException().message), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('con un temporizador corriendo lo muestra y lo detiene', (
    tester,
  ) async {
    final timerApi = FakeTimerApi(
      running: TimerSession(
        id: 'sesion-1',
        categoryId: 'categoria-estudio',
        startedAt: now.subtract(const Duration(minutes: 20)),
        elapsedSeconds: 1200,
      ),
    );
    await pumpSignedInApp(
      tester,
      timerApi: timerApi,
      categoriesApi: FakeCategoriesApi(
        categories: const [
          ActivityCategory(
            id: 'categoria-estudio',
            name: 'Estudio',
            scope: 'ambas',
            system: true,
          ),
        ],
      ),
      settle: false,
    );

    expect(find.text('Cronometrando Estudio'), findsOneWidget);
    expect(find.text('00:20:00'), findsOneWidget);

    await tester.ensureVisible(find.text('Detener'));
    await tester.tap(find.text('Detener'));
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(timerApi.stopNotes, hasLength(1));
    expect(find.text('Cronometrando Estudio'), findsNothing);
    expect(find.text('Guardado: 20 min de Estudio.'), findsOneWidget);
  });
}
