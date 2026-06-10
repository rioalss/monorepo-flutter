// ignore_for_file: document_ignores, avoid_positional_boolean_parameters, sort_constructors_first

import 'package:flutter/material.dart';

/// [Widget] layout, styling, gesture, and visibility chaining helpers.
extension WidgetExtensions on Widget {
  // ==================== Padding ====================

  /// Add padding on all sides
  Widget padAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  /// Add symmetric padding
  Widget padSymmetric({double horizontal = 0, double vertical = 0}) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  /// Add horizontal padding only
  Widget padHorizontal(double value) => Padding(
        padding: EdgeInsets.symmetric(horizontal: value),
        child: this,
      );

  /// Add vertical padding only
  Widget padVertical(double value) => Padding(
        padding: EdgeInsets.symmetric(vertical: value),
        child: this,
      );

  /// Add padding on left
  Widget padLeft(double value) => Padding(
        padding: EdgeInsets.only(left: value),
        child: this,
      );

  /// Add padding on right
  Widget padRight(double value) => Padding(
        padding: EdgeInsets.only(right: value),
        child: this,
      );

  /// Add padding on top
  Widget padTop(double value) => Padding(
        padding: EdgeInsets.only(top: value),
        child: this,
      );

  /// Add padding on bottom
  Widget padBottom(double value) => Padding(
        padding: EdgeInsets.only(bottom: value),
        child: this,
      );

  /// Add custom padding
  Widget padOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          right: right,
          top: top,
          bottom: bottom,
        ),
        child: this,
      );

  // ==================== Alignment ====================

  /// Center the widget
  Widget centered() => Center(child: this);

  /// Align to top left
  Widget alignTopLeft() => Align(alignment: Alignment.topLeft, child: this);

  /// Align to top center
  Widget alignTopCenter() => Align(alignment: Alignment.topCenter, child: this);

  /// Align to top right
  Widget alignTopRight() => Align(alignment: Alignment.topRight, child: this);

  /// Align to center left
  Widget alignCenterLeft() =>
      Align(alignment: Alignment.centerLeft, child: this);

  /// Align to center right
  Widget alignCenterRight() =>
      Align(alignment: Alignment.centerRight, child: this);

  /// Align to bottom left
  Widget alignBottomLeft() =>
      Align(alignment: Alignment.bottomLeft, child: this);

  /// Align to bottom center
  Widget alignBottomCenter() =>
      Align(alignment: Alignment.bottomCenter, child: this);

  /// Align to bottom right
  Widget alignBottomRight() =>
      Align(alignment: Alignment.bottomRight, child: this);

  // ==================== Sizing ====================

  /// Set fixed width
  Widget width(double width) => SizedBox(width: width, child: this);

  /// Set fixed height
  Widget height(double height) => SizedBox(height: height, child: this);

  /// Set fixed size
  Widget size({required double width, required double height}) =>
      SizedBox(width: width, height: height, child: this);

  /// Set square size
  Widget square(double size) =>
      SizedBox(width: size, height: size, child: this);

  /// Expand to fill available space
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Flexible widget
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// Constrain width
  Widget constrainWidth({double? min, double? max}) => ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: min ?? 0,
          maxWidth: max ?? double.infinity,
        ),
        child: this,
      );

  /// Constrain height
  Widget constrainHeight({double? min, double? max}) => ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: min ?? 0,
          maxHeight: max ?? double.infinity,
        ),
        child: this,
      );

  // ==================== Decoration ====================

  /// Add rounded corners
  Widget rounded(double radius) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: this,
      );

  /// Make circular
  Widget circular() => ClipOval(child: this);

  /// Add background color
  Widget background(Color color) => ColoredBox(color: color, child: this);

  /// Add border
  Widget withBorder({
    Color color = Colors.grey,
    double width = 1,
    double radius = 0,
  }) =>
      DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: width),
          borderRadius: radius > 0 ? BorderRadius.circular(radius) : null,
        ),
        child: this,
      );

  // ==================== Opacity ====================

  /// Set opacity
  Widget opacity(double opacity) => Opacity(opacity: opacity, child: this);

  /// Semi-transparent (0.5)
  Widget semiTransparent() => opacity(0.5);

  /// Make invisible but keep space
  Widget invisible() => opacity(0);

  // ==================== Visibility ====================

  /// Conditionally show widget
  Widget visible(bool condition) => condition ? this : const SizedBox.shrink();

  /// Conditionally hide widget (keep space)
  Widget visibleOrInvisible(bool condition) => condition ? this : invisible();

  // ==================== Gestures ====================

  /// Add tap gesture
  Widget onTap(VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: this,
      );

  /// Add long press gesture
  Widget onLongPress(VoidCallback onLongPress) => GestureDetector(
        onLongPress: onLongPress,
        child: this,
      );

  /// Add double tap gesture
  Widget onDoubleTap(VoidCallback onDoubleTap) => GestureDetector(
        onDoubleTap: onDoubleTap,
        child: this,
      );

  // ==================== Animation ====================

  /// Wrap with AnimatedOpacity
  Widget animatedOpacity({
    required double opacity,
    Duration duration = const Duration(milliseconds: 300),
  }) =>
      AnimatedOpacity(opacity: opacity, duration: duration, child: this);

  /// Wrap with AnimatedContainer
  Widget animated({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) =>
      AnimatedSwitcher(
        duration: duration,
        switchInCurve: curve,
        child: this,
      );

  // ==================== Safe Area ====================

  /// Wrap with SafeArea
  Widget safeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) =>
      SafeArea(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: this,
      );

  /// Add only top safe area
  Widget safeAreaTop() => safeArea(bottom: false, left: false, right: false);

  /// Add only bottom safe area
  Widget safeAreaBottom() => safeArea(top: false, left: false, right: false);

  // ==================== Sliver ====================

  /// Wrap in SliverToBoxAdapter
  Widget sliver() => SliverToBoxAdapter(child: this);
}

/// Square spacing widget (`width` and `height` both [size]).
class Gap extends StatelessWidget {
  const Gap(this.size, {super.key});

  /// Extra extra small gap (2px)
  const Gap.xxs({super.key}) : size = 2;

  final double size;

  /// Extra small gap (4px)
  const Gap.xs({super.key}) : size = 4;

  /// Small gap (8px)
  const Gap.sm({super.key}) : size = 8;

  /// Medium gap (12px)
  const Gap.md({super.key}) : size = 12;

  /// Large gap (16px)
  const Gap.lg({super.key}) : size = 16;

  /// Extra large gap (20px)
  const Gap.xl({super.key}) : size = 20;

  /// Extra extra large gap (24px)
  const Gap.xxl({super.key}) : size = 24;

  /// Huge gap (32px)
  const Gap.huge({super.key}) : size = 32;

  @override
  Widget build(BuildContext context) => SizedBox(width: size, height: size);
}

/// Horizontal spacing only.
class HGap extends StatelessWidget {
  const HGap(this.size, {super.key});

  final double size;

  /// Extra extra small gap (2px)
  const HGap.xxs({super.key}) : size = 2;

  /// Extra small gap (4px)
  const HGap.xs({super.key}) : size = 4;

  /// Small gap (8px)
  const HGap.sm({super.key}) : size = 8;

  /// Medium gap (12px)
  const HGap.md({super.key}) : size = 12;

  /// Large gap (16px)
  const HGap.lg({super.key}) : size = 16;

  /// Extra large gap (20px)
  const HGap.xl({super.key}) : size = 20;

  /// Extra extra large gap (24px)
  const HGap.xxl({super.key}) : size = 24;

  /// Huge gap (32px)
  const HGap.huge({super.key}) : size = 32;

  @override
  Widget build(BuildContext context) => SizedBox(width: size);
}

/// Vertical spacing only.
class VGap extends StatelessWidget {
  const VGap(this.size, {super.key});

  final double size;

  /// Extra extra small gap (2px)
  const VGap.xxs({super.key}) : size = 2;

  /// Extra small gap (4px)
  const VGap.xs({super.key}) : size = 4;

  /// Small gap (8px)
  const VGap.sm({super.key}) : size = 8;

  /// Medium gap (12px)
  const VGap.md({super.key}) : size = 12;

  /// Large gap (16px)
  const VGap.lg({super.key}) : size = 16;

  /// Extra large gap (20px)
  const VGap.xl({super.key}) : size = 20;

  /// Extra extra large gap (24px)
  const VGap.xxl({super.key}) : size = 24;

  /// Huge gap (32px)
  const VGap.huge({super.key}) : size = 32;

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}
