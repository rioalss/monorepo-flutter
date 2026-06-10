/// Localized validation messages for form validators.
library;

import 'package:core_l10n/src/generated/l10n/app_localizations.dart';

/// Facade over [AppLocalizations] validation getters for form validators.
///
/// Use when migrating from hardcoded English validation strings to localized
/// messages.
abstract final class ValidationL10n {
  ValidationL10n._();

  static String required(AppLocalizations l10n) => l10n.validationRequired;

  static String minLength(AppLocalizations l10n, int min) =>
      l10n.validationMinLength(min);

  static String maxLength(AppLocalizations l10n, int max) =>
      l10n.validationMaxLength(max);

  static String lengthRange(AppLocalizations l10n, int min, int max) =>
      l10n.validationLengthRange(min, max);

  static String pattern(AppLocalizations l10n) => l10n.validationPattern;

  static String email(AppLocalizations l10n) => l10n.validationEmail;

  static String url(AppLocalizations l10n) => l10n.validationUrl;

  static String alpha(AppLocalizations l10n) => l10n.validationAlpha;

  static String alphanumeric(AppLocalizations l10n) =>
      l10n.validationAlphanumeric;

  static String numeric(AppLocalizations l10n) => l10n.validationNumeric;

  static String noWhitespace(AppLocalizations l10n) =>
      l10n.validationNoWhitespace;

  static String noLeadingTrailingWhitespace(AppLocalizations l10n) =>
      l10n.validationNoLeadingTrailingWhitespace;

  static String fullName(AppLocalizations l10n) => l10n.validationFullName;

  static String username(AppLocalizations l10n) => l10n.validationUsername;

  static String password(AppLocalizations l10n) => l10n.validationPassword;

  static String confirmPassword(AppLocalizations l10n) =>
      l10n.validationConfirmPassword;

  static String match(AppLocalizations l10n) => l10n.validationMatch;

  static String integer(AppLocalizations l10n) => l10n.validationInteger;

  static String decimal(AppLocalizations l10n) => l10n.validationDecimal;

  static String minValue(AppLocalizations l10n, num min) =>
      l10n.validationMinValue(min);

  static String maxValue(AppLocalizations l10n, num max) =>
      l10n.validationMaxValue(max);

  static String range(AppLocalizations l10n, num min, num max) =>
      l10n.validationRange(min, max);

  static String positive(AppLocalizations l10n) => l10n.validationPositive;

  static String nonNegative(AppLocalizations l10n) =>
      l10n.validationNonNegative;

  static String phoneId(AppLocalizations l10n) => l10n.validationPhoneId;

  static String nik(AppLocalizations l10n) => l10n.validationNik;

  static String otp(AppLocalizations l10n, int length) =>
      l10n.validationOtp(length);

  static String latitude(AppLocalizations l10n) => l10n.validationLatitude;

  static String longitude(AppLocalizations l10n) => l10n.validationLongitude;

  static String coordinatePair(AppLocalizations l10n) =>
      l10n.validationCoordinatePair;

  static String postalCode(AppLocalizations l10n) => l10n.validationPostalCode;

  static String creditCard(AppLocalizations l10n) => l10n.validationCreditCard;

  static String date(AppLocalizations l10n) => l10n.validationDate;

  static String minAge(AppLocalizations l10n, int years) =>
      l10n.validationMinAge(years);

  static String fileExtension(AppLocalizations l10n) =>
      l10n.validationFileExtension;

  static String notEqual(AppLocalizations l10n) => l10n.validationNotEqual;

  static String blacklist(AppLocalizations l10n) => l10n.validationBlacklist;

  static String whitelist(AppLocalizations l10n) => l10n.validationWhitelist;
}
