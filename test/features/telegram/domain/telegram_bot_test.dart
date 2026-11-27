import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/telegram/domain/telegram_bot.dart';

void main() {
  test('arma el enlace al bot con el código de un solo uso', () {
    expect(
      TelegramBot.deepLink('kairo_prueba_bot', 'ABCD2345').toString(),
      'https://t.me/kairo_prueba_bot?start=ABCD2345',
    );
  });

  test('acepta el usuario con arroba', () {
    expect(
      TelegramBot.deepLink('@kairo_prueba_bot', 'ABCD2345').toString(),
      'https://t.me/kairo_prueba_bot?start=ABCD2345',
    );
  });

  test('sin bot configurado no hay enlace', () {
    expect(TelegramBot.deepLink('', 'ABCD2345'), isNull);
    expect(TelegramBot.deepLink('  ', 'ABCD2345'), isNull);
  });
}
