import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';

class AppPallete {
  AppPallete._();
  // --- Spotify Theme - Light Mode ---
  static const Color backgroundLight = Color(0xFFFCFCFC);
  static const Color foregroundLight = Color(0xFF58615D);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardForegroundLight = Color(0xFF58615D);
  static const Color popoverLight = Color(0xFFFFFFFF);
  static const Color popoverForegroundLight = Color(0xFF58615D);
  static const Color primaryLight = Color(0xFF1AC966);
  static const Color primaryForegroundLight = Color(0xFFF9FAFA);
  static const Color secondaryLight = Color(0xFFE2E1F3);
  static const Color secondaryForegroundLight = Color(0xFF32313F);
  static const Color mutedLight = Color(0xFFE3E1F4);
  static const Color mutedForegroundLight = Color(0xFF7E8098);
  static const Color accentLight = Color(0xFFE3E1F4);
  static const Color accentForegroundLight = Color(0xFF58615D);
  static const Color destructiveLight = Color(0xFFE5484D);
  static const Color borderLight = Color(0xFFECEAF8);
  static const Color inputLight = Color(0xFFD5D2F5);
  static const Color ringLight = Color(0xFF1AC966);
  static const Color sidebarLight = Color(0xFFF9F9FB);

  // --- Spotify Theme - Dark Mode ---
  static const Color backgroundDark = Color(0xFF1A1921);
  static const Color foregroundDark = Color(0xFFF2F0FC);
  static const Color cardDark = Color(0xFF32313F);
  static const Color cardForegroundDark = Color(0xFFF2F0FC);
  static const Color popoverDark = Color(0xFF32313F);
  static const Color popoverForegroundDark = Color(0xFFF2F0FC);
  static const Color primaryDark = Color(0xFF1AC966);
  static const Color primaryForegroundDark = Color(0xFF1A1921);
  static const Color secondaryDark = Color(0xFF4A4959);
  static const Color secondaryForegroundDark = Color(0xFFF2F0FC);
  static const Color mutedDark = Color(0xFF4A4959);
  static const Color mutedForegroundDark = Color(0xFF9897A9);
  static const Color accentDark = Color(0xFF4A4959);
  static const Color accentForegroundDark = Color(0xFFF2F0FC);
  static const Color destructiveDark = Color(0xFFEE5358);
  static const Color borderDark = Color(
    0xFFF2F0FC,
  ); // Note: Original has 15% opacity, applied in ThemeData
  static const Color inputDark = Color(
    0xFFF2F0FC,
  ); // Note: Original has 20% opacity, applied in ThemeData
  static const Color ringDark = Color(0xFF1AC966);
  static const Color sidebarDark = Color(0xFF32313F);

  static Color borderInput = DimensionConstant.isDark ? borderLight : borderDark;
  /// Chart colors for the dark theme.
  static const List<Color> chartColorsDark = [
    Color(0xFF1AC966), // chart-1
    Color(0xFF9F61F2), // chart-2
    Color(0xFF00A9E5), // chart-3
    Color(0xFFD4B900), // chart-4
    Color(0xFFE024B2), // chart-5
  ];

  static List<BoxShadow> shadow2xs = [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.01),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> shadowXs = [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.01),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.01),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha:0.01),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: -1,
    ),
  ];

  static List<BoxShadow> shadow = shadowSm;

  static List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.01),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha:0.01),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  static List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.01),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha:0.01),
      offset: const Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
  ];

  static List<BoxShadow> shadowXl = [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.01),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha:0.01),
      offset: const Offset(0, 8),
      blurRadius: 10,
      spreadRadius: -1,
    ),
  ];

  static List<BoxShadow> shadow2xl = [
    BoxShadow(
      color: Colors.black.withValues(alpha:0.03),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];
  static const Color transparentColor = Colors.transparent;
}
