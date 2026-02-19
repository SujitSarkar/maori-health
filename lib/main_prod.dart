import 'package:maori_health/core/config/env_config.dart';
import 'package:maori_health/main_common.dart';

void main() {
  EnvConfig.init(Env.prod);
  mainCommon();
}
