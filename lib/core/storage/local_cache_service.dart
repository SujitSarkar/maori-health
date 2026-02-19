import 'package:shared_preferences/shared_preferences.dart';

import 'package:maori_health/core/storage/storage_keys.dart';

class LocalCacheService {
  final SharedPreferences _preference;

  LocalCacheService(this._preference);

  static Future<LocalCacheService> init() async {
    final preference = await SharedPreferences.getInstance();
    return LocalCacheService(preference);
  }

  String? getThemeMode() => _preference.getString(StorageKeys.themeMode);
  Future<bool> setThemeMode(String mode) => _preference.setString(StorageKeys.themeMode, mode);

  Future<bool> remove(String key) => _preference.remove(key);
  Future<bool> clear() => _preference.clear();
}
