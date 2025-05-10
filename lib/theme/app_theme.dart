import "package:flutter/material.dart";

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF9AB55E), // Green
      secondary: Color(0xFFD93B3A), // Jasper
      surface: Color(0xFFFAFAFA), // White (#FAFAFA)
      onPrimary: Color(0xFFFAFAFA), // White (#FAFAFA)
      onSecondary: Color(0xFFFAFAFA), // White (#FAFAFA)
      onSurface: Color(0xFF0F0F0F), // Onyx
      error: Color(0xFFD93B3A), // Jasper
      onError: Color(0xFFFAFAFA), // White (#FAFAFA)
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Color(0xFF0F0F0F), // Onyx
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color(0xFF0F0F0F), // Onyx
      ),
      bodyLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color(0xFF0F0F0F), // Onyx
        height: 1.2,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B6B6B), // Dim Gray
        height: 1.2,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF9AB55E), // Green
      secondary: Color(0xFFD93B3A), // Jasper
      surface: Color(0xFF0F0F0F), // Onyx
      onPrimary: Color(0xFFFAFAFA), // White (#FAFAFA)
      onSecondary: Color(0xFFFAFAFA), // White (#FAFAFA)
      onSurface: Color(0xFFFAFAFA), // White (#FAFAFA)
      error: Color(0xFFD93B3A), // Jasper
      onError: Color(0xFFFAFAFA), // White (#FAFAFA)
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Color(0xFFFAFAFA), // White (#FAFAFA)
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color(0xFFFAFAFA), // White (#FAFAFA)
      ),
      bodyLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color(0xFFFAFAFA), // White (#FAFAFA)
        height: 1.2,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B6B6B), // Dim Gray
        height: 1.2,
      ),
    ),
  );
}
