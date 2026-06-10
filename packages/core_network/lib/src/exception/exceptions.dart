/// Typed exceptions thrown by `DioClient` and related network utilities.
///
/// These replace raw `DioException` instances so repositories can map failures
/// to domain errors without depending on Dio types.
library;

import 'package:core_network/src/client/parser/dio_error_body_parser.dart';

/// Thrown when the TCP connection cannot be established within the timeout.
class ConnectionTimeoutException implements Exception {
  /// Creates an exception with an optional server or Dio error [message].
  ConnectionTimeoutException(this.message);

  /// Human-readable detail from Dio, or `null` when unavailable.
  final String? message;

  @override
  String toString() => 'Connection timeout: $message';
}

/// Thrown when the request body cannot be sent within the send timeout.
class SendTimeoutException implements Exception {
  /// Creates an exception with an optional server or Dio error [message].
  SendTimeoutException(this.message);

  /// Human-readable detail from Dio, or `null` when unavailable.
  final String? message;

  @override
  String toString() => 'Send timeout: $message';
}

/// Thrown when the server does not respond within the receive timeout.
class ReceiveTimeoutException implements Exception {
  /// Creates an exception with an optional server or Dio error [message].
  ReceiveTimeoutException(this.message);

  /// Human-readable detail from Dio, or `null` when unavailable.
  final String? message;

  @override
  String toString() => 'Receive timeout: $message';
}

/// Thrown when the server returns a non-success HTTP status code.
class BadResponseException implements Exception {
  /// Creates an exception from the HTTP [statusCode] and raw response [data].
  BadResponseException(this.statusCode, this.data);

  /// HTTP status code from the failed response.
  final int statusCode;

  /// Raw response body; may be a [Map], [String], or other dynamic value.
  final dynamic data;

  @override
  String toString() {
    final parsed = DioErrorBodyParser.extractMessage(data);
    return 'Status $statusCode: ${parsed ?? data ?? 'Bad response'}';
  }
}

/// Thrown when a request is cancelled via `CancelToken`.
class RequestCancelledException implements Exception {
  /// Creates an exception with an optional cancellation [message].
  RequestCancelledException(this.message);

  /// Human-readable detail from Dio, or `null` when unavailable.
  final String? message;

  @override
  String toString() => 'Request cancelled: $message';
}

/// Thrown when no internet connection is available before or during a request.
class NoInternetException implements Exception {
  @override
  String toString() => 'No internet connection';
}

/// Thrown for unclassified Dio failures such as bad certificates or unknown errors.
class UnknownApiException implements Exception {
  /// Creates an exception with an optional underlying [message].
  UnknownApiException(this.message);

  /// Human-readable detail from Dio, or `null` when unavailable.
  final String? message;

  @override
  String toString() => 'Unknown API error: $message';
}

/// Thrown when stored credentials are invalid and the session must be cleared.
class UnauthorizedException implements Exception {
  @override
  String toString() => 'Unauthorized - Please login again';
}

/// Thrown for Centrifuge or WebSocket connection failures.
class CentrifugeException implements Exception {
  /// Creates an exception with a display-ready [message].
  CentrifugeException(this.message);

  /// Human-readable error description.
  final String message;

  @override
  String toString() => message;
}
