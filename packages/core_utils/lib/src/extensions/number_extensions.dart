import 'package:flutter/material.dart';

/// [num] duration, spacing, radius, clamp, and display-format helpers.
extension NumExtensions on num {
  // ==================== Duration ====================

  /// Convert to milliseconds duration
  Duration get ms => Duration(milliseconds: toInt());

  /// Convert to seconds duration
  Duration get seconds => Duration(seconds: toInt());

  /// Convert to minutes duration
  Duration get minutes => Duration(minutes: toInt());

  /// Convert to hours duration
  Duration get hours => Duration(hours: toInt());

  /// Convert to days duration
  Duration get days => Duration(days: toInt());

  // ==================== SizedBox ====================

  /// Create horizontal SizedBox
  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  /// Create vertical SizedBox
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  /// Create square SizedBox
  SizedBox get squareSpace => SizedBox(width: toDouble(), height: toDouble());

  // ==================== EdgeInsets ====================

  /// Create EdgeInsets with all sides
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  /// Create horizontal EdgeInsets
  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  /// Create vertical EdgeInsets
  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

  // ==================== BorderRadius ====================

  /// Create circular BorderRadius
  BorderRadius get circularRadius => BorderRadius.circular(toDouble());

  /// Create only top BorderRadius
  BorderRadius get topRadius => BorderRadius.vertical(
        top: Radius.circular(toDouble()),
      );

  /// Create only bottom BorderRadius
  BorderRadius get bottomRadius => BorderRadius.vertical(
        bottom: Radius.circular(toDouble()),
      );

  /// Create only left BorderRadius
  BorderRadius get leftRadius => BorderRadius.horizontal(
        left: Radius.circular(toDouble()),
      );

  /// Create only right BorderRadius
  BorderRadius get rightRadius => BorderRadius.horizontal(
        right: Radius.circular(toDouble()),
      );

  // ==================== Clamping ====================

  /// Clamp value between 0 and 1
  double get normalized => clamp(0.0, 1.0).toDouble();

  /// Clamp value between 0 and 100
  double get percentage => clamp(0.0, 100.0).toDouble();

  // ==================== Formatting ====================

  /// Format as currency
  String toCurrency({String symbol = 'Rp', int decimals = 0}) {
    final formatted = toDouble().toStringAsFixed(decimals);
    final parts = formatted.split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
    if (decimals > 0 && parts.length > 1) {
      return '$symbol$intPart,${parts[1]}';
    }
    return '$symbol$intPart';
  }

  /// Format with thousand separators
  String get formatted => toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      );

  /// Format as compact (1K, 1M, etc.)
  String get compact {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toString();
  }

  /// Format as percentage
  String get asPercentage => '${toStringAsFixed(0)}%';

  /// Format as rating (e.g., 4.5)
  String get asRating => toDouble().toStringAsFixed(1);

  /// Format as distance (km or m)
  String get asDistance {
    if (this >= 1) {
      return '${toDouble().toStringAsFixed(1)} km';
    }
    return '${(this * 1000).toInt()} m';
  }
}

/// [int]-specific parity checks, ranges, and iteration.
extension IntExtensions on int {
  /// Check if even
  bool get isEven => this % 2 == 0;

  /// Check if odd
  bool get isOdd => this % 2 != 0;

  /// Range from 0 to this number
  Iterable<int> get range => Iterable.generate(this);

  /// Repeat an action n times
  void times(void Function(int index) action) {
    for (var i = 0; i < this; i++) {
      action(i);
    }
  }
}

/// [double] rounding and approximate equality.
extension DoubleExtensions on double {
  /// Round to specific decimal places
  double roundTo(int places) {
    final mod = 10.0 * places;
    return (this * mod).round() / mod;
  }

  /// Check if approximately equal
  bool approximatelyEquals(double other, {double epsilon = 0.0001}) =>
      (this - other).abs() < epsilon;
}
