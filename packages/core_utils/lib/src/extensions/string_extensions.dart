import 'dart:io';

/// String transforms, validation helpers, and parsing utilities.
extension StringExtensions on String {
  // ==================== Null/Empty Checks ====================

  /// Check if string is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Check if string is blank (empty or only whitespace)
  bool get isBlank => trim().isEmpty;

  /// Check if string is not blank
  bool get isNotBlank => !isBlank;

  /// Return null if empty
  String? get nullIfEmpty => isEmpty ? null : this;

  /// Return null if blank
  String? get nullIfBlank => isBlank ? null : this;

  // ==================== Case Transformations ====================

  /// Capitalize first letter
  String get capitalized =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';

  /// Capitalize each word
  String get titleCase =>
      split(' ').map((word) => word.isEmpty ? '' : word.capitalized).join(' ');

  /// Convert to camelCase: example 'this_is_a_test' -> 'thisIsATest'
  String get camelCase {
    final words = split(RegExp(r'[_\s-]+'));
    if (words.isEmpty) return '';
    final first = words.first.toLowerCase();
    final rest = words.skip(1).map((w) => w.capitalized);
    return first + rest.join();
  }

  /// Convert to snake_case: example 'thisIsATest' -> 'this_is_a_test'
  String get snakeCase => replaceAllMapped(
        RegExp('[A-Z]'),
        (match) => '_${match.group(0)!.toLowerCase()}',
      ).replaceFirst(RegExp('^_'), '');

  /// Convert to kebab-case: example 'this_is_a_test' -> 'this-is-a-test'
  String get kebabCase => snakeCase.replaceAll('_', '-');

  // ==================== Validation ====================

  /// Check if valid email
  bool get isValidEmail => RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(this);

  /// Check if valid phone number (Indonesian)
  bool get isValidPhone =>
      RegExp(r'^(\+62|62|0)8[1-9][0-9]{6,10}$').hasMatch(this);

  /// Check if valid URL (http/https only). Absolute file paths like /data/... are not URLs.
  bool get isValidUrl {
    final uri = Uri.tryParse(this);
    if (uri == null) return false;
    final scheme = uri.scheme.toLowerCase();
    return (scheme == 'http' || scheme == 'https') && uri.host.isNotEmpty;
  }

  /// Check if valid file path
  bool get isValidFilePath => File(this).existsSync();

  /// Check if contains only digits
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  /// Check if extension image (.jpg, .jpeg, .png) end with .jpg, .jpeg, .png
  bool get isImageExtension =>
      endsWith('.jpg') || endsWith('.jpeg') || endsWith('.png');

  /// Check if extension svg (.svg) end with .svg
  bool get isSvgExtension => endsWith('.svg');

  /// Check if contains only letters
  bool get isAlpha => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Check if alphanumeric
  bool get isAlphanumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  // ==================== Formatting ====================

  /// Mask with asterisks (for sensitive data)
  String get masked {
    if (length <= 4) return '*' * length;
    return '${substring(0, 2)}${'*' * (length - 4)}${substring(length - 2)}';
  }

  /// Format as phone number
  String get formattedPhone {
    final cleaned = replaceAll(RegExp(r'\D'), '');
    if (cleaned.length < 10) return this;
    // Format: +62 812-3456-7890
    if (cleaned.startsWith('62')) {
      final number = cleaned.substring(2);
      return '+62 ${number.substring(0, 3)}-${number.substring(3, 7)}-${number.substring(7)}';
    }
    if (cleaned.startsWith('0')) {
      final number = cleaned.substring(1);
      return '+62 ${number.substring(0, 3)}-${number.substring(3, 7)}-${number.substring(7)}';
    }
    return this;
  }

  /// Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Collapse multiple whitespace to single space
  String get collapseWhitespace => replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Truncate with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  /// Reverse string
  String get reversed => split('').reversed.join();

  // ==================== Extraction ====================

  /// Extract first n characters
  String first(int n) => length >= n ? substring(0, n) : this;

  /// Extract last n characters
  String last(int n) => length >= n ? substring(length - n) : this;

  /// Get initials (first letter of each word)
  String get initials => split(' ')
      .where((word) => word.isNotEmpty)
      .map((word) => word[0].toUpperCase())
      .take(2)
      .join();

  // ==================== Conversion ====================

  /// Parse as int with fallback
  int toIntOrDefault([int defaultValue = 0]) =>
      int.tryParse(this) ?? defaultValue;

  /// Parse as double with fallback
  double toDoubleOrDefault([double defaultValue = 0.0]) =>
      double.tryParse(this) ?? defaultValue;

  /// Convert to DateTime
  DateTime? toDateTime() => DateTime.tryParse(this);

  /// Convert to Uri
  Uri? toUri() => Uri.tryParse(this);
}

/// Nullable [String] empty checks and fallbacks.
extension NullableStringExtensions on String? {
  /// Check if null or empty
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  /// Check if not null and not empty
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Return empty string if null
  String get orEmpty => this ?? '';

  /// Return default value if null or empty
  String orDefault(String defaultValue) => isNullOrEmpty ? defaultValue : this!;
}
