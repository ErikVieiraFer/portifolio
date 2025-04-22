import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.pinkAccent, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projetos',
            style: GoogleFonts.orbitron(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          ProjectCard(
            title: 'Calculadora de IMC',
            description:
                'App simples desenvolvido em Flutter para cálculo de IMC. Interface amigável e lógica bem estruturada.',
          ),
          const SizedBox(height: 16),
          ProjectCard(
            title: 'Gerenciador de Metas ENEM',
            description:
                'Sistema fullstack usando JHipster para cadastro de metas e acompanhamento de progresso de estudos.',
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String? githubUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    this.githubUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.orbitron(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.orbitron(fontSize: 14, color: Colors.white),
          ),
          if (githubUrl != null) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: () async {
                final uri = Uri.parse(githubUrl!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child: Text(
                'Ver no GitHub',
                style: GoogleFonts.orbitron(color: Colors.blueAccent),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
