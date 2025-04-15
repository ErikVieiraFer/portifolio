import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF8A2BE2), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sobre Mim',
            style: GoogleFonts.orbitron(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Sou apaixonado por tecnologia e desenvolvimento mobile. Gosto de criar interfaces bonitas e funcionais, com atenção aos detalhes. Atualmente estou focado em projetos com Flutter, sempre buscando aprender e evoluir como desenvolvedor.',
            style: GoogleFonts.orbitron(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
