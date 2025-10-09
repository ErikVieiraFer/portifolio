import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_state.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() => _isExpanded = !_isExpanded);
  }

  void _selectTheme(AppThemeType theme) {
    context.read<ThemeCubit>().changeTheme(theme);
    setState(() => _isExpanded = false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: _toggleExpanded,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: state.currentTheme.colors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: state.currentTheme.colors.border,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: state.currentTheme.colors.glow,
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    state.currentTheme.icon,
                    color: state.currentTheme.colors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.currentTheme.displayName,
                    style: GoogleFonts.orbitron(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: state.currentTheme.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: state.currentTheme.colors.textSecondary,
                    size: 20,
                  ),
                  
                  // Menu expandido
                  if (_isExpanded) ...[
                    const SizedBox(width: 8),
                    Container(
                      width: 1,
                      height: 30,
                      color: state.currentTheme.colors.border.withOpacity(0.3),
                    ),
                    const SizedBox(width: 8),
                    ...AppThemeType.values
                        .where((theme) => theme != state.currentTheme)
                        .map((theme) => _buildThemeOption(theme, state)),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(AppThemeType theme, ThemeState currentState) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Tooltip(
        message: theme.displayName,
        child: InkWell(
          onTap: () => _selectTheme(theme),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: theme.colors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colors.primary.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Icon(
              theme.icon,
              color: theme.colors.primary,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}

// Versão alternativa: Menu dropdown (mais compacta para mobile)
class ThemeSwitcherDropdown extends StatelessWidget {
  const ThemeSwitcherDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return PopupMenuButton<AppThemeType>(
          icon: Icon(
            state.currentTheme.icon,
            color: state.currentTheme.colors.primary,
          ),
          tooltip: 'Trocar Tema',
          color: state.currentTheme.colors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: state.currentTheme.colors.border,
              width: 2,
            ),
          ),
          onSelected: (theme) {
            context.read<ThemeCubit>().changeTheme(theme);
          },
          itemBuilder: (context) {
            return AppThemeType.values.map((theme) {
              final isSelected = theme == state.currentTheme;
              return PopupMenuItem<AppThemeType>(
                value: theme,
                child: Row(
                  children: [
                    Icon(
                      theme.icon,
                      color: theme.colors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      theme.displayName,
                      style: GoogleFonts.orbitron(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: theme.colors.textPrimary,
                      ),
                    ),
                    if (isSelected) ...[
                      const Spacer(),
                      Icon(
                        Icons.check,
                        color: theme.colors.primary,
                        size: 18,
                      ),
                    ],
                  ],
                ),
              );
            }).toList();
          },
        );
      },
    );
  }
}