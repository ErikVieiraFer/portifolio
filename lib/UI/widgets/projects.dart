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
        color: const Color.fromRGBO(0, 0, 0, 0.4),
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
            githubUrl: 'https://github.com/ErikVieiraFer/imc_state_manager',
            githubPagesUrl:
                'https://erikvieirafer.github.io/imc_state_manager/',
          ),
          const SizedBox(height: 16),
          ProjectCard(
            title: 'TechTaste',
            description:
                'Aplicativo Flutter para avaliação de restaurantes e pratos, com interface moderna e integração com mapas.',
            githubUrl: 'https://github.com/ErikVieiraFer/TechTaste',
            githubPagesUrl: 'https://erikvieirafer.github.io/TechTaste/',
          ),
          const SizedBox(height: 16),
          ProjectCard(
            title: 'ChessJoin',
            description:
                'Aplicativo em construção para partidas de xadrez online, com foco em jogabilidade colaborativa. Visualização indisponível.',
            githubUrl: 'https://github.com/igormidev/chessjoin',
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
  final String? githubPagesUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    this.githubUrl,
    this.githubPagesUrl,
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
          GestureDetector(
            onTap:
                githubUrl != null
                    ? () async {
                      final uri = Uri.parse(githubUrl!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Não foi possível abrir o link do GitHub',
                            ),
                          ),
                        );
                      }
                    }
                    : null,
            child: Text(
              title,
              style: GoogleFonts.orbitron(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    githubUrl != null ? Colors.blueAccent : Colors.cyanAccent,
                decoration: githubUrl != null ? TextDecoration.underline : null,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.orbitron(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (githubUrl != null) ...[
                TextButton(
                  onPressed: () async {
                    final uri = Uri.parse(githubUrl!);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Não foi possível abrir o link do GitHub',
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Ver no GitHub',
                    style: GoogleFonts.orbitron(color: Colors.blueAccent),
                  ),
                ),
              ],
              if (githubPagesUrl != null) ...[
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () async {
                    final uri = Uri.parse(githubPagesUrl!);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Não foi possível abrir o link do GitHub Pages',
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Ver Demo',
                    style: GoogleFonts.orbitron(color: Colors.blueAccent),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
