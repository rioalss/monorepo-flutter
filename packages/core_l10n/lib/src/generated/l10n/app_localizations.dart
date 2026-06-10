import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// Generic confirmation button label.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// Generic cancel button label.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// Button label to retry a failed action.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// Button label to close a dialog or sheet.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// Button label to save changes.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// Button label to delete an item.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// Generic error message.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonError;

  /// Loading indicator label.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get commonLoading;

  /// Generic success message.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get commonSuccess;

  /// Empty state message when no data is found.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get commonNoData;

  /// Prompt to retry after a failure.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonTryAgain;

  /// Validation error when a required field is empty.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validationRequired;

  /// Validation error when input is shorter than the minimum length.
  ///
  /// In en, this message translates to:
  /// **'Must be at least {min} characters'**
  String validationMinLength(int min);

  /// Validation error when input exceeds the maximum length.
  ///
  /// In en, this message translates to:
  /// **'Must be at most {max} characters'**
  String validationMaxLength(int max);

  /// Validation error when input length is outside the allowed range.
  ///
  /// In en, this message translates to:
  /// **'Must be between {min} and {max} characters'**
  String validationLengthRange(int min, int max);

  /// Validation error when input does not match the expected pattern.
  ///
  /// In en, this message translates to:
  /// **'Invalid format'**
  String get validationPattern;

  /// Validation error for invalid email addresses.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validationEmail;

  /// Validation error for invalid URLs.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid URL'**
  String get validationUrl;

  /// Validation error when input contains non-letter characters.
  ///
  /// In en, this message translates to:
  /// **'Only letters are allowed'**
  String get validationAlpha;

  /// Validation error when input contains special characters.
  ///
  /// In en, this message translates to:
  /// **'Only letters and numbers are allowed'**
  String get validationAlphanumeric;

  /// Validation error when input contains non-numeric characters.
  ///
  /// In en, this message translates to:
  /// **'Only numbers are allowed'**
  String get validationNumeric;

  /// Validation error when input contains whitespace.
  ///
  /// In en, this message translates to:
  /// **'Spaces are not allowed'**
  String get validationNoWhitespace;

  /// Validation error when input has leading or trailing whitespace.
  ///
  /// In en, this message translates to:
  /// **'Leading or trailing spaces are not allowed'**
  String get validationNoLeadingTrailingWhitespace;

  /// Validation error for invalid full names.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid name'**
  String get validationFullName;

  /// Validation error for invalid usernames.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid username (3–30 characters)'**
  String get validationUsername;

  /// Validation error when password does not meet policy.
  ///
  /// In en, this message translates to:
  /// **'Password does not meet requirements'**
  String get validationPassword;

  /// Validation error when password confirmation does not match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationConfirmPassword;

  /// Validation error when two values do not match.
  ///
  /// In en, this message translates to:
  /// **'Values do not match'**
  String get validationMatch;

  /// Validation error for non-integer numeric input.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid whole number'**
  String get validationInteger;

  /// Validation error for invalid decimal numbers.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get validationDecimal;

  /// Validation error when numeric value is below the minimum.
  ///
  /// In en, this message translates to:
  /// **'Must be at least {min}'**
  String validationMinValue(num min);

  /// Validation error when numeric value exceeds the maximum.
  ///
  /// In en, this message translates to:
  /// **'Must be at most {max}'**
  String validationMaxValue(num max);

  /// Validation error when numeric value is outside the allowed range.
  ///
  /// In en, this message translates to:
  /// **'Must be between {min} and {max}'**
  String validationRange(num min, num max);

  /// Validation error when number is not positive.
  ///
  /// In en, this message translates to:
  /// **'Must be a positive number'**
  String get validationPositive;

  /// Validation error when number is negative.
  ///
  /// In en, this message translates to:
  /// **'Must be zero or greater'**
  String get validationNonNegative;

  /// Validation error for invalid Indonesian phone numbers.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Indonesian mobile number'**
  String get validationPhoneId;

  /// Validation error for invalid Indonesian NIK.
  ///
  /// In en, this message translates to:
  /// **'NIK must be exactly 16 digits'**
  String get validationNik;

  /// Validation error for invalid OTP codes.
  ///
  /// In en, this message translates to:
  /// **'Enter a {length}-digit code'**
  String validationOtp(int length);

  /// Validation error for invalid latitude values.
  ///
  /// In en, this message translates to:
  /// **'Latitude must be between -90 and 90'**
  String get validationLatitude;

  /// Validation error for invalid longitude values.
  ///
  /// In en, this message translates to:
  /// **'Longitude must be between -180 and 180'**
  String get validationLongitude;

  /// Validation error for invalid coordinate pairs.
  ///
  /// In en, this message translates to:
  /// **'Enter valid coordinates (latitude,longitude)'**
  String get validationCoordinatePair;

  /// Validation error for invalid postal codes.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid postal code'**
  String get validationPostalCode;

  /// Validation error for invalid credit card numbers.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid card number'**
  String get validationCreditCard;

  /// Validation error for invalid dates.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid date'**
  String get validationDate;

  /// Validation error when age is below the minimum.
  ///
  /// In en, this message translates to:
  /// **'You must be at least {years} years old'**
  String validationMinAge(int years);

  /// Validation error for disallowed file extensions.
  ///
  /// In en, this message translates to:
  /// **'File type is not allowed'**
  String get validationFileExtension;

  /// Validation error when value matches a forbidden value.
  ///
  /// In en, this message translates to:
  /// **'This value is not allowed'**
  String get validationNotEqual;

  /// Validation error when value is in a blacklist.
  ///
  /// In en, this message translates to:
  /// **'This value is not allowed'**
  String get validationBlacklist;

  /// Validation error when value is not in a whitelist.
  ///
  /// In en, this message translates to:
  /// **'This value is not allowed'**
  String get validationWhitelist;

  /// Tooltip for the theme cycle button.
  ///
  /// In en, this message translates to:
  /// **'Theme: {mode}'**
  String commonThemeTooltip(String mode);

  /// Tooltip for the locale cycle button.
  ///
  /// In en, this message translates to:
  /// **'Language: {language}'**
  String commonLocaleTooltip(String language);

  /// Login screen title.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLoginTitle;

  /// Login submit button label.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLoginButton;

  /// Link to the registration screen.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateAccount;

  /// Registration screen title.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authRegisterTitle;

  /// Registration submit button label.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authRegisterButton;

  /// Username field label.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get authUsername;

  /// Password field label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// First name field label.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get authFirstName;

  /// Last name field label.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get authLastName;

  /// Age field label.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get authAge;

  /// Validation error for non-numeric age input.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get authInvalidNumber;

  /// Snack bar after successful registration.
  ///
  /// In en, this message translates to:
  /// **'User created: {name}'**
  String authUserCreated(String name);

  /// Dashboard screen title.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// Logout button tooltip.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get dashboardLogout;

  /// Loading state while fetching user profile.
  ///
  /// In en, this message translates to:
  /// **'Loading profile...'**
  String get dashboardLoadingProfile;

  /// Greeting with the user's display name.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String dashboardWelcome(String name);

  /// Button to open the users list.
  ///
  /// In en, this message translates to:
  /// **'View all users'**
  String get dashboardViewAllUsers;

  /// Button to open single date picker.
  ///
  /// In en, this message translates to:
  /// **'Date Picker'**
  String get dashboardDatePicker;

  /// Button to open date range picker.
  ///
  /// In en, this message translates to:
  /// **'Date Range Picker'**
  String get dashboardDateRangePicker;

  /// Date picker dialog title.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get dashboardPickDate;

  /// Snack bar after selecting a single date.
  ///
  /// In en, this message translates to:
  /// **'Selected: {date}'**
  String dashboardSelectedDate(String date);

  /// Snack bar after selecting a date range.
  ///
  /// In en, this message translates to:
  /// **'Selected: {start} - {end}'**
  String dashboardSelectedDateRange(String start, String end);

  /// User ID label on dashboard.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String dashboardUserId(String id);

  /// User email label on dashboard.
  ///
  /// In en, this message translates to:
  /// **'Email: {email}'**
  String dashboardUserEmail(String email);

  /// Users list screen title.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usersTitle;

  /// Empty state when the users list is empty.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get usersEmpty;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
