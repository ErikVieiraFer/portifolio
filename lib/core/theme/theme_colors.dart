import 'package:flutter/material.dart';

enum AppThemeType {
  cyberpunk,
  matrix,
  sunset,
  ocean,
}

class ThemeColors {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color backgroundSecondary;
  final Color cardBackground;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color glow;
  final Gradient backgroundGradient;

  const ThemeColors({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.backgroundSecondary,
    required this.cardBackground,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.glow,
    required this.backgroundGradient,
  });

  // Tema Cyberpunk (atual - rosa/cyan)
  static const cyberpunk = ThemeColors(
    primary: Color(0xFFFF4081), // Rosa neon
    secondary: Color(0xFF00E5FF), // Cyan
    accent: Color(0xFFFFEB3B), // Amarelo
    background: Color(0xFF000000),
    backgroundSecondary: Color(0xFF0A0A0A),
    cardBackground: Color(0x66000000), // transparentBlack
    textPrimary: Colors.white,
    textSecondary: Color(0xB3FFFFFF), // white70
    border: Color(0xFFFF4081),
    glow: Color(0x80FF4081),
    backgroundGradient: RadialGradient(
      colors: [
        Color(0xBA3A013F), // Color.fromARGB(186, 58, 1, 63)
        Color(0xC5000000), // Color.fromARGB(197, 0, 0, 0)
      ],
      stops: [0.1, 1.0],
      center: Alignment.topLeft,
      radius: 1.5,
    ),
  );

  // Tema Matrix (verde neon/preto)
  static const matrix = ThemeColors(
    primary: Color(0xFF00FF41), // Verde Matrix
    secondary: Color(0xFF39FF14), // Verde limão neon
    accent: Color(0xFF00FF41),
    background: Color(0xFF000000),
    backgroundSecondary: Color(0xFF001A00),
    cardBackground: Color(0x66000000),
    textPrimary: Color(0xFF00FF41),
    textSecondary: Color(0xB300FF41),
    border: Color(0xFF00FF41),
    glow: Color(0x8000FF41),
    backgroundGradient: RadialGradient(
      colors: [
        Color(0xBA003300), // Verde escuro
        Color(0xC5000000),
      ],
      stops: [0.1, 1.0],
      center: Alignment.topLeft,
      radius: 1.5,
    ),
  );

  // Tema Sunset (laranja/roxo)
  static const sunset = ThemeColors(
    primary: Color(0xFFFF6B35), // Laranja vibrante
    secondary: Color(0xFF9B51E0), // Roxo
    accent: Color(0xFFFFD23F), // Dourado
    background: Color(0xFF0A0A0A),
    backgroundSecondary: Color(0xFF1A0A0F),
    cardBackground: Color(0x66000000),
    textPrimary: Colors.white,
    textSecondary: Color(0xB3FFFFFF),
    border: Color(0xFFFF6B35),
    glow: Color(0x80FF6B35),
    backgroundGradient: RadialGradient(
      colors: [
        Color(0xBA4A1142), // Roxo escuro
        Color(0xC5000000),
      ],
      stops: [0.1, 1.0],
      center: Alignment.topLeft,
      radius: 1.5,
    ),
  );

  // Tema Ocean (azul profundo/turquesa)
  static const ocean = ThemeColors(
    primary: Color(0xFF00D9FF), // Turquesa
    secondary: Color(0xFF0077BE), // Azul profundo
    accent: Color(0xFF7FDBFF), // Azul claro
    background: Color(0xFF000814),
    backgroundSecondary: Color(0xFF001D3D),
    cardBackground: Color(0x66000814),
    textPrimary: Colors.white,
    textSecondary: Color(0xB3FFFFFF),
    border: Color(0xFF00D9FF),
    glow: Color(0x8000D9FF),
    backgroundGradient: RadialGradient(
      colors: [
        Color(0xBA001D3D), // Azul profundo
        Color(0xC5000814),
      ],
      stops: [0.1, 1.0],
      center: Alignment.topLeft,
      radius: 1.5,
    ),
  );

  // Helper para obter cores por tipo
  static ThemeColors fromType(AppThemeType type) {
    switch (type) {
      case AppThemeType.cyberpunk:
        return cyberpunk;
      case AppThemeType.matrix:
        return matrix;
      case AppThemeType.sunset:
        return sunset;
      case AppThemeType.ocean:
        return ocean;
    }
  }
}

// Extension para facilitar o uso
extension AppThemeTypeExtension on AppThemeType {
  String get displayName {
    switch (this) {
      case AppThemeType.cyberpunk:
        return 'Cyberpunk';
      case AppThemeType.matrix:
        return 'Matrix';
      case AppThemeType.sunset:
        return 'Sunset';
      case AppThemeType.ocean:
        return 'Ocean';
    }
  }

  IconData get icon {
    switch (this) {
      case AppThemeType.cyberpunk:
        return Icons.psychology; // Cérebro tech
      case AppThemeType.matrix:
        return Icons.code; // Código
      case AppThemeType.sunset:
        return Icons.wb_twilight; // Pôr do sol
      case AppThemeType.ocean:
        return Icons.waves; // Ondas
    }
  }

  ThemeColors get colors => ThemeColors.fromType(this);
}