import 'dart:async';
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
  Offset _mousePosition = Offset.zero;

  Future<void> _scrollToProjects() async {
    await widget.scrollController.scrollToIndex(
      1,
      duration: const Duration(milliseconds: 800),
      preferPosition: AutoScrollPosition.begin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final colors = ThemeColors.fromType(themeState.currentTheme);
        final size = MediaQuery.of(context).size;
        final isMobile = size.width < 600;

        return MouseRegion(
          onHover: (event) {
            setState(() => _mousePosition = event.position);
          },
          child: Container(
            height: isMobile ? 500 : 700,
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
            child: Stack(
              children: [
                // Blur que segue o mouse (apenas desktop)
                if (!isMobile)
                  Positioned(
                    left: _mousePosition.dx - 150,
                    top: _mousePosition.dy - 150,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            colors.secondary.withAlpha(38),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                // Layout principal
                isMobile ? _buildMobileLayout(colors, isMobile) : _buildDesktopLayout(colors, isMobile),
              ],
            ),
          ),
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
        const SizedBox(height: 20),
        _buildScrollButton(colors),
      ],
    );
  }

  Widget _buildDesktopLayout(colors, bool isMobile) {
    return Row(
      children: [
        // PERSONAGEM (esquerda) - MAIOR
        Expanded(
          flex: 2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Blur concentrado no personagem
              Container(
                width: 550,
                height: 550,
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
                  height: 600,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 600,
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
            ],
          ).animate()
              .fadeIn(duration: 800.ms)
              .slideX(begin: -0.3, end: 0, duration: 800.ms),
        ),
        const SizedBox(width: 80),
        // NOME + BOTÃO (direita)
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome com animação de digitação
              SizedBox(
                width: 500,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      AppStrings.developerName,
                      textStyle: GoogleFonts.orbitron(
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
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  isRepeatingAnimation: false, // Só uma vez
                  pause: const Duration(milliseconds: 500),
                ),
              ),
              const SizedBox(height: 20),
              // Subtítulo
              Text(
                AppStrings.developerTitle,
                style: GoogleFonts.orbitron(
                  fontSize: 24,
                  fontWeight: FontWeight.w600, // Mais grosso
                  color: colors.secondary,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 60),
              // Botão scroll centralizado
              Center(
                child: _buildScrollButton(colors),
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
        SizedBox(
          width: isMobile ? 300 : 500,
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                AppStrings.developerName,
                textStyle: GoogleFonts.orbitron(
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
                speed: const Duration(milliseconds: 100),
              ),
            ],
            isRepeatingAnimation: false, // Só uma vez
            pause: const Duration(milliseconds: 500),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.developerTitle,
          style: GoogleFonts.orbitron(
            fontSize: isMobile ? 16 : 24,
            fontWeight: FontWeight.w600,
            color: colors.secondary,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildScrollButton(colors) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _scrollToProjects,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent, // Garantir transparência
            border: Border.all(color: colors.accent, width: 3),
            boxShadow: [
              BoxShadow(
                color: colors.accent.withAlpha(127),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.keyboard_arrow_down,
              color: colors.accent,
              size: 36,
            ),
          ),
        ).animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        ).moveY(
          begin: 0,
          end: 10,
          duration: 1500.ms,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}