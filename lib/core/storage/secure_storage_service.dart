import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:maori_health/core/storage/storage_keys.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  Future<String?> getAccessToken() async => await _storage.read(key: StorageKeys.accessToken);

  Future<void> setAccessToken(String token) async => await _storage.write(key: StorageKeys.accessToken, value: token);

  Future<String?> getRefreshToken() async => await _storage.read(key: StorageKeys.refreshToken);

  Future<void> setRefreshToken(String token) async => await _storage.write(key: StorageKeys.refreshToken, value: token);

  Future<void> clearTokens() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
  }

  Future<void> deleteAll() async => await _storage.deleteAll();
}
