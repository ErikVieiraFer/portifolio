import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool _isHovering = false;

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

        return Container(
          height: isMobile ? 500 : 700,
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
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
        const SizedBox(height: 20),
        _buildScrollButton(colors),
      ],
    );
  }

  Widget _buildDesktopLayout(colors, bool isMobile) {
    return Row(
      children: [
        // PERSONAGEM (esquerda)
        Expanded(
          flex: 2,
          child: _buildCharacterImage(colors, isMobile)
              .animate()
              .fadeIn(duration: 800.ms)
              .slideX(begin: -0.3, end: 0, duration: 800.ms, curve: Curves.easeOut),
        ),
        SizedBox(width: isMobile ? 20 : 60),
        // NOME (direita)
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameSection(colors, isMobile),
              const SizedBox(height: 40),
              _buildScrollButton(colors),
            ],
          ).animate()
              .fadeIn(duration: 800.ms, delay: 300.ms)
              .slideX(begin: 0.3, end: 0, duration: 800.ms, curve: Curves.easeOut),
        ),
      ],
    );
  }

  Widget _buildCharacterImage(colors, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: colors.glow,
            blurRadius: 50,
            spreadRadius: 20,
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/hero_character.png',
        height: isMobile ? 300 : 500,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: isMobile ? 300 : 500,
            decoration: BoxDecoration(
              color: colors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.border, width: 2),
            ),
            child: Icon(
              Icons.person,
              size: isMobile ? 150 : 250,
              color: colors.primary,
            ),
          );
        },
      ),
    );
  }

  Widget _buildNameSection(colors, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.developerName,
          style: GoogleFonts.orbitron(
            fontSize: isMobile ? 28 : 48,
            fontWeight: FontWeight.bold,
            color: colors.accent,
            shadows: [
              Shadow(color: colors.glow, blurRadius: 20),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.developerTitle,
          style: GoogleFonts.orbitron(
            fontSize: isMobile ? 14 : 20,
            color: colors.secondary,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildScrollButton(colors) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: _scrollToProjects,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isHovering ? colors.accent : Colors.transparent,
            border: Border.all(color: colors.accent, width: 2),
            shape: BoxShape.circle,
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: colors.glow,
                      blurRadius: 20,
                      spreadRadius: 3,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            Icons.arrow_downward,
            color: _isHovering ? Colors.black : Colors.white,
            size: 32,
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .moveY(begin: 0, end: 10, duration: 1500.ms, curve: Curves.easeInOut)
            .then()
            .moveY(begin: 10, end: 0, duration: 1500.ms, curve: Curves.easeInOut),
      ),
    );
  }
}