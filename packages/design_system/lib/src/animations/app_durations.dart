/// Standard animation durations and stagger delays.
///
/// Base millisecond steps plus semantic aliases for ripples, transitions,
/// loading indicators, and list stagger effects.
library;

/// Named [Duration] constants for consistent timing across the app.
abstract final class AppDurations {
  // Base duration steps (shortest to longest)
  static const Duration instant = Duration.zero;
  static const Duration ultraShort = Duration(milliseconds: 50);
  static const Duration extraShort = Duration(milliseconds: 100);
  static const Duration short = Duration(milliseconds: 150);
  static const Duration mediumShort = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration mediumLong = Duration(milliseconds: 300);
  static const Duration long = Duration(milliseconds: 350);
  static const Duration extraLong = Duration(milliseconds: 400);
  static const Duration ultraLong = Duration(milliseconds: 500);
  static const Duration extended = Duration(milliseconds: 600);
  static const Duration veryExtended = Duration(milliseconds: 700);

  // Semantic aliases for common UI animations
  static const Duration ripple = mediumShort;
  static const Duration buttonPress = extraShort;
  static const Duration toggle = mediumShort;
  static const Duration iconChange = short;
  static const Duration selection = short;
  static const Duration focus = short;
  static const Duration hover = extraShort;
  static const Duration tooltip = short;
  static const Duration snackbar = mediumLong;
  static const Duration cardExpand = mediumLong;
  static const Duration modal = mediumLong;
  static const Duration bottomSheet = mediumLong;
  static const Duration drawer = mediumLong;
  static const Duration pageTransition = mediumLong;
  static const Duration tabSwitch = mediumShort;
  static const Duration listItem = short;
  static const Duration shimmer = Duration(milliseconds: 1500);
  static const Duration spinner = Duration(milliseconds: 1200);
  static const Duration pulse = Duration(milliseconds: 2000);
  static const Duration skeleton = Duration(milliseconds: 1500);
  static const Duration counter = mediumShort;
  static const Duration progress = medium;
  static const Duration splash = Duration(milliseconds: 2000);
  static const Duration celebration = Duration(milliseconds: 1500);
  static const Duration shake = Duration(milliseconds: 500);
  static const Duration bidTick = Duration(seconds: 1);
  static const Duration locationUpdate = Duration(seconds: 5);
  static const Duration typingIndicator = Duration(milliseconds: 800);

  // Delays between staggered child animations
  static const Duration staggerDelay = Duration(milliseconds: 50);
  static const Duration gridStaggerDelay = Duration(milliseconds: 30);
  static const Duration sequenceDelay = Duration(milliseconds: 100);
}
