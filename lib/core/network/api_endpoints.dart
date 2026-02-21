import 'package:maori_health/core/config/env_config.dart';

abstract class ApiEndpoints {
  static const String login = 'auth/login';
  static const String refreshToken = 'auth/refresh-token';
  static const String assets = 'assets';
  static String acceptAsset(int id) => 'assets/$id/accept';
  static const String notifications = 'notifications';
  static String markNotificationRead(int id) => 'notifications/$id/read';

  static String fullUrl(String path) => '${EnvConfig.baseUrl}$path';
}
