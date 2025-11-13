import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:portfolio_flutter/core/constants/app_strings.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_state.dart';

class Header extends StatefulWidget {
  final AutoScrollController scrollController;
  const Header({super.key, required this.scrollController});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final colors = ThemeColors.fromType(themeState.currentTheme);
        final size = MediaQuery.of(context).size;
        final isMobile = size.width < 600;

        return Container(
          height: isMobile ? 500 : 650,
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60),
          child: isMobile ? _buildMobileLayout(colors, isMobile) : _buildDesktopLayout(colors, isMobile),
        );
      },
    );
  }

  Widget _buildMobileLayout(colors, bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCharacterImage(colors, isMobile),
        const SizedBox(height: 30),
        _buildNameSection(colors, isMobile),
      ],
    );
  }

  Widget _buildDesktopLayout(colors, bool isMobile) {
    return Row(
      children: [
        // PERSONAGEM (esquerda) - MENOR e mais à esquerda
        Expanded(
          flex: 3,
          child: Stack(
            alignment: Alignment.centerLeft, // Alinha à esquerda
            children: [
              // Blur MENOR e concentrado
              Positioned(
                left: isMobile ? 50 : 150, // AJUSTADO
                child: Container(
                  width: 400, // MENOR (era 550)
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colors.glow,
                        blurRadius: 60, // MENOR (era 80)
                        spreadRadius: 15, // MENOR (era 30)
                      ),
                    ],
                  ),
                ),
              ),
              // Imagem mais à direita
              Positioned(
                left: isMobile ? 30 : 120, // AJUSTADO (era 0)
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'assets/images/hero_character.png',
                    height: 550, // MENOR (era 600)
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 550,
                        decoration: BoxDecoration(
                          color: colors.cardBackground,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: colors.border, width: 2),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 300,
                          color: colors.primary,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ).animate()
              .fadeIn(duration: 800.ms)
              .slideX(begin: -0.3, end: 0, duration: 800.ms),
        ),
        const SizedBox(width: 40),
        // NOME + BOTÃO (direita) - MAIS ESPAÇO
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome com animação de digitação
              DefaultTextStyle(
                style: GoogleFonts.orbitron(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: colors.accent,
                  shadows: [
                    Shadow(
                      color: colors.glow,
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  isRepeatingAnimation: true, // Loop infinito
                  repeatForever: true,
                  pause: const Duration(milliseconds: 2000),
                  animatedTexts: [
                    TypewriterAnimatedText(
                      AppStrings.developerName,
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Subtítulo
              Text(
                AppStrings.developerTitle,
                style: GoogleFonts.orbitron(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: colors.secondary,
                  letterSpacing: 2,
                ),
              ),
            ],
          ).animate()
              .fadeIn(duration: 800.ms, delay: 300.ms)
              .slideX(begin: 0.3, end: 0, duration: 800.ms),
        ),
      ],
    );
  }

  Widget _buildCharacterImage(colors, bool isMobile) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Blur concentrado no personagem
        Container(
          width: isMobile ? 350 : 550,
          height: isMobile ? 350 : 550,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colors.glow,
                blurRadius: 80,
                spreadRadius: 30,
              ),
            ],
          ),
        ),
        // Imagem com cantos arredondados
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            'assets/images/hero_character.png',
            height: isMobile ? 400 : 600,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: isMobile ? 400 : 600,
                decoration: BoxDecoration(
                  color: colors.cardBackground,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: colors.border, width: 2),
                ),
                child: Icon(
                  Icons.person,
                  size: isMobile ? 150 : 300,
                  color: colors.primary,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNameSection(colors, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: GoogleFonts.orbitron(
            fontSize: isMobile ? 32 : 56,
            fontWeight: FontWeight.bold,
            color: colors.accent,
            shadows: [
              Shadow(
                color: colors.glow,
                blurRadius: 20,
              ),
            ],
          ),
          child: AnimatedTextKit(
            isRepeatingAnimation: true, // Loop infinito
            repeatForever: true,
            pause: const Duration(milliseconds: 2000),
            animatedTexts: [
              TypewriterAnimatedText(
                AppStrings.developerName,
                speed: const Duration(milliseconds: 100),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.developerTitle,
          style: GoogleFonts.orbitron(
            fontSize: isMobile ? 16 : 24,
            fontWeight: FontWeight.w600,
            color: colors.secondary,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

}