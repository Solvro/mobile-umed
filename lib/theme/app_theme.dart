import "package:flutter/material.dart";
import "color_consts.dart";

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: ColorConsts.primary,
      secondary: ColorConsts.secondary,
      surface: ColorConsts.surface,
      onPrimary: ColorConsts.onPrimary,
      onSecondary: ColorConsts.onSecondary,
      onSurface: ColorConsts.onSurface,
      error: ColorConsts.error,
      onError: ColorConsts.onError,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: ColorConsts.onSurface,
        fontFamily: "Urbanist",
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: ColorConsts.onSurface,
        fontFamily: "Urbanist",
      ),
      bodyLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: ColorConsts.onSurface,
        height: 1.2,
        fontFamily: "Urbanist",
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: ColorConsts.dimGray,
        height: 1.2,
        fontFamily: "Urbanist",
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: ColorConsts.primary,
      secondary: ColorConsts.secondary,
      surface: ColorConsts.onSurface,
      onPrimary: ColorConsts.onPrimary,
      onSecondary: ColorConsts.onSecondary,
      onSurface: ColorConsts.onPrimary,
      error: ColorConsts.error,
      onError: ColorConsts.onError,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: ColorConsts.onPrimary,
        fontFamily: "Urbanist",
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: ColorConsts.onPrimary,
        fontFamily: "Urbanist",
      ),
      bodyLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: ColorConsts.onPrimary,
        height: 1.2,
        fontFamily: "Urbanist",
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: ColorConsts.dimGray,
        height: 1.2,
        fontFamily: "Urbanist",
      ),
    ),
  );
}
