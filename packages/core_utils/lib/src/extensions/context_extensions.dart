import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// [BuildContext] shortcuts for theme, layout, navigation, focus, and snack bars.
extension ContextExtensions on BuildContext {
  // ==================== Theme ====================

  /// Get current theme data
  ThemeData get theme => Theme.of(this);

  /// Get current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Check if current theme is dark
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Check if current theme is light
  bool get isLightMode => !isDarkMode;

  // ==================== Media Query ====================

  /// Get media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size
  Size get screenSize => mediaQuery.size;

  /// Get screen width
  double get screenWidth => screenSize.width;

  /// Get screen height
  double get screenHeight => screenSize.height;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  /// Get view insets (keyboard, etc.)
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// Get device pixel ratio
  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  /// Get bottom safe area
  double get bottomSafeArea => safeAreaPadding.bottom;

  /// Get top safe area
  double get topSafeArea => safeAreaPadding.top;

  // ==================== Screen Size Helpers ====================

  /// Small phone (iPhone SE, etc.)
  bool get isSmallScreen => screenWidth < 360;

  /// Standard phone
  bool get isMediumScreen => screenWidth >= 360 && screenWidth < 600;

  /// Tablet
  bool get isLargeScreen => screenWidth >= 600 && screenWidth < 900;

  /// Desktop/Large tablet
  bool get isExtraLargeScreen => screenWidth >= 900;

  /// Is tablet or larger
  bool get isTablet => screenWidth >= 600;

  /// Is phone
  bool get isPhone => screenWidth < 600;

  // ==================== Orientation ====================

  /// Check if portrait
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Check if landscape
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  // ==================== Navigation ====================

  /// Pop current route
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);

  /// Can pop current route
  bool get canPop => Navigator.of(this).canPop();

  /// Pop until predicate is true
  void popUntil(bool Function(Route<dynamic>) predicate) =>
      Navigator.of(this).popUntil(predicate);

  /// Pop to root
  void popToRoot() => popUntil((route) => route.isFirst);

  /// Push named route with go_router
  void pushRoute(String name, {Map<String, String>? params}) =>
      GoRouter.of(this).pushNamed(name, pathParameters: params ?? {});

  /// Go to named route with go_router
  void goRoute(String name, {Map<String, String>? params}) =>
      GoRouter.of(this).goNamed(name, pathParameters: params ?? {});

  // ==================== Focus ====================

  /// Unfocus current focus
  void unfocus() => FocusScope.of(this).unfocus();

  /// Request focus on a node
  void requestFocus(FocusNode node) => FocusScope.of(this).requestFocus(node);

  // ==================== Snackbar ====================

  /// Show snackbar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Show success snackbar
  void showSuccess(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green.shade600,
    );
  }

  /// Show error snackbar
  void showError(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.red.shade600,
    );
  }

  /// Hide current snackbar
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }
}
