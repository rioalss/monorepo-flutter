/// Fluent typography API built on `AppTextStyleBuilder`.
///
/// Use `AppTypography.fsN` for preset sizes (1–100) or semantic roles such as
/// `heading1()`, `body()`, and `label()`.
/// Chain weight and color modifiers before calling a terminal like `.medium.red()`.
library;

import 'package:design_system/src/typography/app_font_family.dart';
import 'package:design_system/src/typography/app_font_scale.dart';
import 'package:design_system/src/typography/app_semantic_typography.dart';
import 'package:design_system/src/typography/app_text_style_builder.dart';
import 'package:flutter/material.dart';

/// Entry point for building text styles with a chainable API.
abstract final class AppTypography {
  /// Default family applied when `fs` is called without `fontFamily`.
  static AppFontFamily defaultFontFamily = AppFontFamily.dmSans;

  /// Creates a builder for [size] with optional metric overrides.
  ///
  /// Falls back to [defaultFontFamily] when `fontFamily` is omitted.
  /// Returns a builder — call `.regular`, `.medium`, etc., then a terminal
  /// such as `.color(...)` to obtain a `TextStyle`.
  static AppTextStyleBuilder fs(
    double size, {
    double? height,
    FontWeight? weight,
    double? letterSpacing,
    AppFontFamily? fontFamily,
  }) =>
      AppTextStyleBuilder(
        TextStyle(
          fontFamily: fontFamily?.name ?? defaultFontFamily.name,
          fontSize: size,
          height: height,
          letterSpacing: letterSpacing,
          fontWeight: weight,
        ),
      );

  // Preset size getters — each `fsN` maps to `AppFontScale.fsN` (N = 1…100).

  static AppTextStyleBuilder get fs1 => fs(AppFontScale.fs1);
  static AppTextStyleBuilder get fs2 => fs(AppFontScale.fs2);
  static AppTextStyleBuilder get fs3 => fs(AppFontScale.fs3);
  static AppTextStyleBuilder get fs4 => fs(AppFontScale.fs4);
  static AppTextStyleBuilder get fs5 => fs(AppFontScale.fs5);
  static AppTextStyleBuilder get fs6 => fs(AppFontScale.fs6);
  static AppTextStyleBuilder get fs7 => fs(AppFontScale.fs7);
  static AppTextStyleBuilder get fs8 => fs(AppFontScale.fs8);
  static AppTextStyleBuilder get fs9 => fs(AppFontScale.fs9);
  static AppTextStyleBuilder get fs10 => fs(AppFontScale.fs10);
  static AppTextStyleBuilder get fs11 => fs(AppFontScale.fs11);
  static AppTextStyleBuilder get fs12 => fs(AppFontScale.fs12);
  static AppTextStyleBuilder get fs13 => fs(AppFontScale.fs13);
  static AppTextStyleBuilder get fs14 => fs(AppFontScale.fs14);
  static AppTextStyleBuilder get fs15 => fs(AppFontScale.fs15);
  static AppTextStyleBuilder get fs16 => fs(AppFontScale.fs16);
  static AppTextStyleBuilder get fs17 => fs(AppFontScale.fs17);
  static AppTextStyleBuilder get fs18 => fs(AppFontScale.fs18);
  static AppTextStyleBuilder get fs19 => fs(AppFontScale.fs19);
  static AppTextStyleBuilder get fs20 => fs(AppFontScale.fs20);
  static AppTextStyleBuilder get fs21 => fs(AppFontScale.fs21);
  static AppTextStyleBuilder get fs22 => fs(AppFontScale.fs22);
  static AppTextStyleBuilder get fs23 => fs(AppFontScale.fs23);
  static AppTextStyleBuilder get fs24 => fs(AppFontScale.fs24);
  static AppTextStyleBuilder get fs25 => fs(AppFontScale.fs25);
  static AppTextStyleBuilder get fs26 => fs(AppFontScale.fs26);
  static AppTextStyleBuilder get fs27 => fs(AppFontScale.fs27);
  static AppTextStyleBuilder get fs28 => fs(AppFontScale.fs28);
  static AppTextStyleBuilder get fs29 => fs(AppFontScale.fs29);
  static AppTextStyleBuilder get fs30 => fs(AppFontScale.fs30);
  static AppTextStyleBuilder get fs31 => fs(AppFontScale.fs31);
  static AppTextStyleBuilder get fs32 => fs(AppFontScale.fs32);
  static AppTextStyleBuilder get fs33 => fs(AppFontScale.fs33);
  static AppTextStyleBuilder get fs34 => fs(AppFontScale.fs34);
  static AppTextStyleBuilder get fs35 => fs(AppFontScale.fs35);
  static AppTextStyleBuilder get fs36 => fs(AppFontScale.fs36);
  static AppTextStyleBuilder get fs37 => fs(AppFontScale.fs37);
  static AppTextStyleBuilder get fs38 => fs(AppFontScale.fs38);
  static AppTextStyleBuilder get fs39 => fs(AppFontScale.fs39);
  static AppTextStyleBuilder get fs40 => fs(AppFontScale.fs40);
  static AppTextStyleBuilder get fs41 => fs(AppFontScale.fs41);
  static AppTextStyleBuilder get fs42 => fs(AppFontScale.fs42);
  static AppTextStyleBuilder get fs43 => fs(AppFontScale.fs43);
  static AppTextStyleBuilder get fs44 => fs(AppFontScale.fs44);
  static AppTextStyleBuilder get fs45 => fs(AppFontScale.fs45);
  static AppTextStyleBuilder get fs46 => fs(AppFontScale.fs46);
  static AppTextStyleBuilder get fs47 => fs(AppFontScale.fs47);
  static AppTextStyleBuilder get fs48 => fs(AppFontScale.fs48);
  static AppTextStyleBuilder get fs49 => fs(AppFontScale.fs49);
  static AppTextStyleBuilder get fs50 => fs(AppFontScale.fs50);
  static AppTextStyleBuilder get fs51 => fs(AppFontScale.fs51);
  static AppTextStyleBuilder get fs52 => fs(AppFontScale.fs52);
  static AppTextStyleBuilder get fs53 => fs(AppFontScale.fs53);
  static AppTextStyleBuilder get fs54 => fs(AppFontScale.fs54);
  static AppTextStyleBuilder get fs55 => fs(AppFontScale.fs55);
  static AppTextStyleBuilder get fs56 => fs(AppFontScale.fs56);
  static AppTextStyleBuilder get fs57 => fs(AppFontScale.fs57);
  static AppTextStyleBuilder get fs58 => fs(AppFontScale.fs58);
  static AppTextStyleBuilder get fs59 => fs(AppFontScale.fs59);
  static AppTextStyleBuilder get fs60 => fs(AppFontScale.fs60);
  static AppTextStyleBuilder get fs61 => fs(AppFontScale.fs61);
  static AppTextStyleBuilder get fs62 => fs(AppFontScale.fs62);
  static AppTextStyleBuilder get fs63 => fs(AppFontScale.fs63);
  static AppTextStyleBuilder get fs64 => fs(AppFontScale.fs64);
  static AppTextStyleBuilder get fs65 => fs(AppFontScale.fs65);
  static AppTextStyleBuilder get fs66 => fs(AppFontScale.fs66);
  static AppTextStyleBuilder get fs67 => fs(AppFontScale.fs67);
  static AppTextStyleBuilder get fs68 => fs(AppFontScale.fs68);
  static AppTextStyleBuilder get fs69 => fs(AppFontScale.fs69);
  static AppTextStyleBuilder get fs70 => fs(AppFontScale.fs70);
  static AppTextStyleBuilder get fs71 => fs(AppFontScale.fs71);
  static AppTextStyleBuilder get fs72 => fs(AppFontScale.fs72);
  static AppTextStyleBuilder get fs73 => fs(AppFontScale.fs73);
  static AppTextStyleBuilder get fs74 => fs(AppFontScale.fs74);
  static AppTextStyleBuilder get fs75 => fs(AppFontScale.fs75);
  static AppTextStyleBuilder get fs76 => fs(AppFontScale.fs76);
  static AppTextStyleBuilder get fs77 => fs(AppFontScale.fs77);
  static AppTextStyleBuilder get fs78 => fs(AppFontScale.fs78);
  static AppTextStyleBuilder get fs79 => fs(AppFontScale.fs79);
  static AppTextStyleBuilder get fs80 => fs(AppFontScale.fs80);
  static AppTextStyleBuilder get fs81 => fs(AppFontScale.fs81);
  static AppTextStyleBuilder get fs82 => fs(AppFontScale.fs82);
  static AppTextStyleBuilder get fs83 => fs(AppFontScale.fs83);
  static AppTextStyleBuilder get fs84 => fs(AppFontScale.fs84);
  static AppTextStyleBuilder get fs85 => fs(AppFontScale.fs85);
  static AppTextStyleBuilder get fs86 => fs(AppFontScale.fs86);
  static AppTextStyleBuilder get fs87 => fs(AppFontScale.fs87);
  static AppTextStyleBuilder get fs88 => fs(AppFontScale.fs88);
  static AppTextStyleBuilder get fs89 => fs(AppFontScale.fs89);
  static AppTextStyleBuilder get fs90 => fs(AppFontScale.fs90);
  static AppTextStyleBuilder get fs91 => fs(AppFontScale.fs91);
  static AppTextStyleBuilder get fs92 => fs(AppFontScale.fs92);
  static AppTextStyleBuilder get fs93 => fs(AppFontScale.fs93);
  static AppTextStyleBuilder get fs94 => fs(AppFontScale.fs94);
  static AppTextStyleBuilder get fs95 => fs(AppFontScale.fs95);
  static AppTextStyleBuilder get fs96 => fs(AppFontScale.fs96);
  static AppTextStyleBuilder get fs97 => fs(AppFontScale.fs97);
  static AppTextStyleBuilder get fs98 => fs(AppFontScale.fs98);
  static AppTextStyleBuilder get fs99 => fs(AppFontScale.fs99);
  static AppTextStyleBuilder get fs100 => fs(AppFontScale.fs100);

  // ==================== Semantic Typography ====================

  /// Headline large — page titles, hero headings.
  static TextStyle heading1() => AppSemanticTypography.heading1;

  /// Headline medium — section headings.
  static TextStyle heading2() => AppSemanticTypography.heading2;

  /// Headline small — sub-section headings.
  static TextStyle heading3() => AppSemanticTypography.heading3;

  /// Body large — primary reading text.
  static TextStyle body() => AppSemanticTypography.body;

  /// Body medium — secondary reading text.
  static TextStyle bodySmall() => AppSemanticTypography.bodySmall;

  /// Body small — helper text, timestamps.
  static TextStyle caption() => AppSemanticTypography.caption;

  /// Label large — buttons, chips, form labels.
  static TextStyle label() => AppSemanticTypography.label;
}
