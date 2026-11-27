import 'package:kairo/features/telegram/data/models/telegram_link.dart';
import 'package:kairo/features/telegram/data/telegram_api.dart';

class FakeTelegramApi implements TelegramApi {
  FakeTelegramApi({this.linked = false, this.statusError, this.linkError});

  bool linked;
  final Exception? statusError;
  final Exception? linkError;
  var statusCalls = 0;
  var linksCreated = 0;

  @override
  Future<bool> isLinked() async {
    statusCalls++;
    final error = statusError;
    if (error != null) {
      throw error;
    }
    return linked;
  }

  @override
  Future<TelegramLink> createLink() async {
    final error = linkError;
    if (error != null) {
      throw error;
    }
    linksCreated++;
    return TelegramLink(
      code: 'ABCD234$linksCreated',
      command: '/vincular ABCD234$linksCreated',
      expiresAt: DateTime.now().add(const Duration(minutes: 10)),
    );
  }
}
