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
      primary: ColorConsts.plumosa,
      secondary: ColorConsts.turtleLake,
      tertiary: ColorConsts.blancTurtle,
      surface: ColorConsts.whiteGray,
      onPrimary: ColorConsts.whiteGray,
      onSecondary: Colors.white,
      error: ColorConsts.lightOrange,
      onTertiary: ColorConsts.onyx,
    ),
    textTheme: _textTheme,
    fontFamily: FontFamily.urbanist,
    elevatedButtonTheme: _elevatedButtonTheme,
    segmentedButtonTheme: _segmentedButtonTheme,
  );

  static const _textTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: ColorConsts.onyx),
    headlineMedium: TextStyle(fontSize: 23, fontWeight: FontWeight.w400, color: ColorConsts.plumosa),
    headlineSmall: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: ColorConsts.onyx),
    titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: ColorConsts.onyx),
    titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: ColorConsts.plumosa),
    bodyLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ColorConsts.onyx, height: 1.2),
    bodyMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ColorConsts.dimGray, height: 1.2),
    labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: ColorConsts.whiteGray),
    labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ColorConsts.whiteGray),
    labelSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorConsts.whiteGray),
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: ColorConsts.dimGray),
  );

  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(44, 44),
      backgroundColor: ColorConsts.plumosa,
      foregroundColor: ColorConsts.whiteGray,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.symmetric(vertical: 6),
      textStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
    ),
  );

  SegmentedButtonThemeData get _segmentedButtonTheme => SegmentedButtonThemeData(
    style: SegmentedButton.styleFrom(
      backgroundColor: ColorConsts.whiteGray,
      foregroundColor: ColorConsts.plumosa,
      selectedForegroundColor: ColorConsts.whiteGray,
      selectedBackgroundColor: ColorConsts.plumosa,
      side: const BorderSide(color: ColorConsts.plumosa, width: 2),
    ),
  );
}

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
