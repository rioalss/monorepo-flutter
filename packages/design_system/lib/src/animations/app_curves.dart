/// Standard animation curves for UI motion.
///
/// Material 3–aligned base curves plus semantic aliases mapped to
/// common interaction patterns (buttons, modals, page transitions).
library;

import 'package:flutter/material.dart';

/// Named [Curve] constants for consistent motion across the app.
abstract final class AppCurves {
  // Standard Material motion curves
  static const Curve standard = Curves.easeOutCubic;
  static const Curve decelerate = Curves.easeOutQuart;
  static const Curve accelerate = Curves.easeInQuart;
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve emphasizedDecelerate = Curves.easeOutQuint;
  static const Curve emphasizedAccelerate = Curves.easeInQuint;

  // Special-purpose curves
  static const Curve linear = Curves.linear;
  static const Curve bounce = Curves.bounceOut;
  static const Curve elastic = Curves.elasticOut;
  static const Curve spring = Curves.fastOutSlowIn;
  static const Curve overshoot = Curves.easeOutBack;
  static const Curve anticipate = Curves.easeInBack;
  static const Curve smoothStep = Curves.ease;

  // Semantic aliases — each maps to a base curve above for a specific UI pattern
  static const Curve buttonPress = decelerate;
  static const Curve buttonRelease = standard;
  static const Curve modalIn = emphasizedDecelerate;
  static const Curve modalOut = emphasizedAccelerate;
  static const Curve bottomSheetIn = emphasizedDecelerate;
  static const Curve bottomSheetOut = accelerate;
  static const Curve pagePush = decelerate;
  static const Curve pagePop = accelerate;
  static const Curve cardExpand = emphasized;
  static const Curve cardCollapse = standard;
  static const Curve fab = overshoot;
  static const Curve toggle = standard;
  static const Curve listItemIn = decelerate;
  static const Curve shimmer = linear;
  static const Curve shake = linear;
  static const Curve pulse = Curves.easeInOut;
  static const Curve celebration = bounce;
  static const Curve counter = decelerate;
  static const Curve progress = decelerate;
  static const Curve tooltipIn = decelerate;
  static const Curve tooltipOut = accelerate;
  static const Curve searchExpand = emphasized;
  static const Curve tabIndicator = standard;
  static const Curve ripple = decelerate;
  static const Curve iconMorph = standard;
  static const Curve bidCardIn = overshoot;
  static const Curve ratingFill = decelerate;
  static const Curve mapZoom = standard;
  static const Curve avatarScale = spring;
}
