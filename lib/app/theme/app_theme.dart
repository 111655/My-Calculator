import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.deepPurple,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF202124),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFB39DDB),
      secondary: Color(0xFFD1C4E9),
      surface: Color(0xFF2B2D31),
      onSurface: Colors.white,
      onPrimary: Colors.black,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF202124),
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
    ),

    cardColor: const Color(0xFF2B2D31),

    dividerColor: Colors.white12,

    iconTheme: const IconThemeData(
      color: Colors.white70,
    ),

    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ),
  );
}