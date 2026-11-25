import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';

import '../../../helpers/fake_categories_api.dart';
import '../../../helpers/fake_time_records_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  const study = ActivityCategory(
    id: 'categoria-estudio',
    name: 'Estudio',
    scope: 'ambas',
    system: true,
  );
  const exercise = ActivityCategory(
    id: 'categoria-ejercicio',
    name: 'Ejercicio',
    scope: 'personal',
    system: true,
  );

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  TimeRecord record(
    String id,
    String categoryId,
    DateTime start,
    Duration length, {
    String origin = 'temporizador',
    String? note,
  }) => TimeRecord(
    id: id,
    categoryId: categoryId,
    start: start,
    end: start.add(length),
    origin: origin,
    note: note,
  );

  Future<FakeTimeRecordsApi> openRecords(
    WidgetTester tester, {
    FakeTimeRecordsApi? api,
  }) async {
    final records = api ?? FakeTimeRecordsApi();
    await pumpSignedInApp(
      tester,
      timeRecordsApi: records,
      categoriesApi: FakeCategoriesApi(categories: [study, exercise]),
    );
    await tester.tap(find.text('Tiempo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Registros'));
    await tester.pumpAndSettle();
    return records;
  }

  testWidgets('sin registros muestra el estado vacío', (tester) async {
    await openRecords(tester);

    expect(find.text('Aún no tienes registros'), findsOneWidget);
  });

  testWidgets('agrupa por día con duración y categoría', (tester) async {
    await openRecords(
      tester,
      api: FakeTimeRecordsApi(
        records: [
          record(
            'r1',
            'categoria-estudio',
            today.add(const Duration(minutes: 1)),
            const Duration(hours: 1, minutes: 30),
            note: 'Capítulo 3',
          ),
          record(
            'r2',
            'categoria-ejercicio',
            today.subtract(const Duration(hours: 5)),
            const Duration(minutes: 45),
            origin: 'manual',
          ),
        ],
      ),
    );

    expect(find.text('Hoy'), findsOneWidget);
    expect(find.text('Ayer'), findsOneWidget);
    expect(find.text('Estudio'), findsOneWidget);
    expect(find.text('Ejercicio'), findsOneWidget);
    expect(find.text('1 h 30 min'), findsNWidgets(2));
    expect(find.text('45 min'), findsNWidgets(2));
    expect(find.textContaining('Capítulo 3'), findsOneWidget);
    expect(find.text('Estudio 1 h 30 min'), findsOneWidget);
    expect(find.text('Ejercicio 45 min'), findsOneWidget);
  });

  testWidgets('edita la categoría y la nota de un registro', (tester) async {
    final api = await openRecords(
      tester,
      api: FakeTimeRecordsApi(
        records: [
          record(
            'r1',
            'categoria-estudio',
            now.subtract(const Duration(hours: 1)),
            const Duration(minutes: 30),
          ),
        ],
      ),
    );

    await tester.tap(find.text('Estudio'));
    await tester.pumpAndSettle();

    expect(find.text('Editar registro'), findsOneWidget);
    expect(find.text('30 min'), findsOneWidget);

    await tester.tap(find.text('Estudio'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ejercicio').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Corrí 5 km');
    await tester.scrollUntilVisible(
      find.text('Guardar cambios'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Guardar cambios'));
    await tester.pumpAndSettle();

    expect(api.updated['r1']?.categoryId, 'categoria-ejercicio');
    expect(api.updated['r1']?.note, 'Corrí 5 km');
    expect(find.text('Editar registro'), findsNothing);
    expect(find.text('Ejercicio'), findsOneWidget);
  });

  testWidgets('si falla la carga muestra el error y reintentar', (
    tester,
  ) async {
    await openRecords(
      tester,
      api: FakeTimeRecordsApi(listError: const NetworkException()),
    );

    expect(find.text(const NetworkException().message), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('el registro manual empieza vacío y pide categoría y horario', (
    tester,
  ) async {
    final api = await openRecords(tester);

    await tester.tap(find.byTooltip('Agregar tiempo manual'));
    await tester.pumpAndSettle();

    expect(find.text('Nuevo registro'), findsOneWidget);
    expect(find.text('Elige la fecha y hora'), findsNWidgets(2));
    expect(find.text('—'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Guardar registro'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Guardar registro'));
    await tester.pumpAndSettle();

    expect(find.text('Elige una categoría'), findsOneWidget);
    expect(find.text('Indica cuándo empezó y cuándo terminó'), findsOneWidget);
    expect(api.created, isEmpty);
  });
}
