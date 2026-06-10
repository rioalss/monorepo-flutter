/// Maps network-layer exceptions to domain `AppErrorModel` values.
///
/// Use in data sources or repositories to convert low-level exceptions into
/// type-safe `AppFailure` instances without exposing Dio details to the UI.
library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/src/client/parser/dio_error_body_parser.dart';
import 'package:core_network/src/exception/exceptions.dart';

/// Converts caught network exceptions into [AppErrorModel] for the domain layer.
///
/// Unrecognized errors fall back to [Object.toString] while preserving the
/// original value in [AppErrorModel.originalError].
class ExceptionMapper {
  const ExceptionMapper._();

  /// Maps any caught [Object] to an [AppErrorModel].
  ///
  /// Known network exceptions receive user-friendly messages and status codes.
  /// All other values are wrapped with `e.toString()` as the message.
  static AppErrorModel map(Object e) => switch (e) {
        BadResponseException(:final statusCode, :final data) =>
          _mapBadResponse(statusCode, data, e),
        NoInternetException() => AppErrorModel(
            message: 'No internet connection',
            originalError: e,
          ),
        ConnectionTimeoutException(:final message) => AppErrorModel(
            message: message ?? 'Connection timed out',
            originalError: e,
          ),
        ReceiveTimeoutException(:final message) => AppErrorModel(
            message: message ?? 'Response timed out',
            originalError: e,
          ),
        SendTimeoutException(:final message) => AppErrorModel(
            message: message ?? 'Request timed out',
            originalError: e,
          ),
        RequestCancelledException(:final message) => AppErrorModel(
            message: message ?? 'Request cancelled',
            originalError: e,
          ),
        UnauthorizedException() => AppErrorModel(
            message: 'Unauthorized — please log in again',
            statusCode: 401,
            originalError: e,
          ),
        UnknownApiException(:final message) => AppErrorModel(
            message: message ?? 'Unknown network error',
            originalError: e,
          ),
        _ => AppErrorModel(message: e.toString(), originalError: e),
      };

  /// Parses [BadResponseException] bodies into [AppErrorModel].
  ///
  /// Attempts `ApiErrorModel` deserialization first, then falls back to
  /// `DioErrorBodyParser` and finally `data.toString()`.
  static AppErrorModel _mapBadResponse(int statusCode, dynamic data, Object e) {
    if (data is Map<String, dynamic>) {
      final apiError = safeParseModel(() => ApiErrorModel.fromJson(data));
      if (apiError != null) {
        final message = apiError.message ??
            DioErrorBodyParser.extractMessage(data) ??
            'Bad response';
        return AppErrorModel(
          message: message,
          statusCode: apiError.statusCode ?? statusCode,
          originalError: e,
        );
      }
    }

    return AppErrorModel(
      message: DioErrorBodyParser.extractMessage(data) ??
          data?.toString() ??
          'Bad response',
      statusCode: statusCode,
      originalError: e,
    );
  }
}
