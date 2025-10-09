import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = 'selected_theme';

  ThemeCubit() : super(const ThemeState()) {
    _loadSavedTheme();
  }

  /// Carrega o tema salvo do SharedPreferences
  Future<void> _loadSavedTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeIndex = prefs.getInt(_themeKey);
      
      if (savedThemeIndex != null) {
        final theme = AppThemeType.values[savedThemeIndex];
        emit(state.copyWith(currentTheme: theme));
      }
    } catch (e) {
      // Se falhar, mantém o tema padrão (Cyberpunk)
      print('Erro ao carregar tema: $e');
    }
  }

  /// Altera o tema atual
  Future<void> changeTheme(AppThemeType newTheme) async {
    emit(state.copyWith(currentTheme: newTheme));
    await _saveTheme(newTheme);
  }

  /// Salva o tema no SharedPreferences
  Future<void> _saveTheme(AppThemeType theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, theme.index);
    } catch (e) {
      print('Erro ao salvar tema: $e');
    }
  }

  /// Troca para o próximo tema na lista
  Future<void> cycleTheme() async {
    final currentIndex = state.currentTheme.index;
    final nextIndex = (currentIndex + 1) % AppThemeType.values.length;
    final nextTheme = AppThemeType.values[nextIndex];
    await changeTheme(nextTheme);
  }
}