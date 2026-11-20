import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/storage/token_storage.dart';

class SessionController extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final token = await ref.read(tokenStorageProvider).readAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> signIn(String accessToken) async {
    await ref.read(tokenStorageProvider).saveAccessToken(accessToken);
    state = const AsyncData(true);
  }

  Future<void> signOut() async {
    await ref.read(tokenStorageProvider).deleteAccessToken();
    state = const AsyncData(false);
  }
}

final sessionControllerProvider =
    AsyncNotifierProvider<SessionController, bool>(SessionController.new);
