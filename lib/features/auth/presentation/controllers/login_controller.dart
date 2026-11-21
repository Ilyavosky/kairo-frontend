import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/storage/session_controller.dart';
import 'package:kairo/features/auth/data/auth_api.dart';
import 'package:kairo/features/auth/data/models/login_request.dart';

class LoginController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> submit({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final token = await ref
          .read(authApiProvider)
          .login(LoginRequest(email: email.trim(), password: password));
      await ref
          .read(sessionControllerProvider.notifier)
          .signIn(token.accessToken);
    });
    if (ref.mounted) {
      state = result;
    }
  }
}

final loginControllerProvider = AsyncNotifierProvider<LoginController, void>(
  LoginController.new,
  isAutoDispose: true,
);
