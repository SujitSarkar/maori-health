import 'package:get_it/get_it.dart';

import 'package:maori_health/core/di/network_module.dart';
import 'package:maori_health/core/di/service_module.dart';
import 'package:maori_health/core/di/feature_module.dart';

final GetIt getIt = GetIt.instance;

/// Registration order:
/// 1. Services — storage (no dependencies).
/// 2. Network — Dio client, network checker (depends on storage).
/// 3. Features — blocs (depends on network + storage).
Future<void> registerDependencies() async {
  await registerServiceModule(getIt);
  registerNetworkModule(getIt);
  registerFeatureModule(getIt);
}
