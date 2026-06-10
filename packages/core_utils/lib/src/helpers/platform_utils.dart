import 'dart:io';

import 'package:flutter/foundation.dart';

/// Platform, build-mode, and environment helpers safe to use from Flutter UI code.
///
/// All `dart:io` access is guarded with [kIsWeb] checks.
abstract final class PlatformUtils {
  PlatformUtils._();

  // --- Platform detection ---

  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;
  static bool get isWindows => !kIsWeb && Platform.isWindows;
  static bool get isLinux => !kIsWeb && Platform.isLinux;
  static bool get isWeb => kIsWeb;
  static bool get isMobile => isIOS || isAndroid;
  static bool get isDesktop => isMacOS || isWindows || isLinux;
  static bool get isApple => isIOS || isMacOS;

  // --- Build mode ---

  static bool get isDebug => kDebugMode;
  static bool get isRelease => kReleaseMode;
  static bool get isProfile => kProfileMode;

  // --- Platform-specific values ---

  /// Returns the first non-null platform override, otherwise [defaultValue].
  static T platformValue<T>({
    required T defaultValue,
    T? ios,
    T? android,
    T? macos,
    T? windows,
    T? linux,
    T? web,
  }) {
    if (isIOS && ios != null) return ios;
    if (isAndroid && android != null) return android;
    if (isMacOS && macos != null) return macos;
    if (isWindows && windows != null) return windows;
    if (isLinux && linux != null) return linux;
    if (isWeb && web != null) return web;
    return defaultValue;
  }

  /// Human-readable platform label for logging or analytics.
  static String get platformName {
    if (isIOS) return 'iOS';
    if (isAndroid) return 'Android';
    if (isMacOS) return 'macOS';
    if (isWindows) return 'Windows';
    if (isLinux) return 'Linux';
    if (isWeb) return 'Web';
    return 'Unknown';
  }

  /// OS version string. Returns `'Web'` on web.
  static String get osVersion {
    if (isWeb) return 'Web';
    return Platform.operatingSystemVersion;
  }

  /// System locale name. Falls back to `'en'` on web.
  static String get locale {
    if (isWeb) return 'en';
    return Platform.localeName;
  }

  /// CPU count. Returns `1` on web.
  static int get numberOfProcessors {
    if (isWeb) return 1;
    return Platform.numberOfProcessors;
  }

  // --- Environment ---

  /// Reads a process environment variable. Always `null` on web.
  static String? getEnv(String key) {
    if (isWeb) return null;
    return Platform.environment[key];
  }

  /// Whether [key] exists in the process environment.
  static bool hasEnv(String key) => getEnv(key) != null;
}
