import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/account/data/account_api.dart';
import 'package:kairo/features/auth/data/models/user_response.dart';

final accountProvider = FutureProvider<UserResponse>(
  (ref) => ref.watch(accountApiProvider).me(),
  isAutoDispose: true,
);
