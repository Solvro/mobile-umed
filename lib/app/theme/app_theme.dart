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
      primary: ColorConsts.primary,
      secondary: ColorConsts.secondary,
      surface: ColorConsts.surface,
      onPrimary: ColorConsts.onPrimary,
      onSecondary: ColorConsts.onSecondary,
      onSurface: ColorConsts.onSurface,
      error: ColorConsts.error,
      onError: ColorConsts.onError,
    ),
    textTheme: _textTheme,
    fontFamily: FontFamily.urbanist,
    elevatedButtonTheme: _elevatedButtonTheme,
  );

  static const _textTheme = TextTheme(
    headlineMedium: TextStyle(fontSize: 23, fontWeight: FontWeight.w400, color: ColorConsts.primary),
    headlineSmall: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: ColorConsts.onSurface),
    titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: ColorConsts.onSurface),
    bodyLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ColorConsts.onSurface, height: 1.2),
    bodyMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ColorConsts.dimGray, height: 1.2),
  );

  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(44, 44),
      backgroundColor: ColorConsts.primary,
      foregroundColor: ColorConsts.onPrimary,
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
