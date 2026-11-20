import 'package:kairo/core/storage/token_storage.dart';

class MemoryTokenStorage implements TokenStorage {
  MemoryTokenStorage([this.token]);

  String? token;

  @override
  Future<String?> readAccessToken() async => token;

  @override
  Future<void> saveAccessToken(String value) async {
    token = value;
  }

  @override
  Future<void> deleteAccessToken() async {
    token = null;
  }
}
