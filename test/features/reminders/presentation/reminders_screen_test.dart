import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/activity_modality.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/reminders/data/models/reminder.dart';
import 'package:kairo/features/reminders/domain/reminder_status.dart';

import '../../../helpers/fake_activities_api.dart';
import '../../../helpers/fake_events_api.dart';
import '../../../helpers/fake_reminders_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  final soon = DateTime.now().add(const Duration(days: 2));
  final report = Activity(
    id: 'actividad-1',
    categoryId: 'categoria-1',
    title: 'Reporte de redes',
    priority: 3,
    modality: ActivityModality.online,
    status: ActivityStatus.pending,
    createdAt: DateTime(2026, 11),
  );
  final exam = Event(
    id: 'evento-1',
    title: 'Examen de cálculo',
    start: soon,
    end: soon.add(const Duration(hours: 2)),
  );

  Reminder reminder(
    String id,
    ReminderStatus status, {
    String? activityId,
    String? eventId,
  }) => Reminder(
    id: id,
    moment: soon,
    status: status,
    createdAt: DateTime(2026, 11, 20),
    activityId: activityId,
    eventId: eventId,
  );

  Future<void> openReminders(WidgetTester tester, FakeRemindersApi api) async {
    await pumpSignedInApp(
      tester,
      remindersApi: api,
      activitiesApi: FakeActivitiesApi(activities: [report]),
      eventsApi: FakeEventsApi(events: [exam]),
    );
    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Recordatorios'));
    await tester.pumpAndSettle();
  }

  testWidgets('sin recordatorios muestra el estado vacío', (tester) async {
    await openReminders(tester, FakeRemindersApi());

    expect(find.text('No tienes recordatorios próximos'), findsOneWidget);
  });

  testWidgets('muestra los próximos con el nombre de lo que avisan', (
    tester,
  ) async {
    await openReminders(
      tester,
      FakeRemindersApi(
        reminders: [
          reminder('r1', ReminderStatus.pending, activityId: 'actividad-1'),
          reminder('r2', ReminderStatus.failed, eventId: 'evento-1'),
        ],
      ),
    );

    expect(find.text('Reporte de redes'), findsOneWidget);
    expect(find.text('Examen de cálculo'), findsNothing);

    await tester.tap(find.text('Enviados'));
    await tester.pumpAndSettle();

    expect(find.text('Examen de cálculo'), findsOneWidget);
    expect(find.textContaining('No se pudo enviar'), findsOneWidget);
  });

  testWidgets('quitar un recordatorio lo cancela en la API', (tester) async {
    final api = FakeRemindersApi(
      reminders: [
        reminder('r1', ReminderStatus.pending, activityId: 'actividad-1'),
      ],
    );
    await openReminders(tester, api);

    await tester.tap(find.byTooltip('Quitar recordatorio'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Quitar'));
    await tester.pumpAndSettle();

    expect(api.cancelled, ['r1']);
    expect(find.text('Recordatorio quitado.'), findsOneWidget);
    expect(find.text('No tienes recordatorios próximos'), findsOneWidget);
  });

  testWidgets('si falla la carga deja reintentar', (tester) async {
    await openReminders(
      tester,
      FakeRemindersApi(listError: const NetworkException()),
    );

    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('el formulario pide destino y fecha', (tester) async {
    final api = FakeRemindersApi();
    await openReminders(tester, api);

    await tester.tap(find.byTooltip('Nuevo recordatorio'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Guardar recordatorio'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar recordatorio'));
    await tester.pumpAndSettle();

    expect(find.text('Elige a qué se refiere el recordatorio'), findsOneWidget);
    expect(find.text('Elige la fecha y hora del aviso'), findsOneWidget);
    expect(api.created, isEmpty);
  });

  testWidgets('el selector muestra las opciones del destino elegido', (
    tester,
  ) async {
    await openReminders(tester, FakeRemindersApi());

    await tester.tap(find.byTooltip('Nuevo recordatorio'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Selecciona una actividad'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reporte de redes').last);
    await tester.pumpAndSettle();

    expect(find.text('Reporte de redes'), findsOneWidget);

    await tester.tap(find.text('Evento'));
    await tester.pumpAndSettle();

    expect(find.text('Reporte de redes'), findsNothing);

    await tester.tap(find.text('Selecciona un evento'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Examen de cálculo'), findsOneWidget);

    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Meta'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Selecciona una meta'));
    await tester.pumpAndSettle();

    expect(find.text('No tienes metas activas.'), findsOneWidget);
  });
}
