abstract class AppError {
  final int? errorCode;
  final String? errorMessage;

  const AppError({this.errorCode, this.errorMessage});

  @override
  String toString() => '$runtimeType(errorCode: $errorCode, errorMessage: $errorMessage)';
}

class ApiError extends AppError {
  final int? statusCode;

  const ApiError({super.errorCode, super.errorMessage, this.statusCode});

  @override
  String toString() => 'ApiError(errorCode: $errorCode, statusCode: $statusCode, errorMessage: $errorMessage)';
}

class NetworkError extends AppError {
  const NetworkError({super.errorCode = 0, super.errorMessage = 'No internet connection. Please check your network.'});
}

class CacheError extends AppError {
  const CacheError({super.errorCode = 0, super.errorMessage});
}

class ApiAuthError extends AppError {
  final String? emailError;
  final String? passwordError;
  const ApiAuthError({super.errorCode, super.errorMessage, this.emailError, this.passwordError});

  @override
  String toString() =>
      'ApiAuthError(errorCode: $errorCode, errorMessage: $errorMessage, emailError: $emailError, passwordError: $passwordError)';
}
