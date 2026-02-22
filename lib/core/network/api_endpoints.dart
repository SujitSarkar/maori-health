import 'package:maori_health/core/config/env_config.dart';

abstract class ApiEndpoints {
  // Auth
  static const String login = 'auth/login';
  static const String logout = 'auth/logout';
  static const String updatePassword = 'auth/update-password';
  static const String refreshToken = 'auth/refresh-token';

  // Assets
  static const String assets = 'assets';
  static String acceptAsset(int id) => 'assets/$id/accept';

  // Notifications
  static const String notifications = 'notifications';
  static String readNotification(String id) => 'notifications/$id';

  // TimeSheets
  static const String timeSheets = 'schedules/timesheet';
  static const String employees = 'lookups/employees';

  static String fullUrl(String path) => '${EnvConfig.baseUrl}$path';
}
