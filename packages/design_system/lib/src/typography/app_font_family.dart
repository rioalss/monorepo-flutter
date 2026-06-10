/// Registered font families available to the typography system.
///
/// Values must match entries declared in `pubspec.yaml` under `fonts:`.
library;

/// Supported app font families.
enum AppFontFamily {
  /// DM Sans — default UI typeface.
  dmSans('DMSans');

  /// Creates a family token bound to a Flutter `fontFamily` string.
  const AppFontFamily(this.fontFamily);

  /// Raw font-family value passed to `TextStyle.fontFamily`.
  final String fontFamily;
}

/// Resolves [AppFontFamily] to its Flutter font-family string.
extension AppFontFamilyExtension on AppFontFamily {
  /// Same as [AppFontFamily.fontFamily]; provided for fluent call sites.
  String get name => fontFamily;
}
