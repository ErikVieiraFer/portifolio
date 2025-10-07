import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_flutter/core/constants/app_strings.dart';

class Project {
  final String title;
  final String description;
  final String imagePath;
  final String? githubUrl;
  final String? demoUrl;
  final bool isDraft;
  final List<String> techs;

  Project({
    required this.title,
    required this.description,
    required this.imagePath,
    this.githubUrl,
    this.demoUrl,
    this.isDraft = false,
    this.techs = const [],
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
    techs: ['Flutter', 'Google Maps', 'Firebase', 'BLoC'],
  ),
  Project(
    title: 'DaiAIlog',
    description:
        'O app usa a API do Google Gemini para gerar perguntas personalizadas, projetadas para facilitar o networking em eventos.',
    imagePath: 'assets/images/projects/diailog.jpeg',
    githubUrl: 'https://github.com/ErikVieiraFer/diailog',
    demoUrl: 'https://erikvieirafer.github.io/diailog/',
    techs: ['Flutter', 'Gemini AI', 'Material Design'],
  ),
  Project(
    title: 'Calculadora de IMC',
    description:
        'App simples desenvolvido em Flutter para cálculo de IMC. Interface amigável e lógica bem estruturada.',
    imagePath: 'assets/images/projects/bmicalculator.jpeg',
    githubUrl: 'https://github.com/ErikVieiraFer/imc_state_manager',
    demoUrl: 'https://erikvieirafer.github.io/imc_state_manager/',
    techs: ['Flutter', 'State Management', 'Responsive'],
  ),
  Project(
    title: 'Site do Grupo Resiliência',
    description:
        'Site institucional para o Grupo Resiliência, que oferece apoio e orientação a famílias, conectando dependentes químicos à clínica de reabilitação ideal para sua jornada de recuperação e superação.',
    imagePath: 'assets/images/projects/site-resiliencia.jpeg',
    demoUrl: 'https://fsresiliencia.com.br/',
    techs: ['HTML', 'CSS', 'JavaScript'],
  ),
  Project(
    title: 'EasyWheight',
    description:
        'Aplicativo de controle de estoque desenvolvido para a Conquant Inteligencia Economica,  Permite o registo de produtos offline, com captura automática das informações dos produtos via balanças Bluetooth. Os dados são sincronizados com um servidor central (Python/Django) quando online, garantindo controlo total do estoque.',
    imagePath: 'assets/images/projects/easyweigh.jpeg',
    isDraft: true,
    techs: ['Flutter', 'Python', 'Django', 'Bluetooth', 'SQLite'],
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
            AppStrings.projectsTitle,
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
  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        width: 380,
        height: _isHovering ? 450 : 430,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovering ? Colors.pinkAccent : Colors.white24,
            width: _isHovering ? 2 : 1,
          ),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.pinkAccent.withAlpha((255 * 0.4).round()),
                    blurRadius: 20,
                    spreadRadius: 4,
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
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
                        frameBuilder: (context, child, frame,
                            wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            _imageLoaded = true;
                            return child;
                          }
                          if (frame != null && !_imageLoaded) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                setState(() => _imageLoaded = true);
                              }
                            });
                          }
                          return Stack(
                            children: [
                              child,
                              if (!_imageLoaded)
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _isHovering ? 1.0 : 0.0,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.85),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.project.isDraft)
                              Chip(
                                label: Text(
                                  AppStrings.inDevelopment,
                                  style: GoogleFonts.orbitron(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor:
                                    Colors.pinkAccent.withOpacity(0.8),
                              )
                            else
                              Wrap(
                                spacing: 12,
                                runSpacing: 8,
                                alignment: WrapAlignment.center,
                                children: [
                                  if (widget.project.demoUrl != null)
                                    ElevatedButton.icon(
                                      onPressed: () =>
                                          _launchUrl(widget.project.demoUrl!),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pinkAccent,
                                        foregroundColor: Colors.white,
                                        elevation: 5,
                                        shadowColor:
                                            Colors.pinkAccent.withOpacity(0.5),
                                      ),
                                      icon: const Icon(Icons.launch, size: 16),
                                      label: Text(AppStrings.demoButton),
                                    ),
                                  if (widget.project.githubUrl != null)
                                    ElevatedButton.icon(
                                      onPressed: () => _launchUrl(
                                          widget.project.githubUrl!),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent,
                                        foregroundColor: Colors.white,
                                        elevation: 5,
                                        shadowColor:
                                            Colors.blueAccent.withOpacity(0.5),
                                      ),
                                      icon: const Icon(FontAwesomeIcons.github,
                                          size: 16),
                                      label: Text(AppStrings.githubButton),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badges de tecnologias
                    if (widget.project.techs.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: widget.project.techs
                              .map(
                                (tech) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.cyan.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: Colors.cyan.withOpacity(0.5)),
                                  ),
                                  child: Text(
                                    tech,
                                    style: GoogleFonts.orbitron(
                                      fontSize: 10,
                                      color: Colors.cyanAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
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
          SnackBar(
            content: Text('Não foi possível abrir o link: $url'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}