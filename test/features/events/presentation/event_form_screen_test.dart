import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/events/data/events_api.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/events/data/models/event_input.dart';
import 'package:kairo/features/events/domain/event_type.dart';
import 'package:kairo/features/events/presentation/controllers/event_form_controller.dart';

import '../../../helpers/fake_events_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  final now = DateTime.now();
  final start = DateTime(now.year, now.month, now.day, 23);
  final exam = Event(
    id: 'evento-1',
    title: 'Examen de redes',
    start: start,
    end: start.add(const Duration(minutes: 50)),
    type: EventType.exam,
    place: 'Aula 3',
  );

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('el formulario nuevo pide nombre y fechas', (tester) async {
    final api = FakeEventsApi();
    await pumpSignedInApp(tester, eventsApi: api);

    await tapVisible(tester, find.text('Agregar evento'));
    expect(find.text('Nuevo evento'), findsOneWidget);

    await tapVisible(tester, find.text('Guardar evento'));

    expect(find.text('Escribe el nombre del evento'), findsOneWidget);
    expect(find.text('Elige cuándo empieza'), findsOneWidget);
    expect(find.text('Elige cuándo termina'), findsOneWidget);
    expect(api.created, isEmpty);
  });

  testWidgets('tocar un evento de la agenda lo abre para editarlo', (
    tester,
  ) async {
    final api = FakeEventsApi(events: [exam]);
    await pumpSignedInApp(tester, eventsApi: api);

    await tapVisible(tester, find.text('Examen de redes'));

    expect(find.text('Editar evento'), findsOneWidget);
    expect(find.text('Examen'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Examen de redes'),
      'Examen final de redes',
    );
    await tapVisible(tester, find.text('Guardar cambios'));

    final input = api.updated['evento-1']!;
    expect(input.title, 'Examen final de redes');
    expect(input.type, EventType.exam);
    expect(input.place, 'Aula 3');
    expect(input.start, start);
    expect(find.text('Cambios guardados.'), findsOneWidget);
    expect(find.text('Examen final de redes'), findsOneWidget);
  });

  test('crear un evento lo manda a la API', () async {
    final api = FakeEventsApi();
    final container = ProviderContainer(
      overrides: [eventsApiProvider.overrideWithValue(api)],
    );
    addTearDown(container.dispose);
    container.listen(eventFormControllerProvider, (_, _) {});

    final saved = await container
        .read(eventFormControllerProvider.notifier)
        .save(
          input: EventInput(
            title: 'Entrega de proyecto',
            type: EventType.delivery,
            start: start,
            end: start.add(const Duration(hours: 1)),
          ),
        );

    expect(saved, isTrue);
    expect(api.created.single.title, 'Entrega de proyecto');
    expect(api.created.single.type, EventType.delivery);
  });

  test('si la API rechaza el evento deja el error', () async {
    final api = FakeEventsApi(
      saveError: const ValidationException('El fin debe ser posterior'),
    );
    final container = ProviderContainer(
      overrides: [eventsApiProvider.overrideWithValue(api)],
    );
    addTearDown(container.dispose);
    container.listen(eventFormControllerProvider, (_, _) {});

    final saved = await container
        .read(eventFormControllerProvider.notifier)
        .save(
          input: EventInput(
            title: 'Entrega',
            type: EventType.delivery,
            start: start,
            end: start.add(const Duration(hours: 1)),
          ),
        );

    expect(saved, isFalse);
    expect(
      container.read(eventFormControllerProvider).error,
      isA<ValidationException>(),
    );
  });
}
