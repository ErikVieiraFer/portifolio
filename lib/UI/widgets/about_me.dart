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
            'Estou começando minha carreira como desenvolvedor, com foco na criação de aplicativos com Flutter e no desenvolvimento web utilizando HTML, CSS e JavaScript. Tenho experiência inicial com C# e estou constantemente buscando aprimorar minhas habilidades por meio da construção de novos projetos e da prática contínua. Meu objetivo é ganhar experiência no mercado e evoluir profissionalmente.',
            style: GoogleFonts.orbitron(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
