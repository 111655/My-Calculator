import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData _theme({
    required Brightness brightness,
    required Color primary,
    required Color scaffold,
    required Color surface,
    required Color onSurface,
    required Color onPrimary,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: GoogleFonts.poppins().fontFamily,

      scaffoldBackgroundColor: scaffold,

      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primary,
        onPrimary: onPrimary,
        secondary: primary,
        onSecondary: onPrimary,
        error: Colors.red,
        onError: Colors.white,
        surface: surface,
        onSurface: onSurface,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: scaffold,
        foregroundColor: onSurface,
        centerTitle: true,
        elevation: 0,
      ),

      cardColor: surface,

      dividerColor: brightness == Brightness.dark
          ? Colors.white12
          : Colors.black12,

      iconTheme: IconThemeData(
        color: onSurface.withOpacity(.85),
      ),

      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: onSurface,
        displayColor: onSurface,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  /// Light
  static final ThemeData lightTheme = _theme(
    brightness: Brightness.light,
    primary: Colors.deepPurple,
    scaffold: Colors.grey.shade100,
    surface: Colors.white,
    onSurface: Colors.black87,
    onPrimary: Colors.white,
  );

  /// Dark
  static final ThemeData darkTheme = _theme(
    brightness: Brightness.dark,
    primary: const Color(0xFFB39DDB),
    scaffold: const Color(0xFF202124),
    surface: const Color(0xFF2B2D31),
    onSurface: Colors.white,
    onPrimary: Colors.black,
  );

  /// Blue
  static final ThemeData blueTheme = _theme(
    brightness: Brightness.light,
    primary: Colors.blue,
    scaffold: const Color(0xFFF4F8FF),
    surface: Colors.white,
    onSurface: Colors.black87,
    onPrimary: Colors.white,
  );

  /// Purple
  static final ThemeData purpleTheme = _theme(
    brightness: Brightness.light,
    primary: Colors.deepPurple,
    scaffold: const Color(0xFFF7F2FF),
    surface: Colors.white,
    onSurface: Colors.black87,
    onPrimary: Colors.white,
  );

  /// Green
  static final ThemeData greenTheme = _theme(
    brightness: Brightness.light,
    primary: Colors.green,
    scaffold: const Color(0xFFF2FFF5),
    surface: Colors.white,
    onSurface: Colors.black87,
    onPrimary: Colors.white,
  );

  /// AMOLED Black
  static final ThemeData amoledTheme = _theme(
    brightness: Brightness.dark,
    primary: Colors.cyanAccent,
    scaffold: Colors.black,
    surface: const Color(0xFF050505),
    onSurface: Colors.white,
    onPrimary: Colors.black,
  );
}