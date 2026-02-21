import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/domain/auth/repositories/auth_repository.dart';
import 'package:maori_health/presentation/auth/bloc/auth_event.dart';
import 'package:maori_health/presentation/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository}) : _authRepository = authRepository, super(const AuthState()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    final result = await _authRepository.getLoggedInUser();

    await result.fold(
      onFailure: (_) async {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      },
      onSuccess: (user) async {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      },
    );
  }

  Future<void> _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final result = await _authRepository.login(email: event.email, password: event.password);

    await result.fold(
      onFailure: (error) async {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: error.errorMessage ?? StringConstants.somethingWentWrong,
          ),
        );
      },
      onSuccess: (response) async {
        emit(state.copyWith(status: AuthStatus.authenticated, user: response.user));
      },
    );
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}
