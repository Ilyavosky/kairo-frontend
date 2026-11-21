import 'package:kairo/features/auth/data/auth_api.dart';
import 'package:kairo/features/auth/data/models/login_request.dart';
import 'package:kairo/features/auth/data/models/register_request.dart';
import 'package:kairo/features/auth/data/models/token_response.dart';
import 'package:kairo/features/auth/data/models/user_response.dart';

class FakeAuthApi implements AuthApi {
  FakeAuthApi({
    this.loginError,
    this.registerError,
    this.token = 'token-nuevo',
  });

  final Exception? loginError;
  final Exception? registerError;
  final String token;
  final List<LoginRequest> loginRequests = [];
  final List<RegisterRequest> registerRequests = [];

  @override
  Future<TokenResponse> login(LoginRequest request) async {
    loginRequests.add(request);
    final error = loginError;
    if (error != null) {
      throw error;
    }
    return TokenResponse(accessToken: token);
  }

  @override
  Future<UserResponse> register(RegisterRequest request) async {
    registerRequests.add(request);
    final error = registerError;
    if (error != null) {
      throw error;
    }
    return UserResponse(
      id: 'usuario-1',
      email: request.email,
      name: request.name,
      timezone: request.timezone,
      registeredAt: DateTime(2026, 11, 20),
      active: true,
    );
  }
}
