import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/storage/local_cache_service.dart';
import 'package:maori_health/presentation/app/bloc/app_event.dart';
import 'package:maori_health/presentation/app/bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final LocalCacheService _cache;

  AppBloc({required LocalCacheService cache}) : _cache = cache, super(const AppState()) {
    on<AppStarted>(_onAppStarted);
    on<ThemeModeChanged>(_onThemeModeChanged);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    final savedTheme = _cache.getThemeMode();
    emit(state.copyWith(themeMode: _parseThemeMode(savedTheme)));
  }

  Future<void> _onThemeModeChanged(ThemeModeChanged event, Emitter<AppState> emit) async {
    await _cache.setThemeMode(event.themeMode.name);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  ThemeMode _parseThemeMode(String? value) {
    return ThemeMode.values.firstWhere((mode) => mode.name == value, orElse: () => ThemeMode.light);
  }
}
