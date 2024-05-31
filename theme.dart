// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

class GlobalThemeData {
  static final Color lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color darkFocusColor = Colors.white.withOpacity(0.12);

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 0, 191, 99),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 0, 125, 65),
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color.fromARGB(255, 222, 255, 239),
    onBackground: Colors.black,
    surface: Color.fromARGB(255, 126, 217, 87),
    onSurface: Colors.white,
    brightness: Brightness.light,
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 222, 255, 239),
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 126, 217, 87),
    onSecondary: Colors.black,
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color.fromARGB(255, 0, 125, 65),
    onBackground: Colors.white,
    surface: Color.fromARGB(255, 0, 191, 99),
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );

  static ThemeData lightThemeData = themeData(lightColorScheme, lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    final TextTheme textTheme = buildTextTheme(colorScheme);
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      textTheme: textTheme,
    );
  }

  static TextTheme buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Baloo2',
        fontSize: 75,
        fontWeight: FontWeight.w900,
        color: colorScheme.secondary,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Baloo2',
        fontSize: 40,
        fontWeight: FontWeight.w900,
        color: colorScheme.primary,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Baloo2',
        fontSize: 30,
        fontWeight: FontWeight.w900,
        color: colorScheme.secondary,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Baloo2',
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color: colorScheme.primary,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Baloo2',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.onBackground,
      ),
    );
  }
}
