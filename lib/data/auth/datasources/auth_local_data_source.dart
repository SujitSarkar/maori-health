import 'package:jwt_decode/jwt_decode.dart';

import 'package:maori_health/core/storage/local_cache_service.dart';
import 'package:maori_health/core/storage/secure_storage_service.dart';
import 'package:maori_health/data/auth/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String token);
  Future<bool> isTokenValid();
  UserModel? getCachedUser();
  Future<void> cacheUser(UserModel user);
  Future<void> clearAll();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService _secureStorage;
  final LocalCacheService _cache;

  AuthLocalDataSourceImpl({required SecureStorageService secureStorage, required LocalCacheService cache})
    : _secureStorage = secureStorage,
      _cache = cache;

  @override
  Future<String?> getAccessToken() async => await _secureStorage.getAccessToken();

  @override
  Future<void> saveAccessToken(String token) async => await _secureStorage.setAccessToken(token);

  @override
  Future<bool> isTokenValid() async {
    final token = await _secureStorage.getAccessToken();
    if (token == null || token.isEmpty) return false;

    try {
      return !Jwt.isExpired(token);
    } catch (_) {
      // Non-JWT token (e.g. Laravel Sanctum) — treat as valid if present
      return true;
    }
  }

  @override
  UserModel? getCachedUser() => _cache.getUserData();

  @override
  Future<void> cacheUser(UserModel user) => _cache.setUserData(user);

  @override
  Future<void> clearAll() async {
    await _secureStorage.clearTokens();
    await _cache.removeUserData();
  }
}
