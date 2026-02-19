sealed class Result<E, V> {
  const Result();

  bool get isSuccess => this is SuccessResult<E, V>;
  bool get isFailure => this is ErrorResult<E, V>;

  Future<R> fold<R>({
    required Future<R> Function(E error) onFailure,
    required Future<R> Function(V value) onSuccess,
  }) async {
    return switch (this) {
      SuccessResult<E, V>(:final value) => onSuccess(value),
      ErrorResult<E, V>(:final error) => onFailure(error),
    };
  }
}

class SuccessResult<E, V> extends Result<E, V> {
  final V value;
  const SuccessResult(this.value);
}

class ErrorResult<E, V> extends Result<E, V> {
  final E error;
  const ErrorResult(this.error);
}
