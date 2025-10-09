import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_colors.dart';

class AppThemes {
  // Gera ThemeData baseado no tipo de tema
  static ThemeData getTheme(AppThemeType themeType) {
    final colors = themeType.colors;

    return ThemeData(
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      
      // Color scheme
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.cardBackground,
        error: Colors.redAccent,
        onPrimary: colors.textPrimary,
        onSecondary: colors.textPrimary,
        onSurface: colors.textPrimary,
        onError: colors.textPrimary,
      ),

      // Text theme
      textTheme: GoogleFonts.orbitronTextTheme(
        TextTheme(
          displayLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
          displaySmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
          headlineMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: colors.textSecondary,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: colors.textSecondary,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colors.textPrimary),
        titleTextStyle: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: colors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.border, width: 2),
        ),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.textPrimary,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.orbitron(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.textPrimary,
          side: BorderSide(color: colors.border, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.orbitron(fontSize: 16),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.border.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        labelStyle: TextStyle(color: colors.textSecondary),
        hintStyle: TextStyle(color: colors.textSecondary.withOpacity(0.5)),
      ),

      // FloatingActionButton theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.primary,
        foregroundColor: colors.textPrimary,
        elevation: 6,
      ),

      // Icon theme
      iconTheme: IconThemeData(color: colors.textSecondary),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: colors.border.withOpacity(0.3),
        thickness: 1,
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: colors.primary.withOpacity(0.2),
        selectedColor: colors.primary,
        labelStyle: GoogleFonts.orbitron(
          color: colors.textPrimary,
          fontSize: 12,
        ),
        side: BorderSide(color: colors.primary.withOpacity(0.5)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // SnackBar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.cardBackground,
        contentTextStyle: GoogleFonts.orbitron(color: colors.textPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: colors.border),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      useMaterial3: true,
    );
  }

  // Helper methods para cores específicas por tema
  static Color getPrimaryColor(AppThemeType type) => type.colors.primary;
  static Color getSecondaryColor(AppThemeType type) => type.colors.secondary;
  static Color getAccentColor(AppThemeType type) => type.colors.accent;
  static Color getBorderColor(AppThemeType type) => type.colors.border;
  static Color getGlowColor(AppThemeType type) => type.colors.glow;
  static Gradient getBackgroundGradient(AppThemeType type) => type.colors.backgroundGradient;
}