import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/capture/data/models/capture.dart';
import 'package:kairo/features/capture/domain/capture_kind.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';

import '../../../helpers/fake_capture_api.dart';
import '../../../helpers/fake_categories_api.dart';
import '../../../helpers/fake_shared_text_source.dart';
import '../../../helpers/fake_subjects_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  const homework = ActivityCategory(
    id: 'categoria-tarea',
    name: 'Tarea',
    scope: 'academica',
    system: true,
  );
  const networks = Subject(
    id: 'materia-redes',
    name: 'Redes',
    period: 'Ago - Dic 2026',
    active: true,
  );

  const proposal = Capture(
    id: 'captura-1',
    message: '',
    kind: CaptureKind.activity,
    status: 'pendiente',
    fields: {
      'titulo': 'Entregar reporte de redes',
      'categoria_id': 'categoria-tarea',
      'materia_id': 'materia-redes',
      'vence_en': null,
      'prioridad': 3,
      'modalidad': 'en_linea',
    },
    pending: ['vence_en'],
    confidence: 0.82,
  );

  Future<void> openCapture(
    WidgetTester tester, {
    FakeCaptureApi? api,
    FakeSharedTextSource? sharedText,
  }) async {
    await pumpSignedInApp(
      tester,
      captureApi: api ?? FakeCaptureApi(proposal: proposal),
      sharedText: sharedText,
      categoriesApi: FakeCategoriesApi(categories: [homework]),
      subjectsApi: FakeSubjectsApi(subjects: [networks]),
    );
    if (find.text('Capturar mensaje').evaluate().isEmpty) {
      await tester.tap(find.text('Capturar un mensaje'));
      await tester.pumpAndSettle();
    }
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('pide un mensaje antes de interpretar', (tester) async {
    final api = FakeCaptureApi(proposal: proposal);
    await openCapture(tester, api: api);

    await tapVisible(tester, find.text('Interpretar mensaje'));

    expect(find.text('Escribe o pega un mensaje'), findsOneWidget);
    expect(api.sentTexts, isEmpty);
  });

  testWidgets('muestra lo que entendió Kairo en la tarjeta', (tester) async {
    await openCapture(tester);

    await tester.enterText(
      find.byType(TextFormField),
      'Entregar reporte de redes el viernes',
    );
    await tapVisible(tester, find.text('Interpretar mensaje'));

    expect(find.text('Actividad'), findsOneWidget);
    expect(find.text('Entregar reporte de redes'), findsOneWidget);
    expect(find.text('Tarea'), findsOneWidget);
    expect(find.text('Redes'), findsOneWidget);
    expect(find.text('3 · Media'), findsOneWidget);
    expect(find.text('En línea'), findsOneWidget);
    expect(find.text('Pendiente'), findsOneWidget);
    expect(find.text('1 dato pendiente'), findsOneWidget);
    expect(find.text('Confianza 82 %'), findsOneWidget);

    await tapVisible(tester, find.text('Mensaje original'));

    expect(find.text('Entregar reporte de redes el viernes'), findsOneWidget);
  });

  testWidgets('confirmar guarda y regresa a Inicio', (tester) async {
    final api = FakeCaptureApi(proposal: proposal);
    await openCapture(tester, api: api);

    await tester.enterText(find.byType(TextFormField), 'Entregar reporte');
    await tapVisible(tester, find.text('Interpretar mensaje'));
    await tapVisible(tester, find.text('Confirmar'));

    expect(api.confirmed, ['captura-1']);
    expect(find.text('Capturar mensaje'), findsNothing);
    expect(find.text('Guardado como actividad.'), findsOneWidget);
  });

  testWidgets('rechazar descarta y deja escribir otro mensaje', (tester) async {
    final api = FakeCaptureApi(proposal: proposal);
    await openCapture(tester, api: api);

    await tester.enterText(find.byType(TextFormField), 'Entregar reporte');
    await tapVisible(tester, find.text('Interpretar mensaje'));
    await tapVisible(tester, find.text('Rechazar'));

    expect(api.discarded, ['captura-1']);
    expect(find.text('Interpretar mensaje'), findsOneWidget);
    expect(
      find.text('Mensaje descartado. Puedes escribir otro.'),
      findsOneWidget,
    );
  });

  testWidgets('mientras interpreta no deja enviar dos veces', (tester) async {
    final hold = Completer<void>();
    final api = FakeCaptureApi(proposal: proposal, hold: hold);
    await openCapture(tester, api: api);

    await tester.enterText(find.byType(TextFormField), 'Entregar reporte');
    await tester.tap(find.text('Interpretar mensaje'));
    await tester.pump();

    expect(find.text('Interpretando…'), findsOneWidget);
    await tester.tap(find.text('Interpretando…'), warnIfMissed: false);
    await tester.pump();

    hold.complete();
    await tester.pumpAndSettle();

    expect(api.sentTexts, hasLength(1));
    expect(find.text('Confirmar'), findsOneWidget);
  });

  FakeCaptureApi unavailable() => FakeCaptureApi(
    createError: const ServiceUnavailableException(
      'No se pudo interpretar el mensaje; usa el formulario manual',
    ),
  );

  testWidgets('si el modelo no responde abre el formulario con el texto', (
    tester,
  ) async {
    await openCapture(tester, api: unavailable());

    await tester.enterText(
      find.byType(TextFormField),
      'Entregar reporte de redes\nEl viernes antes de las 11',
    );
    await tapVisible(tester, find.text('Interpretar mensaje'));

    expect(find.text('Nueva actividad'), findsOneWidget);
    expect(
      find.widgetWithText(TextFormField, 'Entregar reporte de redes'),
      findsOneWidget,
    );
    expect(
      find.widgetWithText(
        TextFormField,
        'Entregar reporte de redes\nEl viernes antes de las 11',
      ),
      findsOneWidget,
    );
  });

  testWidgets('al volver del formulario muestra el aviso y deja abrirlo', (
    tester,
  ) async {
    await openCapture(tester, api: unavailable());

    await tester.enterText(find.byType(TextFormField), 'Entregar reporte');
    await tapVisible(tester, find.text('Interpretar mensaje'));
    await tester.tap(find.byTooltip('Regresar'));
    await tester.pumpAndSettle();

    expect(find.text('Capturar mensaje'), findsOneWidget);
    expect(
      find.text('No se pudo interpretar el mensaje; usa el formulario manual'),
      findsOneWidget,
    );

    await tapVisible(tester, find.text('Llenar formulario manual'));

    expect(find.text('Nueva actividad'), findsOneWidget);
  });

  testWidgets('guardar desde el formulario manual regresa a Inicio', (
    tester,
  ) async {
    await openCapture(tester, api: unavailable());

    await tester.enterText(find.byType(TextFormField), 'Entregar reporte');
    await tapVisible(tester, find.text('Interpretar mensaje'));
    await tapVisible(tester, find.text('Selecciona una categoría'));
    await tester.tap(find.text('Tarea').last);
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('Guardar actividad'));

    expect(find.text('Nueva actividad'), findsNothing);
    expect(find.text('Capturar mensaje'), findsNothing);
    expect(find.text('Guardado como actividad.'), findsOneWidget);
  });

  testWidgets('un texto compartido desde otra app abre Kairo con el texto', (
    tester,
  ) async {
    await openCapture(
      tester,
      sharedText: FakeSharedTextSource(
        initialText: 'Mañana examen de redes a las 8',
      ),
    );

    expect(find.text('Capturar mensaje'), findsOneWidget);
    final field = tester.widget<TextFormField>(find.byType(TextFormField));
    expect(field.controller?.text, 'Mañana examen de redes a las 8');
  });

  testWidgets('compartir con la app abierta también carga el texto', (
    tester,
  ) async {
    final shared = FakeSharedTextSource();
    await openCapture(tester, sharedText: shared);

    shared.share('Junta del equipo el lunes');
    await tester.pumpAndSettle();

    final field = tester.widget<TextFormField>(find.byType(TextFormField));
    expect(field.controller?.text, 'Junta del equipo el lunes');
    expect(shared.resets, greaterThan(0));
  });

  Future<void> openCorrection(WidgetTester tester, FakeCaptureApi api) async {
    await openCapture(tester, api: api);
    await tester.enterText(find.byType(TextFormField), 'Entregar reporte');
    await tapVisible(tester, find.text('Interpretar mensaje'));
    await tapVisible(tester, find.text('Corregir'));
  }

  testWidgets('corregir manda solo el campo que cambió', (tester) async {
    final api = FakeCaptureApi(proposal: proposal);
    await openCorrection(tester, api);

    expect(find.text('Corregir actividad'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Entregar reporte de redes'),
      'Entregar reporte final de redes',
    );
    await tapVisible(tester, find.text('3 · Media'));
    await tapVisible(tester, find.text('5 · Muy alta'));
    await tapVisible(tester, find.text('Guardar corrección'));

    expect(api.corrections, {
      'captura-1': {
        'titulo': 'Entregar reporte final de redes',
        'prioridad': 5,
      },
    });
    expect(api.confirmed, isEmpty);
    expect(find.text('Guardado como actividad.'), findsOneWidget);
  });

  testWidgets('guardar sin cambios confirma la propuesta', (tester) async {
    final api = FakeCaptureApi(proposal: proposal);
    await openCorrection(tester, api);

    await tapVisible(tester, find.text('Guardar corrección'));

    expect(api.corrections, isEmpty);
    expect(api.confirmed, ['captura-1']);
  });

  testWidgets('cancelar la corrección regresa a la tarjeta', (tester) async {
    final api = FakeCaptureApi(proposal: proposal);
    await openCorrection(tester, api);

    await tapVisible(tester, find.text('Cancelar'));

    expect(find.text('Corregir actividad'), findsNothing);
    expect(find.text('Confirmar'), findsOneWidget);
    expect(api.corrections, isEmpty);
  });

  testWidgets('el título no puede quedar vacío al corregir', (tester) async {
    final api = FakeCaptureApi(proposal: proposal);
    await openCorrection(tester, api);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Entregar reporte de redes'),
      '',
    );
    await tapVisible(tester, find.text('Guardar corrección'));

    expect(find.text('Escribe el título de la actividad'), findsOneWidget);
    expect(api.corrections, isEmpty);
    expect(api.confirmed, isEmpty);
  });
}
