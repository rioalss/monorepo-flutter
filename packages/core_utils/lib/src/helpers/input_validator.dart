// ignore_for_file: document_ignores, comment_references

import 'package:core_utils/src/extensions/string_extensions.dart';
import 'package:core_utils/src/helpers/validation_messages.dart';

/// Signature for `TextFormField.validator` and similar APIs.
typedef FieldValidator = String? Function(String? value);

/// Form-field validators returning English error strings from [ValidationMessages].
///
/// Validators skip empty values except [required]. Use [combine] to chain rules
/// and [optional] to apply a rule only when the user entered text.
abstract final class InputValidator {
  InputValidator._();

  static final RegExp _fullNamePattern = RegExp(r"^[\p{L}\s\-'.]+$", unicode: true);
  static final RegExp _usernamePattern = RegExp(r'^[a-zA-Z0-9_]{3,30}$');
  static final RegExp _strictDatePattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  static final RegExp _postalCodePattern = RegExp(r'^[a-zA-Z0-9\- ]{4,10}$');

  // ==================== Composition ====================

  /// Runs [validators] in order; returns the first error.
  static FieldValidator combine(List<FieldValidator> validators) => (value) {
        for (final validator in validators) {
          final error = validator(value);
          if (error != null) return error;
        }
        return null;
      };

  /// Applies [validator] only when [condition] is true.
  static FieldValidator when({
    required bool condition,
    required FieldValidator validator,
  }) =>
      (value) => condition ? validator(value) : null;

  /// Skips [validator] when the field is empty (not for [required]).
  static FieldValidator optional(FieldValidator validator) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        return validator(value);
      };

  // ==================== Core ====================

  /// Fails when the field is empty after optional trim.
  static FieldValidator required({
    String? message,
    bool trim = true,
  }) =>
      (value) {
        final text = trim ? _trimmed(value) : _raw(value);
        if (text.isEmpty) return message ?? ValidationMessages.required;
        return null;
      };

  /// Fails when trimmed length is below [min].
  static FieldValidator minLength(
    int min, {
    String? message,
    bool trim = true,
  }) =>
      (value) {
        final text = trim ? _trimmed(value) : _raw(value);
        if (text.length < min) {
          return message ?? ValidationMessages.minLength(min);
        }
        return null;
      };

  /// Fails when trimmed length exceeds [max].
  static FieldValidator maxLength(
    int max, {
    String? message,
    bool trim = true,
  }) =>
      (value) {
        final text = trim ? _trimmed(value) : _raw(value);
        if (text.length > max) {
          return message ?? ValidationMessages.maxLength(max);
        }
        return null;
      };

  /// Fails when trimmed length is outside [[min], [max]] inclusive.
  static FieldValidator lengthRange(
    int min,
    int max, {
    String? message,
    bool trim = true,
  }) =>
      (value) {
        final text = trim ? _trimmed(value) : _raw(value);
        if (text.length < min || text.length > max) {
          return message ?? ValidationMessages.lengthRange(min, max);
        }
        return null;
      };

  /// Fails when non-empty value does not match [regex].
  static FieldValidator pattern(
    RegExp regex, {
    String? message,
    bool trim = true,
  }) =>
      (value) {
        final text = trim ? _trimmed(value) : _raw(value);
        if (text.isEmpty) return null;
        if (!regex.hasMatch(text)) {
          return message ?? ValidationMessages.pattern;
        }
        return null;
      };

  // ==================== String / text ====================

  /// Validates email format when non-empty.
  static FieldValidator email({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (!text.isValidEmail) return message ?? ValidationMessages.email;
        return null;
      };

  /// Validates http/https URL when non-empty.
  static FieldValidator url({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (!text.isValidUrl) return message ?? ValidationMessages.url;
        return null;
      };

  /// Letters only (a–z, A–Z) when non-empty.
  static FieldValidator alpha({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (!text.isAlpha) return message ?? ValidationMessages.alpha;
        return null;
      };

  /// Letters and digits only when non-empty.
  static FieldValidator alphanumeric({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (!text.isAlphanumeric) {
          return message ?? ValidationMessages.alphanumeric;
        }
        return null;
      };

  /// Digits only when non-empty.
  static FieldValidator numeric({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (!text.isNumeric) return message ?? ValidationMessages.numeric;
        return null;
      };

  /// Fails when any whitespace character is present.
  static FieldValidator noWhitespace({String? message}) => (value) {
        final text = _raw(value);
        if (text.isEmpty) return null;
        if (text.contains(RegExp(r'\s'))) {
          return message ?? ValidationMessages.noWhitespace;
        }
        return null;
      };

  /// Fails when value differs from its trimmed form.
  static FieldValidator noLeadingTrailingWhitespace({String? message}) =>
      (value) {
        final text = _raw(value);
        if (text.isEmpty) return null;
        if (text != text.trim()) {
          return message ?? ValidationMessages.noLeadingTrailingWhitespace;
        }
        return null;
      };

  /// Unicode letters, spaces, hyphens, and apostrophes; minimum [min] length.
  static FieldValidator fullName({
    String? message,
    int min = 2,
  }) =>
      (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (text.length < min) {
          return ValidationMessages.minLength(min);
        }
        if (!_fullNamePattern.hasMatch(text)) {
          return message ?? ValidationMessages.fullName;
        }
        return null;
      };

  /// 3–30 chars: letters, digits, underscore.
  static FieldValidator username({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (!_usernamePattern.hasMatch(text)) {
          return message ?? ValidationMessages.username;
        }
        return null;
      };

  /// Configurable password strength rules when non-empty.
  static FieldValidator password({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireDigit = true,
    bool requireSpecial = false,
    String? message,
  }) =>
      (value) {
        final text = _raw(value);
        if (text.isEmpty) return null;
        if (text.length < minLength) {
          return message ?? ValidationMessages.password;
        }
        if (requireUppercase && !RegExp('[A-Z]').hasMatch(text)) {
          return message ?? ValidationMessages.password;
        }
        if (requireLowercase && !RegExp('[a-z]').hasMatch(text)) {
          return message ?? ValidationMessages.password;
        }
        if (requireDigit && !RegExp('[0-9]').hasMatch(text)) {
          return message ?? ValidationMessages.password;
        }
        if (requireSpecial && !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(text)) {
          return message ?? ValidationMessages.password;
        }
        return null;
      };

  /// Fails when [value] differs from [other] (raw comparison).
  static FieldValidator confirmPassword(
    String? other, {
    String? message,
  }) =>
      (value) {
        if (value != other) {
          return message ?? ValidationMessages.confirmPassword;
        }
        return null;
      };

  /// Exact string match against [expected].
  static FieldValidator match(
    String expected, {
    String? message,
    bool trim = true,
  }) =>
      (value) {
        final text = trim ? _trimmed(value) : _raw(value);
        if (text != expected) return message ?? ValidationMessages.match;
        return null;
      };

  // ==================== Numbers ====================

  /// Whole number when non-empty.
  static FieldValidator integer({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (int.tryParse(text) == null) {
          return message ?? ValidationMessages.integer;
        }
        return null;
      };

  /// Decimal number when non-empty.
  static FieldValidator decimal({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (double.tryParse(text) == null) {
          return message ?? ValidationMessages.decimal;
        }
        return null;
      };

  /// Numeric minimum bound when parseable.
  static FieldValidator minValue(
    num min, {
    String? message,
    bool integerOnly = false,
  }) =>
      (value) {
        final parsed = _parseNumber(value, integerOnly: integerOnly);
        if (parsed == null) return null;
        if (parsed < min) return message ?? ValidationMessages.minValue(min);
        return null;
      };

  /// Numeric maximum bound when parseable.
  static FieldValidator maxValue(
    num max, {
    String? message,
    bool integerOnly = false,
  }) =>
      (value) {
        final parsed = _parseNumber(value, integerOnly: integerOnly);
        if (parsed == null) return null;
        if (parsed > max) return message ?? ValidationMessages.maxValue(max);
        return null;
      };

  /// Numeric inclusive range when parseable.
  static FieldValidator range(
    num min,
    num max, {
    String? message,
    bool integerOnly = false,
  }) =>
      (value) {
        final parsed = _parseNumber(value, integerOnly: integerOnly);
        if (parsed == null) return null;
        if (parsed < min || parsed > max) {
          return message ?? ValidationMessages.range(min, max);
        }
        return null;
      };

  /// Must be greater than zero when parseable.
  static FieldValidator positive({
    String? message,
    bool integerOnly = false,
  }) =>
      (value) {
        final parsed = _parseNumber(value, integerOnly: integerOnly);
        if (parsed == null) return null;
        if (parsed <= 0) return message ?? ValidationMessages.positive;
        return null;
      };

  /// Must be zero or greater when parseable.
  static FieldValidator nonNegative({
    String? message,
    bool integerOnly = false,
  }) =>
      (value) {
        final parsed = _parseNumber(value, integerOnly: integerOnly);
        if (parsed == null) return null;
        if (parsed < 0) return message ?? ValidationMessages.nonNegative;
        return null;
      };

  // ==================== Indonesia ====================

  /// Indonesian mobile format when non-empty.
  static FieldValidator phoneId({String? message}) => (value) {
        final text = _trimmed(value).removeWhitespace;
        if (text.isEmpty) return null;
        if (!text.isValidPhone) return message ?? ValidationMessages.phoneId;
        return null;
      };

  /// Exactly 16 digits (NIK) when non-empty.
  static FieldValidator nik({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (text.length != 16 || !text.isNumeric) {
          return message ?? ValidationMessages.nik;
        }
        return null;
      };

  /// Numeric code of exact [length] when non-empty.
  static FieldValidator otp({
    int length = 6,
    String? message,
  }) =>
      (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (text.length != length || !text.isNumeric) {
          return message ?? ValidationMessages.otp(length);
        }
        return null;
      };

  // ==================== Maps / geo ====================

  /// Latitude in [-90, 90] when parseable.
  static FieldValidator latitude({String? message}) => (value) {
        final parsed = _parseCoordinate(value);
        if (parsed == null) return null;
        if (parsed < -90 || parsed > 90) {
          return message ?? ValidationMessages.latitude;
        }
        return null;
      };

  /// Longitude in [-180, 180] when parseable.
  static FieldValidator longitude({String? message}) => (value) {
        final parsed = _parseCoordinate(value);
        if (parsed == null) return null;
        if (parsed < -180 || parsed > 180) {
          return message ?? ValidationMessages.longitude;
        }
        return null;
      };

  /// `"lat,lng"` pair within valid coordinate bounds.
  static FieldValidator coordinatePair({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        final parts = text.split(',').map((p) => p.trim()).toList();
        if (parts.length != 2) {
          return message ?? ValidationMessages.coordinatePair;
        }
        final lat = double.tryParse(parts[0]);
        final lng = double.tryParse(parts[1]);
        if (lat == null ||
            lng == null ||
            lat < -90 ||
            lat > 90 ||
            lng < -180 ||
            lng > 180) {
          return message ?? ValidationMessages.coordinatePair;
        }
        return null;
      };

  // ==================== Other ====================

  /// Alphanumeric postal code (4–10 chars) when non-empty.
  static FieldValidator postalCode({String? message}) => (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (!_postalCodePattern.hasMatch(text)) {
          return message ?? ValidationMessages.postalCode;
        }
        return null;
      };

  /// Luhn-valid card number (13–19 digits) when non-empty.
  static FieldValidator creditCard({String? message}) => (value) {
        final text = _trimmed(value).replaceAll(RegExp(r'\s|-'), '');
        if (text.isEmpty) return null;
        if (text.length < 13 ||
            text.length > 19 ||
            !text.isNumeric ||
            !_passesLuhn(text)) {
          return message ?? ValidationMessages.creditCard;
        }
        return null;
      };

  /// Parseable date; [strictIso] requires `YYYY-MM-DD`.
  static FieldValidator date({
    String? message,
    bool strictIso = false,
  }) =>
      (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        if (strictIso && !_strictDatePattern.hasMatch(text)) {
          return message ?? ValidationMessages.date;
        }
        if (DateTime.tryParse(text) == null) {
          return message ?? ValidationMessages.date;
        }
        return null;
      };

  /// Minimum age in full years from a parseable birth date.
  static FieldValidator minAge(
    int years, {
    String? message,
  }) =>
      (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        final birthDate = DateTime.tryParse(text);
        if (birthDate == null) return message ?? ValidationMessages.date;
        final today = DateTime.now();
        var age = today.year - birthDate.year;
        if (today.month < birthDate.month ||
            (today.month == birthDate.month && today.day < birthDate.day)) {
          age--;
        }
        if (age < years) return message ?? ValidationMessages.minAge(years);
        return null;
      };

  /// Filename/path must end with one of [allowed] extensions.
  static FieldValidator fileExtension(
    List<String> allowed, {
    String? message,
    bool caseSensitive = false,
  }) =>
      (value) {
        final text = _trimmed(value);
        if (text.isEmpty) return null;
        final normalized = allowed
            .map((e) => e.startsWith('.') ? e.toLowerCase() : '.${e.toLowerCase()}')
            .toList();
        final path = caseSensitive ? text : text.toLowerCase();
        final matches = normalized.any(path.endsWith);
        if (!matches) return message ?? ValidationMessages.fileExtension;
        return null;
      };

  /// Fails when value equals [forbidden].
  static FieldValidator notEqual(
    String forbidden, {
    String? message,
    bool trim = true,
  }) =>
      (value) {
        final text = trim ? _trimmed(value) : _raw(value);
        if (text == forbidden) return message ?? ValidationMessages.notEqual;
        return null;
      };

  /// Fails when value is in [values].
  static FieldValidator blacklist(
    Set<String> values, {
    String? message,
    bool trim = true,
  }) =>
      (value) {
        final text = trim ? _trimmed(value) : _raw(value);
        if (text.isEmpty) return null;
        if (values.contains(text)) return message ?? ValidationMessages.blacklist;
        return null;
      };

  /// Fails when value is not in [values].
  static FieldValidator whitelist(
    Set<String> values, {
    String? message,
    bool trim = true,
  }) =>
      (value) {
        final text = trim ? _trimmed(value) : _raw(value);
        if (text.isEmpty) return null;
        if (!values.contains(text)) return message ?? ValidationMessages.whitelist;
        return null;
      };

  // ==================== Private helpers ====================

  static String _raw(String? value) => value ?? '';

  static String _trimmed(String? value) => _raw(value).trim();

  static double? _parseCoordinate(String? value) {
    final text = _trimmed(value);
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }

  static num? _parseNumber(String? value, {required bool integerOnly}) {
    final text = _trimmed(value);
    if (text.isEmpty) return null;
    if (integerOnly) return int.tryParse(text);
    return double.tryParse(text);
  }

  static bool _passesLuhn(String digits) {
    var sum = 0;
    var alternate = false;
    for (var i = digits.length - 1; i >= 0; i--) {
      var n = int.parse(digits[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }
}
