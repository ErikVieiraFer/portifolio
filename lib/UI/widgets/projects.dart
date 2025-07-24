import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_flutter/UI/widgets/hover_animated_title.dart';

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
            title: 'DaiAIlog',
            description:
                ' O app usa a API do Google Gemini para gerar perguntas personalizadas, projetadas para facilitar o networking em eventos',
            githubUrl: 'https://github.com/ErikVieiraFer/diailog',
            githubPagesUrl: 'https://erikvieirafer.github.io/diailog/',
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
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
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isHovering ? Colors.white12 : Colors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.pinkAccent.withAlpha((255 * 0.3).round()),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        transform: Matrix4.identity()..scale(_isHovering ? 1.02 : 1.0),
        transformAlignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap:
                  widget.githubUrl != null
                      ? () async {
                        final uri = Uri.parse(widget.githubUrl!);
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
              child: HoverAnimatedTitle(
                title: widget.title,
                isHovering: _isHovering,
                style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: widget.githubUrl != null
                      ? Colors.blueAccent
                      : Colors.cyanAccent,
                  decoration: widget.githubUrl != null
                      ? TextDecoration.underline
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: GoogleFonts.orbitron(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (widget.githubUrl != null) ...[
                  TextButton(
                    onPressed: () async {
                      final uri = Uri.parse(widget.githubUrl!);
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
                if (widget.githubPagesUrl != null) ...[
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () async {
                    final uri = Uri.parse(widget.githubPagesUrl!);
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
      ),
    );
  }
}
