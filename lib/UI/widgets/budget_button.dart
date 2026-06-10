import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/core/constants/app_strings.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';
import 'package:portfolio_flutter/infra/cubit/budget/budget_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_state.dart';
import 'package:portfolio_flutter/UI/widgets/budget_form_modal.dart';

class BudgetButton extends StatefulWidget {
  const BudgetButton({super.key});

  @override
  State<BudgetButton> createState() => _BudgetButtonState();
}

class _BudgetButtonState extends State<BudgetButton> {
  bool _isHovering = false;

  void _openBudgetForm() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BlocProvider(
        create: (_) => BudgetCubit(),
        child: const BudgetFormModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final colors = ThemeColors.fromType(themeState.currentTheme);
        final isMobile = MediaQuery.of(context).size.width < 600;

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: Transform.translate(
            offset: const Offset(0, -30),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(
                top: 0,
                bottom: 60,
                left: isMobile ? 16 : 80,
                right: isMobile ? 16 : 80,
              ),
            padding: EdgeInsets.all(isMobile ? 32 : 48),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.primary,
                  colors.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: _isHovering ? colors.glow : colors.primary.withAlpha(127),
                  blurRadius: _isHovering ? 40 : 25,
                  spreadRadius: _isHovering ? 8 : 3,
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.rocket_launch,
                  size: isMobile ? 48 : 64,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  'PRONTO PARA COMEÇAR?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.orbitron(
                    fontSize: isMobile ? 24 : 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Transforme sua ideia em realidade',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.orbitron(
                    fontSize: isMobile ? 14 : 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _openBudgetForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: colors.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 40 : 60,
                      vertical: isMobile ? 20 : 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppStrings.budgetButton.toUpperCase(),
                          style: GoogleFonts.orbitron(
                            fontSize: isMobile ? 14 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.arrow_forward, size: isMobile ? 20 : 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),
        );
      },
    );
  }
}