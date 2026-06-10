/// Authenticated session tokens and user identity from login responses.
///
/// Holds access and refresh tokens plus the authenticated user id.
/// Parsed from JSON with safe converters to tolerate malformed API values.
library;

import 'package:core_domain/src/converters/safe_json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session_model.freezed.dart';
part 'auth_session_model.g.dart';

/// Tokens and user id returned after a successful login.
@freezed
abstract class AuthSessionModel with _$AuthSessionModel {
  /// Creates a session with required tokens and [userId].
  const factory AuthSessionModel({
    @JsonKey(name: 'accessToken') @SafeStringConverter() required String accessToken,
    @JsonKey(name: 'refreshToken') @SafeStringConverter() required String refreshToken,
    @JsonKey(name: 'id') @SafeStringConverter() required String userId,
  }) = _AuthSessionModel;

  /// Deserializes from a JSON map.
  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);
}
