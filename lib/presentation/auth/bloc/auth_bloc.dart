import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/domain/auth/repositories/auth_repository.dart';

import 'package:maori_health/presentation/auth/bloc/auth_event.dart';
import 'package:maori_health/presentation/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthLoadingState()) {
    on<AuthLocalLoginEvent>(_onLocalLoginEvent);
    on<AuthLoginEvent>(_onLoginEvent);
    on<AuthLogoutEvent>(_onLogoutEvent);
    on<AuthChangePasswordEvent>(_onChangePassword);
  }

  Future<void> _onLocalLoginEvent(AuthLocalLoginEvent event, Emitter<AuthState> emit) async {
    final result = await _authRepository.getLoggedInUser();
    await result.fold(
      onFailure: (_) async => emit(const UnAuthenticatedState()),
      onSuccess: (user) async => emit(AuthenticatedState(user: user)),
    );
  }

  Future<void> _onLoginEvent(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoadingState());

    final result = await _authRepository.login(email: event.email, password: event.password);
    await result.fold(
      onFailure: (error) async {
        emit(AuthErrorState(error.errorMessage ?? StringConstants.somethingWentWrong));
      },
      onSuccess: (response) async {
        emit(AuthenticatedState(user: response.user));
      },
    );
  }

  Future<void> _onChangePassword(AuthChangePasswordEvent event, Emitter<AuthState> emit) async {
    final currentUser = state.user;
    if (currentUser == null) return;

    emit(UpdatePassLoadingState());

    final result = await _authRepository.updatePassword(
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    );

    await result.fold(
      onFailure: (error) async {
        emit(AuthErrorState(error.errorMessage ?? StringConstants.somethingWentWrong, user: currentUser));
      },
      onSuccess: (message) async {
        emit(ChangePassSuccessState(user: currentUser, message: message));
        await Future.delayed(const Duration(milliseconds: 100));
        emit(AuthenticatedState(user: currentUser));
      },
    );
  }

  Future<void> _onLogoutEvent(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    final currentUser = state.user;
    emit(const AuthLoadingState());

    final success = await _authRepository.logout();
    if (success) {
      emit(const UnAuthenticatedState());
    } else if (currentUser != null) {
      emit(AuthenticatedState(user: currentUser));
    } else {
      emit(const UnAuthenticatedState());
    }
  }
}
