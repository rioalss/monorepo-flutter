/// Numeric font-size tokens and Material 3–aligned metric helpers.
///
/// Sizes `fs1`–`fs100` are literal point values. Use `lineHeight` and
/// `letterSpacing` when building styles that need automatic rhythm.
library;

/// Font size constants and default typographic metrics by size.
abstract final class AppFontScale {
  // Size tokens fs1–fs100: each value equals its label in logical pixels.

  static const double fs1 = 1;
  static const double fs2 = 2;
  static const double fs3 = 3;
  static const double fs4 = 4;
  static const double fs5 = 5;
  static const double fs6 = 6;
  static const double fs7 = 7;
  static const double fs8 = 8;
  static const double fs9 = 9;
  static const double fs10 = 10;
  static const double fs11 = 11;
  static const double fs12 = 12;
  static const double fs13 = 13;
  static const double fs14 = 14;
  static const double fs15 = 15;
  static const double fs16 = 16;
  static const double fs17 = 17;
  static const double fs18 = 18;
  static const double fs19 = 19;
  static const double fs20 = 20;
  static const double fs21 = 21;
  static const double fs22 = 22;
  static const double fs23 = 23;
  static const double fs24 = 24;
  static const double fs25 = 25;
  static const double fs26 = 26;
  static const double fs27 = 27;
  static const double fs28 = 28;
  static const double fs29 = 29;
  static const double fs30 = 30;
  static const double fs31 = 31;
  static const double fs32 = 32;
  static const double fs33 = 33;
  static const double fs34 = 34;
  static const double fs35 = 35;
  static const double fs36 = 36;
  static const double fs37 = 37;
  static const double fs38 = 38;
  static const double fs39 = 39;
  static const double fs40 = 40;
  static const double fs41 = 41;
  static const double fs42 = 42;
  static const double fs43 = 43;
  static const double fs44 = 44;
  static const double fs45 = 45;
  static const double fs46 = 46;
  static const double fs47 = 47;
  static const double fs48 = 48;
  static const double fs49 = 49;
  static const double fs50 = 50;
  static const double fs51 = 51;
  static const double fs52 = 52;
  static const double fs53 = 53;
  static const double fs54 = 54;
  static const double fs55 = 55;
  static const double fs56 = 56;
  static const double fs57 = 57;
  static const double fs58 = 58;
  static const double fs59 = 59;
  static const double fs60 = 60;
  static const double fs61 = 61;
  static const double fs62 = 62;
  static const double fs63 = 63;
  static const double fs64 = 64;
  static const double fs65 = 65;
  static const double fs66 = 66;
  static const double fs67 = 67;
  static const double fs68 = 68;
  static const double fs69 = 69;
  static const double fs70 = 70;
  static const double fs71 = 71;
  static const double fs72 = 72;
  static const double fs73 = 73;
  static const double fs74 = 74;
  static const double fs75 = 75;
  static const double fs76 = 76;
  static const double fs77 = 77;
  static const double fs78 = 78;
  static const double fs79 = 79;
  static const double fs80 = 80;
  static const double fs81 = 81;
  static const double fs82 = 82;
  static const double fs83 = 83;
  static const double fs84 = 84;
  static const double fs85 = 85;
  static const double fs86 = 86;
  static const double fs87 = 87;
  static const double fs88 = 88;
  static const double fs89 = 89;
  static const double fs90 = 90;
  static const double fs91 = 91;
  static const double fs92 = 92;
  static const double fs93 = 93;
  static const double fs94 = 94;
  static const double fs95 = 95;
  static const double fs96 = 96;
  static const double fs97 = 97;
  static const double fs98 = 98;
  static const double fs99 = 99;
  static const double fs100 = 100;

  /// Recommended line-height ratio for [fontSize] (Material 3 type scale).
  ///
  /// Larger display sizes use tighter ratios; body sizes use ~1.4–1.5.
  static double lineHeight(double fontSize) {
    if (fontSize >= 90) return 1.05;
    if (fontSize >= 72) return 1.08;
    if (fontSize >= 57) return 1.12;
    if (fontSize >= 45) return 1.16;
    if (fontSize >= 36) return 1.22;
    if (fontSize >= 32) return 1.25;
    if (fontSize >= 28) return 1.29;
    if (fontSize >= 24) return 1.33;
    if (fontSize >= 22) return 1.27;
    if (fontSize >= 18) return 1.5;
    if (fontSize >= 16) return 1.5;
    if (fontSize >= 14) return 1.43;
    if (fontSize >= 12) return 1.33;
    if (fontSize >= 11) return 1.45;
    return 1.4;
  }

  /// Recommended letter spacing in logical pixels for [fontSize].
  ///
  /// Display sizes use negative tracking; small body text uses positive spacing.
  static double letterSpacing(double fontSize) {
    if (fontSize >= 90) return -0.75;
    if (fontSize >= 72) return -0.5;
    if (fontSize >= 57) return -0.25;
    if (fontSize >= 45) return 0;
    if (fontSize >= 36) return 0;
    if (fontSize >= 32) return 0;
    if (fontSize >= 28) return 0;
    if (fontSize >= 24) return 0;
    if (fontSize >= 22) return 0;
    if (fontSize >= 18) return 0.15;
    if (fontSize >= 16) return 0.15;
    if (fontSize >= 14) return 0.25;
    if (fontSize >= 12) return 0.4;
    if (fontSize >= 11) return 0.5;
    return 0.4;
  }
}
