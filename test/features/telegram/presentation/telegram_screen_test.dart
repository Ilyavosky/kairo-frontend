import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';

import '../../../helpers/fake_link_opener.dart';
import '../../../helpers/fake_telegram_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  Future<void> openTelegram(
    WidgetTester tester,
    FakeTelegramApi api, {
    FakeLinkOpener? opener,
    String bot = '',
  }) async {
    await pumpSignedInApp(
      tester,
      telegramApi: api,
      linkOpener: opener,
      telegramBot: bot,
    );
    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Telegram'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Telegram'));
    await tester.pumpAndSettle();
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('sin vincular explica qué recibe el bot', (tester) async {
    await openTelegram(tester, FakeTelegramApi());

    expect(find.text('Sin vincular'), findsOneWidget);
    expect(find.text('Vincular Telegram'), findsOneWidget);
    expect(find.text('Qué recibe el bot'), findsOneWidget);
    expect(
      find.text('El bot no ve tu contraseña ni tus otros chats.'),
      findsOneWidget,
    );
  });

  testWidgets('vincular abre el bot con el código de un solo uso', (
    tester,
  ) async {
    final api = FakeTelegramApi();
    final opener = FakeLinkOpener();
    await openTelegram(tester, api, opener: opener, bot: 'kairo_prueba_bot');

    await tapVisible(tester, find.text('Vincular Telegram'));

    expect(
      opener.opened.single.toString(),
      'https://t.me/kairo_prueba_bot?start=ABCD2341',
    );
    expect(find.text('/vincular ABCD2341'), findsOneWidget);
    expect(find.text('Abrir Telegram'), findsOneWidget);
  });

  testWidgets('el estado se actualiza al volver de Telegram', (tester) async {
    final api = FakeTelegramApi();
    await openTelegram(
      tester,
      api,
      opener: FakeLinkOpener(),
      bot: 'kairo_prueba_bot',
    );

    await tapVisible(tester, find.text('Vincular Telegram'));
    api.linked = true;
    [
      AppLifecycleState.inactive,
      AppLifecycleState.hidden,
      AppLifecycleState.paused,
      AppLifecycleState.hidden,
      AppLifecycleState.inactive,
      AppLifecycleState.resumed,
    ].forEach(tester.binding.handleAppLifecycleStateChanged);
    await tester.pumpAndSettle();

    expect(find.text('Vinculado'), findsOneWidget);
    expect(find.text('Vincular Telegram'), findsNothing);
    expect(find.text('/vincular ABCD2341'), findsNothing);
  });

  testWidgets('sin bot configurado muestra el comando para enviarlo', (
    tester,
  ) async {
    final opener = FakeLinkOpener();
    await openTelegram(tester, FakeTelegramApi(), opener: opener);

    await tapVisible(tester, find.text('Vincular Telegram'));

    expect(opener.opened, isEmpty);
    expect(find.text('/vincular ABCD2341'), findsOneWidget);
    expect(find.text('Copiar mensaje'), findsOneWidget);
    expect(find.text('Abrir Telegram'), findsNothing);
  });

  testWidgets('ya vinculado no ofrece volver a vincular', (tester) async {
    await openTelegram(tester, FakeTelegramApi(linked: true));

    expect(find.text('Vinculado'), findsOneWidget);
    expect(find.text('Vincular Telegram'), findsNothing);
  });

  testWidgets('si falla el código muestra el error', (tester) async {
    await openTelegram(
      tester,
      FakeTelegramApi(linkError: const NetworkException()),
    );

    await tapVisible(tester, find.text('Vincular Telegram'));

    expect(find.text(const NetworkException().message), findsOneWidget);
  });

  testWidgets('si falla la carga deja reintentar', (tester) async {
    await openTelegram(
      tester,
      FakeTelegramApi(statusError: const NetworkException()),
    );

    expect(find.text('Reintentar'), findsOneWidget);
  });
}
