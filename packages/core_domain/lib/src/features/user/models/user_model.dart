/// User domain model for profile and identity data.
///
/// Immutable Freezed model with safe JSON parsing. Used across auth,
/// user repositories, and presentation layers.
library;

import 'package:core_domain/src/converters/safe_json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Represents an application user with identity and contact fields.
@freezed
abstract class UserModel with _$UserModel {
  /// Creates a user with required [id] and optional profile fields.
  const factory UserModel({
    @SafeStringConverter() required String id,
    @JsonKey(name: 'firstName') @SafeStringConverter() @Default('') String firstName,
    @JsonKey(name: 'lastName') @SafeStringConverter() @Default('') String lastName,
    @SafeNullableStringConverter() String? email,
  }) = _UserModel;

  const UserModel._();

  /// Deserializes from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Display name derived from first and last name, falling back to [email] or [id].
  ///
  /// Returns [email] or [id] when both name parts are empty after trimming.
  String get displayName {
    final name = '$firstName $lastName'.trim();
    return name.isEmpty ? (email ?? id) : name;
  }
}
