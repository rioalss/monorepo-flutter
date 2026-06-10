import 'package:flutter/services.dart';

/// Semantic wrappers around [HapticFeedback] for consistent app-wide haptics.
///
/// Android requires `VIBRATE` permission in the manifest for some feedback types.
abstract final class Haptics {
  Haptics._();

  /// Light impact — subtle taps and navigation.
  static void light() => HapticFeedback.lightImpact();

  /// Medium impact — buttons and confirmations.
  static void medium() => HapticFeedback.mediumImpact();

  /// Heavy impact — warnings and destructive actions.
  static void heavy() => HapticFeedback.heavyImpact();

  /// Selection tick — toggles, sliders, pickers.
  static void selection() => HapticFeedback.selectionClick();

  /// Full vibration — errors and strong alerts.
  static void vibrate() => HapticFeedback.vibrate();

  // --- Semantic aliases ---

  static void tap() => light();
  static void button() => medium();
  static void success() => medium();
  static void error() => vibrate();
  static void warning() => heavy();
  static void confirm() => heavy();
  static void refresh() => medium();
  static void swipe() => light();
  static void longPress() => heavy();
  static void navigate() => light();
  static void toggle() => selection();
  static void slider() => selection();
  static void delete() => heavy();
  static void dismiss() => medium();
  static void notification() => medium();
  static void search() => light();
  static void add() => medium();
  static void favorite() => medium();
  static void bid() => heavy();
  static void payment() => heavy();
}
