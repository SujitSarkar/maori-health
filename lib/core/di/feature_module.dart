import 'package:get_it/get_it.dart';

import 'package:maori_health/core/storage/local_cache_service.dart';
import 'package:maori_health/presentation/app/bloc/app_bloc.dart';

void registerFeatureModule(GetIt getIt) {
  // ── App
  getIt.registerFactory<AppBloc>(() => AppBloc(cache: getIt<LocalCacheService>()));
}
