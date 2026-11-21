import 'package:kairo/features/auth/data/auth_api.dart';
import 'package:kairo/features/auth/data/models/login_request.dart';
import 'package:kairo/features/auth/data/models/token_response.dart';

class FakeAuthApi implements AuthApi {
  FakeAuthApi({this.loginError, this.token = 'token-nuevo'});

  final Exception? loginError;
  final String token;
  final List<LoginRequest> loginRequests = [];

  @override
  Future<TokenResponse> login(LoginRequest request) async {
    loginRequests.add(request);
    final error = loginError;
    if (error != null) {
      throw error;
    }
    return TokenResponse(accessToken: token);
  }
}
