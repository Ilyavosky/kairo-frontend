abstract final class ApiConfig {
  static const v1 = '/api/v1';
  static String get baseUrl => const String.fromEnvironment('API_URL');
  static const connectTimeout = Duration(seconds: 10);
  static const receiveTimeout = Duration(seconds: 20);
}
