import 'package:equatable/equatable.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';

class ThemeState extends Equatable {
  final AppThemeType currentTheme;

  const ThemeState({
    this.currentTheme = AppThemeType.sunset, // MUDADO de cyberpunk
  });

  @override
  List<Object> get props => [currentTheme];

  ThemeState copyWith({
    AppThemeType? currentTheme,
  }) {
    return ThemeState(
      currentTheme: currentTheme ?? this.currentTheme,
    );
  }
}