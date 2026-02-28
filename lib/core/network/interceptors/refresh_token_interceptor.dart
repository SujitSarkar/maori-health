import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:maori_health/core/storage/local_cache_service.dart';

import 'package:maori_health/core/storage/secure_storage_service.dart';

class RefreshTokenInterceptor extends InterceptorsWrapper {
  final SecureStorageService _secureStorage;
  final LocalCacheService _cache;

  RefreshTokenInterceptor({required SecureStorageService secureStorage, required LocalCacheService cache})
    : _secureStorage = secureStorage,
      _cache = cache;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != HttpStatus.unauthorized) {
      return handler.next(err);
    }

    final refreshToken = await _secureStorage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      await _handleLogout();
      return handler.reject(err);
    }

    if (Jwt.isExpired(refreshToken)) {
      await _handleLogout();
      return handler.reject(err);
    }

    return handler.reject(err);
  }

  Future<void> _handleLogout() async {
    await _secureStorage.deleteAll();
    await _cache.clear();
  }
}
