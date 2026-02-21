import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:maori_health/core/storage/storage_keys.dart';
import 'package:maori_health/data/auth/models/user_model.dart';

class LocalCacheService {
  final SharedPreferences _preference;

  LocalCacheService(this._preference);

  static Future<LocalCacheService> init() async {
    final preference = await SharedPreferences.getInstance();
    return LocalCacheService(preference);
  }

  String? getThemeMode() => _preference.getString(StorageKeys.themeMode);
  Future<bool> setThemeMode(String mode) async => await _preference.setString(StorageKeys.themeMode, mode);

  UserModel? getUserData() {
    final raw = _preference.getString(StorageKeys.userData);
    if (raw == null) return null;
    return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<bool> setUserData(UserModel user) async {
    return await _preference.setString(StorageKeys.userData, jsonEncode(user.toJson()));
  }

  Future<bool> removeUserData() async => await _preference.remove(StorageKeys.userData);

  Future<bool> remove(String key) async => await _preference.remove(key);
  Future<bool> clear() async => await _preference.clear();
}
