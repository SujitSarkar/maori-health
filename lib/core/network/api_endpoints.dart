import 'package:maori_health/core/config/env_config.dart';

abstract class ApiEndpoints {
  static const String refreshToken = 'auth/refresh-token';

  static String fullUrl(String path) => '${EnvConfig.baseUrl}$path';
}
