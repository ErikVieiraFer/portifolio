import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/core/constants/app_colors.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.transparentBlack,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryPink, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sobre Mim', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 12),
          Text(
            'Olá! Sou um desenvolvedor apaixonado por criar soluções elegantes e eficientes com Flutter. Tenho experiência em construir aplicativos móveis do zero, focando em uma arquitetura limpa e uma ótima experiência de usuário.',
            style: GoogleFonts.orbitron(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
