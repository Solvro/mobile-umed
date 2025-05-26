import "package:flutter/material.dart";
import "../assets/fonts.gen.dart";
import "color_consts.dart";

abstract interface class AppThemeData {
  ThemeData get light => ThemeData.light();

  ThemeData get dark => ThemeData.dark();
}

class AppTheme implements AppThemeData {
  @override
  ThemeData get dark => ThemeData();

  @override
  ThemeData get light => ThemeData(
    colorScheme: const ColorScheme.light(
      primary: ColorConsts.lightGreen,
      secondary: ColorConsts.green,
      surface: ColorConsts.whiteGray,
      onPrimary: ColorConsts.whiteGray,
      onSecondary: Colors.white,
      error: ColorConsts.red,
      onTertiary: ColorConsts.onyx,
    ),
    textTheme: _textTheme,
    fontFamily: FontFamily.urbanist,
    elevatedButtonTheme: _elevatedButtonTheme,
  );

  static const _textTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: ColorConsts.onyx),
    headlineMedium: TextStyle(fontSize: 23, fontWeight: FontWeight.w400, color: ColorConsts.lightGreen),
    headlineSmall: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: ColorConsts.onyx),
    titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: ColorConsts.onyx),
    titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: ColorConsts.lightGreen),
    bodyLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ColorConsts.onyx, height: 1.2),
    bodyMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ColorConsts.dimGray, height: 1.2),
    labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: ColorConsts.whiteGray),
    labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ColorConsts.whiteGray),
    labelSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorConsts.whiteGray),
  );

  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(44, 44),
      backgroundColor: ColorConsts.lightGreen,
      foregroundColor: ColorConsts.whiteGray,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.symmetric(vertical: 6),
      textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
    ),
  );
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
