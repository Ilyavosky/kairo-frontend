import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/storage/session_controller.dart';
import 'package:kairo/features/auth/data/auth_api.dart';
import 'package:kairo/features/auth/data/models/login_request.dart';
import 'package:kairo/features/auth/data/models/register_request.dart';

class RegisterController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> submit({
    required String name,
    required String email,
    required String password,
    required String timezone,
  }) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final api = ref.read(authApiProvider);
      final cleanEmail = email.trim();
      await api.register(
        RegisterRequest(
          name: name.trim(),
          email: cleanEmail,
          password: password,
          timezone: timezone,
        ),
      );
      final token = await api.login(
        LoginRequest(email: cleanEmail, password: password),
      );
      await ref
          .read(sessionControllerProvider.notifier)
          .signIn(token.accessToken);
    });
    if (ref.mounted) {
      state = result;
    }
  }
}

final registerControllerProvider =
    AsyncNotifierProvider<RegisterController, void>(
      RegisterController.new,
      isAutoDispose: true,
    );
