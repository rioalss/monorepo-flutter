import 'package:core_utils/core_utils.dart';

/// Default English error strings for [InputValidator].
///
/// Override per field via the optional `message` parameter on each validator.
abstract final class ValidationMessages {
  ValidationMessages._();

  static const required = 'This field is required';
  static String minLength(int min) => 'Must be at least $min characters';
  static String maxLength(int max) => 'Must be at most $max characters';
  static String lengthRange(int min, int max) =>
      'Must be between $min and $max characters';
  static const pattern = 'Invalid format';
  static const email = 'Enter a valid email address';
  static const url = 'Enter a valid URL';
  static const alpha = 'Only letters are allowed';
  static const alphanumeric = 'Only letters and numbers are allowed';
  static const numeric = 'Only numbers are allowed';
  static const noWhitespace = 'Spaces are not allowed';
  static const noLeadingTrailingWhitespace =
      'Leading or trailing spaces are not allowed';
  static const fullName = 'Enter a valid name';
  static const username = 'Enter a valid username (3–30 characters)';
  static const password = 'Password does not meet requirements';
  static const confirmPassword = 'Passwords do not match';
  static const match = 'Values do not match';
  static const integer = 'Enter a valid whole number';
  static const decimal = 'Enter a valid number';
  static String minValue(num min) => 'Must be at least $min';
  static String maxValue(num max) => 'Must be at most $max';
  static String range(num min, num max) => 'Must be between $min and $max';
  static const positive = 'Must be a positive number';
  static const nonNegative = 'Must be zero or greater';
  static const phoneId = 'Enter a valid Indonesian mobile number';
  static const nik = 'NIK must be exactly 16 digits';
  static String otp(int length) => 'Enter a $length-digit code';
  static const latitude = 'Latitude must be between -90 and 90';
  static const longitude = 'Longitude must be between -180 and 180';
  static const coordinatePair = 'Enter valid coordinates (latitude,longitude)';
  static const postalCode = 'Enter a valid postal code';
  static const creditCard = 'Enter a valid card number';
  static const date = 'Enter a valid date';
  static String minAge(int years) => 'You must be at least $years years old';
  static const fileExtension = 'File type is not allowed';
  static const notEqual = 'This value is not allowed';
  static const blacklist = 'This value is not allowed';
  static const whitelist = 'This value is not allowed';
}
