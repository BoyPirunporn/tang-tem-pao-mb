import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';

import 'app_pallete.dart';

class AppTheme {
  AppTheme._();

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 3),
    borderRadius: BorderRadius.circular(10),
  );

  /// --- Light Theme ---
  static ThemeData lightTheme(BuildContext context) =>
      ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppPallete.backgroundLight,
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: AppPallete.foregroundLight,
          displayColor: AppPallete.foregroundLight,
          fontFamily: "Kanit",
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          iconSize: DimensionConstant.responsiveFont(context, 32),
          sizeConstraints: BoxConstraints.tightFor(
            width: DimensionConstant.isMobile(context)
                ? DimensionConstant.horizontalPadding(context, 15)
                : DimensionConstant.horizontalPadding(context, 8),
            height: DimensionConstant.isMobile(context)
                ? DimensionConstant.horizontalPadding(context, 15)
                : DimensionConstant.horizontalPadding(context, 8),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(20),
          // enabledBorder: _border(AppPallete.backgroundDark),
          // border: _border(AppPallete.backgroundDark),
          focusedBorder: _border(AppPallete.primaryLight),
        ),
        colorScheme: ColorScheme.light(
          primary: AppPallete.primaryLight,
          onPrimary: AppPallete.primaryForegroundLight,
          secondary: AppPallete.secondaryLight,
          onSecondary: AppPallete.secondaryForegroundLight,
          error: AppPallete.destructiveLight,
          onError: AppPallete.destructiveLight,
        ),
        cardTheme: CardThemeData(
          color: AppPallete.cardLight,
          elevation: 6,
          shadowColor: AppPallete.backgroundDark.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppPallete.backgroundLight,
          selectedItemColor: AppPallete.primaryLight,
          unselectedItemColor: AppPallete.mutedForegroundLight,
          type: BottomNavigationBarType.fixed,
        ),
        tabBarTheme: TabBarThemeData(
          labelStyle: TextStyle(
            fontSize: DimensionConstant.responsiveFont(context, 18),
            fontFamily: "Kanit",
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: DimensionConstant.responsiveFont(context, 16),
            fontFamily: "Kanit",
          ),
        ),
      );

  /// --- Dark Theme ---
  static ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundDark,
    textTheme: ThemeData.dark().textTheme.apply(
      fontFamily: "kanit",
      bodyColor: AppPallete.foregroundDark,
      displayColor: AppPallete.foregroundDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(AppPallete.borderDark),
      focusedBorder: _border(AppPallete.primaryDark),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppPallete.primaryDark,
      onPrimary: AppPallete.accentDark,
      secondary: AppPallete.secondaryDark,
      onSecondary: AppPallete.secondaryForegroundDark,
      error: AppPallete.destructiveDark,
      onError: AppPallete.destructiveLight,
    ),
    cardTheme: CardThemeData(
      color: AppPallete.primaryForegroundDark,
      elevation: 8,
      shadowColor: const Color.fromARGB(255, 112, 139, 127),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPallete.backgroundDark,
      selectedItemColor: AppPallete.primaryLight,
      unselectedItemColor: AppPallete.mutedForegroundLight,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      iconSize: DimensionConstant.responsiveFont(context, 32),
      sizeConstraints: BoxConstraints.tightFor(
        width: DimensionConstant.isMobile(context)
            ? DimensionConstant.horizontalPadding(context, 15)
            : DimensionConstant.horizontalPadding(context, 8),
        height: DimensionConstant.isMobile(context)
            ? DimensionConstant.horizontalPadding(context, 15)
            : DimensionConstant.horizontalPadding(context, 8),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelStyle: TextStyle(
        fontSize: DimensionConstant.responsiveFont(context, 18),
        fontFamily: "Kanit",
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: DimensionConstant.responsiveFont(context, 16),
        fontFamily: "Kanit",
      ),
    ),
  );
}
