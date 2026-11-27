abstract final class TelegramBot {
  static const configured = String.fromEnvironment('TELEGRAM_BOT');

  static Uri? deepLink(String bot, String code) {
    final username = bot.trim().replaceFirst('@', '');
    if (username.isEmpty) {
      return null;
    }
    return Uri.https('t.me', '/$username', {'start': code});
  }
}
