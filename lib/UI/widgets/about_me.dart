import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/core/constants/app_colors.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovering ? 1.02 : 1.0),
        transformAlignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: _isHovering
              ? const Color.fromRGBO(20, 20, 20, 0.5)
              : AppColors.transparentBlack,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryPink, width: 2),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: AppColors.primaryPink.withAlpha(80),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sobre Mim', style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 12),
              Text(
                'Desenvolvedor com foco em Flutter e mentalidade full-stack. Minha paixão é transformar ideias em software de alta qualidade, aplicando princípios de Clean Architecture e S.O.L.I.D. para criar soluções robustas, escaláveis e de fácil manutenção. Uno a excelência técnica com uma forte disciplina de processos para entregar resultados que geram valor real.',
                style: GoogleFonts.orbitron(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
