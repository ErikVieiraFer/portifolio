// lib/ui/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.orbitronTextTheme(
      TextTheme(
        displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
      ),
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    useMaterial3: true,
  );
}
