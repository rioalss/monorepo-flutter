// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonClose => 'Close';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonError => 'Something went wrong';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonSuccess => 'Success';

  @override
  String get commonNoData => 'No data available';

  @override
  String get commonTryAgain => 'Try again';

  @override
  String get validationRequired => 'This field is required';

  @override
  String validationMinLength(int min) {
    return 'Must be at least $min characters';
  }

  @override
  String validationMaxLength(int max) {
    return 'Must be at most $max characters';
  }

  @override
  String validationLengthRange(int min, int max) {
    return 'Must be between $min and $max characters';
  }

  @override
  String get validationPattern => 'Invalid format';

  @override
  String get validationEmail => 'Enter a valid email address';

  @override
  String get validationUrl => 'Enter a valid URL';

  @override
  String get validationAlpha => 'Only letters are allowed';

  @override
  String get validationAlphanumeric => 'Only letters and numbers are allowed';

  @override
  String get validationNumeric => 'Only numbers are allowed';

  @override
  String get validationNoWhitespace => 'Spaces are not allowed';

  @override
  String get validationNoLeadingTrailingWhitespace =>
      'Leading or trailing spaces are not allowed';

  @override
  String get validationFullName => 'Enter a valid name';

  @override
  String get validationUsername => 'Enter a valid username (3–30 characters)';

  @override
  String get validationPassword => 'Password does not meet requirements';

  @override
  String get validationConfirmPassword => 'Passwords do not match';

  @override
  String get validationMatch => 'Values do not match';

  @override
  String get validationInteger => 'Enter a valid whole number';

  @override
  String get validationDecimal => 'Enter a valid number';

  @override
  String validationMinValue(num min) {
    return 'Must be at least $min';
  }

  @override
  String validationMaxValue(num max) {
    return 'Must be at most $max';
  }

  @override
  String validationRange(num min, num max) {
    return 'Must be between $min and $max';
  }

  @override
  String get validationPositive => 'Must be a positive number';

  @override
  String get validationNonNegative => 'Must be zero or greater';

  @override
  String get validationPhoneId => 'Enter a valid Indonesian mobile number';

  @override
  String get validationNik => 'NIK must be exactly 16 digits';

  @override
  String validationOtp(int length) {
    return 'Enter a $length-digit code';
  }

  @override
  String get validationLatitude => 'Latitude must be between -90 and 90';

  @override
  String get validationLongitude => 'Longitude must be between -180 and 180';

  @override
  String get validationCoordinatePair =>
      'Enter valid coordinates (latitude,longitude)';

  @override
  String get validationPostalCode => 'Enter a valid postal code';

  @override
  String get validationCreditCard => 'Enter a valid card number';

  @override
  String get validationDate => 'Enter a valid date';

  @override
  String validationMinAge(int years) {
    return 'You must be at least $years years old';
  }

  @override
  String get validationFileExtension => 'File type is not allowed';

  @override
  String get validationNotEqual => 'This value is not allowed';

  @override
  String get validationBlacklist => 'This value is not allowed';

  @override
  String get validationWhitelist => 'This value is not allowed';

  @override
  String commonThemeTooltip(String mode) {
    return 'Theme: $mode';
  }

  @override
  String commonLocaleTooltip(String language) {
    return 'Language: $language';
  }

  @override
  String get authLoginTitle => 'Login';

  @override
  String get authLoginButton => 'Login';

  @override
  String get authCreateAccount => 'Create account';

  @override
  String get authRegisterTitle => 'Register';

  @override
  String get authRegisterButton => 'Register';

  @override
  String get authUsername => 'Username';

  @override
  String get authPassword => 'Password';

  @override
  String get authFirstName => 'First name';

  @override
  String get authLastName => 'Last name';

  @override
  String get authAge => 'Age';

  @override
  String get authInvalidNumber => 'Invalid number';

  @override
  String authUserCreated(String name) {
    return 'User created: $name';
  }

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get dashboardLogout => 'Logout';

  @override
  String get dashboardLoadingProfile => 'Loading profile...';

  @override
  String dashboardWelcome(String name) {
    return 'Welcome, $name';
  }

  @override
  String get dashboardViewAllUsers => 'View all users';

  @override
  String get dashboardDatePicker => 'Date Picker';

  @override
  String get dashboardDateRangePicker => 'Date Range Picker';

  @override
  String get dashboardPickDate => 'Pick a date';

  @override
  String dashboardSelectedDate(String date) {
    return 'Selected: $date';
  }

  @override
  String dashboardSelectedDateRange(String start, String end) {
    return 'Selected: $start - $end';
  }

  @override
  String dashboardUserId(String id) {
    return 'ID: $id';
  }

  @override
  String dashboardUserEmail(String email) {
    return 'Email: $email';
  }

  @override
  String get usersTitle => 'Users';

  @override
  String get usersEmpty => 'No users found';
}
