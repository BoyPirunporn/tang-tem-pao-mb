import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';

class DimensionConstant {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  static bool isDark =
      Theme.of(navigatorKey.currentContext!).brightness == Brightness.dark;
  // A base screen width used for scaling calculations.
  // This is roughly the width of a standard phone like an iPhone 13 Pro.
  static const double _baseScreenWidth = 390.0;

  /// Returns the full width of the screen.
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// Returns the full height of the screen.
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double height(BuildContext context, double size) =>
      MediaQuery.of(context).size.height * (size / 100);
  static double width(BuildContext context, double size) =>
      MediaQuery.of(context).size.width * (size / 100);

  /// Calculates a responsive font size that scales gently with the screen width.
  ///
  /// This method takes a `baseSize` (the desired font size on a standard screen)
  /// and adjusts it slightly based on the current screen width. The `clamp`
  /// function ensures the font size stays within a reasonable min/max range.
  ///
  /// [context] The BuildContext to get screen dimensions.
  /// [baseSize] The target font size in logical pixels (e.g., 14.0, 26.0).
  /// Returns the calculated responsive font size.
  static double responsiveFont(BuildContext context, double baseSize) {
    // The scaling factor determines how much the font size changes.
    // A smaller factor means less change.
    const double scaleFactor = 0.05;

    // Calculate the difference from the base screen width
    double widthDifference = screenWidth(context) - _baseScreenWidth;

    // Calculate the scaled size
    double scaledSize = baseSize + (widthDifference * scaleFactor);

    // Define min and max sizes to prevent text from being too small or too large.
    // We can set a reasonable range around the base size.
    double minSize = baseSize * 0.9;
    double maxSize = baseSize * 1.2;

    // Use clamp to ensure the final size is within the desired bounds.
    return scaledSize.clamp(minSize, maxSize);
  }

  /// Calculates a responsive padding/margin value based on screen width.
  ///
  /// [percentage] The desired percentage of the screen width (e.g., 5 for 5%).
  static double horizontalPadding(BuildContext context, double percentage) {
    return screenWidth(context) * (percentage / 100);
  }

  /// Calculates a responsive vertical padding/margin value based on screen width
  /// to maintain consistent aspect ratios in spacing.
  ///
  /// [percentage] The desired percentage of the screen width (e.g., 3 for 3%).
  static double verticalPadding(BuildContext context, double percentage) {
    return screenWidth(context) * (percentage / 100);
  }
}
