import 'package:flutter/material.dart';

/// Standardized layout dimensions for icons, avatars, controls, and surfaces.
abstract final class AppSizes {
  AppSizes._();

  static const double iconXs = 12;
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double icon = 24;
  static const double iconLg = 28;
  static const double iconXl = 32;
  static const double iconHuge = 48;

  static const double avatarXs = 24;
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatar = 48;
  static const double avatarLg = 56;
  static const double avatarXl = 64;
  static const double avatarHuge = 80;
  static const double avatarProfile = 120;

  static const double buttonSm = 32;
  static const double button = 44;
  static const double buttonLg = 52;
  static const double buttonXl = 56;
  static const double fab = 56;
  static const double fabMini = 40;

  static const double inputSm = 36;
  static const double input = 48;
  static const double inputLg = 56;

  static const double cardThumbnail = 60;
  static const double cardImage = 80;
  static const double cardBanner = 120;
  static const double cardHero = 200;

  static const double radiusNone = 0;
  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radius = 16;
  static const double radiusLg = 20;
  static const double radiusXl = 24;
  static const double radiusHuge = 28;
  static const double radiusFull = 999;

  static BorderRadius circular(double radius) => BorderRadius.circular(radius);
  static BorderRadius get borderRadiusSm => BorderRadius.circular(radiusSm);
  static BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);
  static BorderRadius get borderRadius => BorderRadius.circular(radius);
  static BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);

  static const double elevationNone = 0;
  static const double elevationXs = 1;
  static const double elevationSm = 2;
  static const double elevationMd = 4;
  static const double elevation = 6;
  static const double elevationLg = 8;
  static const double elevationXl = 12;

  static const double appBar = 56;
  static const double appBarLg = 88;
  static const double appBarExpanded = 200;

  static const double bottomNav = 80;
  static const double bottomSheetHandle = 4;
  static const double bottomSheetHandleWidth = 32;

  static const double divider = 1;
  static const double touchTarget = 48;
  static const double badge = 18;
  static const double statusDot = 8;
  static const double progressStroke = 3;
}
