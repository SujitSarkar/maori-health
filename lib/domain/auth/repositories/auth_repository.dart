import 'package:maori_health/core/error/failures.dart';
import 'package:maori_health/core/result/result.dart';
import 'package:maori_health/domain/auth/entities/login_response.dart';
import 'package:maori_health/domain/auth/entities/user.dart';

abstract class AuthRepository {
  Future<Result<AppError, LoginResponse>> login({required String email, required String password});

  Future<Result<AppError, User>> getLoggedInUser();

  Future<void> logout();
}
