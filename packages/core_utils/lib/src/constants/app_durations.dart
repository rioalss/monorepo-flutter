/// Standardized [Duration] tokens for animations, UX timing, and timeouts.
abstract final class AppDurations {
  AppDurations._();

  static const Duration instant = Duration.zero;

  static const Duration ultraFast = Duration(milliseconds: 50);
  static const Duration veryFast = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 150);

  static const Duration normal = Duration(milliseconds: 200);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration medium = Duration(milliseconds: 400);

  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 600);
  static const Duration extraSlow = Duration(milliseconds: 800);

  static const Duration long = Duration(seconds: 1);
  static const Duration veryLong = Duration(milliseconds: 1500);
  static const Duration extraLong = Duration(seconds: 2);

  // Semantic aliases
  static const Duration microInteraction = fast;
  static const Duration pageTransition = standard;
  static const Duration modal = medium;
  static const Duration splash = Duration(seconds: 2);
  static const Duration tooltipDelay = Duration(milliseconds: 500);
  static const Duration longPress = Duration(milliseconds: 500);
  static const Duration doubleTap = Duration(milliseconds: 300);
  static const Duration snackbar = Duration(seconds: 3);
  static const Duration toast = Duration(seconds: 2);
  static const Duration debounce = Duration(milliseconds: 300);
  static const Duration throttle = Duration(milliseconds: 300);
  static const Duration pulse = Duration(milliseconds: 1800);
  static const Duration shimmer = Duration(milliseconds: 1500);
  static const Duration autoScroll = Duration(seconds: 4);
  static const Duration refresh = Duration(seconds: 1);
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheShort = Duration(minutes: 5);
  static const Duration cacheMedium = Duration(hours: 1);
  static const Duration cacheLong = Duration(days: 1);
  static const Duration sessionTimeout = Duration(hours: 24);
}
