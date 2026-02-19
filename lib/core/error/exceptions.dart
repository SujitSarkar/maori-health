class ApiException implements Exception {
  final int? statusCode;
  final String? message;

  const ApiException({this.statusCode, this.message});

  @override
  String toString() => 'ApiException(statusCode: $statusCode, message: $message)';
}

class CacheException implements Exception {
  final String? message;

  const CacheException({this.message});

  @override
  String toString() => 'CacheException(message: $message)';
}
