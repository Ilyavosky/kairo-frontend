import 'package:kairo/features/account/data/account_api.dart';
import 'package:kairo/features/auth/data/models/user_response.dart';

class FakeAccountApi implements AccountApi {
  FakeAccountApi({this.user, this.error});

  final UserResponse? user;
  final Exception? error;

  @override
  Future<UserResponse> me() async {
    final failure = error;
    if (failure != null) {
      throw failure;
    }
    return user ??
        UserResponse(
          id: 'usuario-1',
          email: 'aurora@ejemplo.com',
          name: 'Aurora',
          timezone: 'America/Mexico_City',
          registeredAt: DateTime(2026, 9),
          active: true,
        );
  }
}
