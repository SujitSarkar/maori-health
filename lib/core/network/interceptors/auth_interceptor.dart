import 'package:dio/dio.dart';
import 'package:maori_health/core/storage/secure_storage_service.dart';

class AuthInterceptor extends InterceptorsWrapper {
  final SecureStorageService _secureStorage;

  AuthInterceptor({required SecureStorageService secureStorage}) : _secureStorage = secureStorage;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Accept'] = 'application/json';
    return handler.next(options);
  }
}
