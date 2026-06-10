/// Domain-level result and error types for repository operations.
///
/// Repositories return [AppResult] instead of throwing, keeping error handling
/// explicit and UI-agnostic. Use [AppResultX] helpers to branch on outcomes.
library;

/// Domain-level error, not tied to any UI state.
class AppErrorModel {
  /// Creates an error with a human-readable [message].
  ///
  /// [statusCode] and [originalError] preserve HTTP and underlying cause when available.
  const AppErrorModel({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  /// User- or developer-facing error description.
  final String message;

  /// HTTP status code when the failure originated from a network call.
  final int? statusCode;

  /// Underlying exception or error object for debugging.
  final Object? originalError;

  @override
  String toString() => 'AppErrorModel($statusCode: $message)';
}

/// Repository return type — use this instead of throwing exceptions.
sealed class AppResult<T> {
  /// Base type for success and failure outcomes.
  const AppResult();
}

/// Successful repository outcome carrying [data].
final class AppSuccess<T> extends AppResult<T> {
  /// Wraps the successful result value.
  const AppSuccess(this.data);

  /// The value produced by the repository operation.
  final T data;
}

/// Failed repository outcome carrying an [AppErrorModel].
final class AppFailure<T> extends AppResult<T> {
  /// Wraps the error details for the failed operation.
  const AppFailure(this.error);

  /// Structured error information for callers and UI mappers.
  final AppErrorModel error;
}

/// Convenience accessors and pattern matching for [AppResult].
extension AppResultX<T> on AppResult<T> {
  /// Whether this result is [AppSuccess].
  bool get isSuccess => this is AppSuccess<T>;

  /// Whether this result is [AppFailure].
  bool get isFailure => this is AppFailure<T>;

  /// Success payload or null when this is a failure.
  T? get dataOrNull => switch (this) {
        AppSuccess<T>(:final data) => data,
        AppFailure<T>() => null,
      };

  /// Failure details or null when this is a success.
  AppErrorModel? get errorOrNull => switch (this) {
        AppFailure<T>(:final error) => error,
        AppSuccess<T>() => null,
      };

  /// Executes [success] or [failure] based on the result variant.
  R when<R>({
    required R Function(T data) success,
    required R Function(AppErrorModel error) failure,
  }) =>
      switch (this) {
        AppSuccess<T>(:final data) => success(data),
        AppFailure<T>(:final error) => failure(error),
      };
}
