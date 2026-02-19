import 'package:get_it/get_it.dart';

import 'package:maori_health/core/storage/secure_storage_service.dart';
import 'package:maori_health/core/storage/local_cache_service.dart';

Future<void> registerServiceModule(GetIt getIt) async {
  final localCache = await LocalCacheService.init();

  getIt
    ..registerLazySingleton<SecureStorageService>(() => SecureStorageService())
    ..registerSingleton<LocalCacheService>(localCache);
}
