import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/telegram/data/link_opener.dart';
import 'package:kairo/features/telegram/data/models/telegram_link.dart';
import 'package:kairo/features/telegram/data/telegram_api.dart';
import 'package:kairo/features/telegram/domain/telegram_bot.dart';

final telegramBotProvider = Provider<String>((ref) => TelegramBot.configured);

final telegramLinkedProvider = FutureProvider<bool>(
  (ref) => ref.watch(telegramApiProvider).isLinked(),
  isAutoDispose: true,
);

class TelegramLinkController extends AsyncNotifier<TelegramLink?> {
  @override
  FutureOr<TelegramLink?> build() => null;

  Future<void> start() async {
    if (state.isLoading) {
      return;
    }
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(telegramApiProvider).createLink(),
    );
    if (!ref.mounted) {
      return;
    }
    state = result;
    await open();
  }

  Future<void> open() async {
    final link = state.value;
    if (link == null) {
      return;
    }
    final uri = TelegramBot.deepLink(ref.read(telegramBotProvider), link.code);
    if (uri != null) {
      await ref.read(linkOpenerProvider).open(uri);
    }
  }
}

final telegramLinkControllerProvider =
    AsyncNotifierProvider<TelegramLinkController, TelegramLink?>(
      TelegramLinkController.new,
      isAutoDispose: true,
    );
