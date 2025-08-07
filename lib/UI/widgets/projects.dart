import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Project {
  final String title;
  final String description;
  final String imagePath;
  final String? githubUrl;
  final String? demoUrl;
  final bool isDraft;

  Project({
    required this.title,
    required this.description,
    required this.imagePath,
    this.githubUrl,
    this.demoUrl,
    this.isDraft = false,
  });
}

final projectsList = [
  Project(
    title: 'TechTaste',
    description:
        'Aplicativo Flutter para avaliação de restaurantes e pratos, com interface moderna e integração com mapas.',
    imagePath: 'assets/images/projects/techtaste.jpeg',
    githubUrl: 'https://github.com/ErikVieiraFer/TechTaste',
    demoUrl: 'https://erikvieirafer.github.io/TechTaste/',
  ),
  Project(
    title: 'DaiAIlog',
    description:
        'O app usa a API do Google Gemini para gerar perguntas personalizadas, projetadas para facilitar o networking em eventos.',
    imagePath: 'assets/images/projects/diailog.jpeg',
    githubUrl: 'https://github.com/ErikVieiraFer/diailog',
    demoUrl: 'https://erikvieirafer.github.io/diailog/',
  ),
  Project(
    title: 'Calculadora de IMC',
    description:
        'App simples desenvolvido em Flutter para cálculo de IMC. Interface amigável e lógica bem estruturada.',
    imagePath: 'assets/images/projects/bmicalculator.jpeg',
    githubUrl: 'https://github.com/ErikVieiraFer/imc_state_manager',
    demoUrl: 'https://erikvieirafer.github.io/imc_state_manager/',
  ),
  Project(
    title: 'Site do Grupo Resiliência',
    description:
        'Site institucional para o Grupo Resiliência, que oferece apoio e orientação a famílias, conectando dependentes químicos à clínica de reabilitação ideal para sua jornada de recuperação e superação.',
    imagePath: 'assets/images/projects/site-resiliencia.jpeg',
    demoUrl: 'https://fsresiliencia.com.br/',
  ),
  Project(
    title: 'EasyWheight',
    description:
        'Aplicativo de controle de estoque desenvolvido para a Conquant Inteligencia Economica,  Permite o registo de produtos offline, com captura automática das informações dos produtos via balanças Bluetooth. Os dados são sincronizados com um servidor central (Python/Django) quando online, garantindo controlo total do estoque.',
    imagePath: 'assets/images/projects/easyweigh.jpeg',
    isDraft: true,
  ),
];

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
          const SizedBox(height: 24),
          Center(
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: projectsList
                  .map((project) => ProjectCard(project: project))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

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
        width: 380,
        height: _isHovering ? 420 : 400,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.pinkAccent.withAlpha((255 * 0.4).round()),
                    blurRadius: 12,
                    spreadRadius: 4,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      color: Colors.black,
                      child: Image.asset(
                        widget.project.imagePath,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _isHovering ? 1.0 : 0.0,
                      child: Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.75),
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.project.isDraft)
                              Chip(
                                label: Text(
                                  'Em desenvolvimento',
                                  style: GoogleFonts.orbitron(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor:
                                    Colors.pinkAccent.withOpacity(0.8),
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.project.demoUrl != null)
                                    ElevatedButton(
                                      onPressed: () =>
                                          _launchUrl(widget.project.demoUrl!),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pinkAccent,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text('Demo'),
                                    ),
                                  if (widget.project.githubUrl != null &&
                                      widget.project.demoUrl != null)
                                    const SizedBox(width: 12),
                                  if (widget.project.githubUrl != null)
                                    ElevatedButton.icon(
                                      onPressed: () => _launchUrl(
                                          widget.project.githubUrl!),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        foregroundColor: Colors.white,
                                      ),
                                      icon: const Icon(FontAwesomeIcons.github,
                                          size: 16),
                                      label: const Text('Github'),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.title,
                    style: GoogleFonts.orbitron(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      widget.project.description,
                      style: GoogleFonts.orbitron(
                          fontSize: 14, color: Colors.white70),
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível abrir o link: $url')),
        );
      }
    }
  }
}