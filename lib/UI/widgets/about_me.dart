import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/core/constants/app_strings.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_state.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final colors = ThemeColors.fromType(themeState.currentTheme);
        final isMobile = MediaQuery.of(context).size.width < 600;

        return Container(
          margin: EdgeInsets.only(
            top: 120,
            bottom: 0,
            left: isMobile ? 16 : 80,
            right: isMobile ? 16 : 80,
          ),
          child: isMobile
              ? Column(
                  children: [
                    _buildTextSection(colors, isMobile),
                    const SizedBox(height: 20),
                    _buildImageSection(colors, isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinha no topo
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildTextSection(colors, isMobile),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 1,
                      child: Transform.translate(
                        offset: const Offset(30, -200), // Mais acima
                        child: _buildImageSection(colors, isMobile),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildTextSection(colors, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border, width: 2),
        boxShadow: [
          BoxShadow(color: colors.glow, blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SOBRE MIM',
            style: GoogleFonts.orbitron(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.aboutMeDescription,
            style: GoogleFonts.orbitron(
              fontSize: isMobile ? 14 : 16,
              color: colors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(colors, bool isMobile) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(0, 50),
          child: Container(
            width: isMobile ? 400 : 400,
            height: isMobile ? 450 : 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colors.glow,
                  blurRadius: 60,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => RadialGradient(
            center: Alignment.center,
            radius: 0.85,
            colors: [
              Colors.white,
              Colors.white,
              Colors.white.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.7, 1.0],
          ).createShader(bounds),
          blendMode: BlendMode.dstIn,
          child: SizedBox(
            width: isMobile ? 400 : 450,
            height: isMobile ? 450 : 550,
            child: Image.asset(
              'assets/images/about_character.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colors.border, width: 2),
                  ),
                  child: Icon(
                    Icons.person,
                    size: isMobile ? 100 : 150,
                    color: colors.primary,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}