/// Shared repository helper for mapping service responses to [AppResult].
///
/// Centralizes try/catch and empty-response handling so feature repositories
/// stay focused on domain mapping.

library;

import 'package:core_domain/core_domain.dart';
import 'package:core_network/core_network.dart';

/// Provides a single [execute] helper that converts a [ApiResponseModel]
/// result from a Service call into a typed [AppResult], mapping any thrown
/// exception through [ExceptionMapper].
abstract class BaseRepository {
  /// Runs [action], returning [AppSuccess] when data is present.
  ///
  /// Returns [AppFailure] when the response body is empty or [action] throws.
  Future<AppResult<T>> execute<T>(
    Future<ApiResponseModel<T>> Function() action,
  ) async {
    try {
      final response = await action();
      final data = response.data;
      if (data != null) return AppSuccess(data);
      return AppFailure(
        AppErrorModel(message: response.message ?? 'Empty response'),
      );
    } on Object catch (e) {
      return AppFailure(ExceptionMapper.map(e));
    }
  }
}
