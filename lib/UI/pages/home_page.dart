import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_flutter/UI/widgets/about_me.dart';
import 'package:portfolio_flutter/UI/widgets/contacts.dart';
import 'package:portfolio_flutter/UI/widgets/header.dart';
import 'package:portfolio_flutter/UI/widgets/projects_carousel.dart';
import 'package:portfolio_flutter/UI/widgets/budget_button.dart';
import 'package:portfolio_flutter/UI/widgets/tech_carousel.dart';
import 'package:portfolio_flutter/UI/widgets/theme_switcher.dart';
import 'package:portfolio_flutter/UI/widgets/particle_background.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_state.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AutoScrollController _scrollController = AutoScrollController();
  bool _showBackToTop = false;
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final showButton = _scrollController.offset > 400;
      if (showButton != _showBackToTop) {
        setState(() => _showBackToTop = showButton);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final colors = ThemeColors.fromType(themeState.currentTheme);
        return Scaffold(
          backgroundColor: colors.background, // Cor de fundo base
          body: Stack(
            children: [
              // CAMADA 1: Gradiente de Fundo
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: colors.backgroundGradient,
                  ),
                ),
              ),
              // CAMADA 2: Partículas
              const Positioned.fill(
                child: ParticleBackground(),
              ),
              // CAMADA 3: Mouse Region para capturar movimento
              Positioned.fill(
                child: MouseRegion(
                  onHover: (event) {
                    setState(() {
                      _mousePosition = event.position;
                    });
                  },
                  child: const SizedBox.expand(),
                ),
              ),
              // CAMADA 4: Blur que segue o mouse (página inteira)
              if (_mousePosition != Offset.zero)
                Positioned(
                  left: _mousePosition.dx - 150,
                  top: _mousePosition.dy - 150,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          colors.secondary.withAlpha(38),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              // CAMADA 5: Conteúdo Rolável
              SingleChildScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    // 1. HERO - Personagem + Nome
                    Header(scrollController: _scrollController),

                    // PADDING MAIOR antes dos projetos
                    const SizedBox(height: 80),

                    // 2. PROJETOS - Carrossel de Smartphones
                    AutoScrollTag(
                      key: const ValueKey(1),
                      controller: _scrollController,
                      index: 1,
                      child: const ProjectsCarousel(),
                    ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

                    // PADDING MAIOR depois dos projetos
                    const SizedBox(height: 80),

                    // 3. SOBRE MIM - Texto + Imagem Lateral
                    const AboutMe().animate().fadeIn(duration: 600.ms, delay: 400.ms),

                    // 4. SOLICITAR ORÇAMENTO - Card CTA Grande
                    const BudgetButton().animate().fadeIn(duration: 600.ms, delay: 200.ms),

                    // 5. CARROSSEL DE TECNOLOGIAS - Infinito
                    const TechCarousel(),

                    // 6. CONTATO - Imagem + Informações
                    const Contacts().animate().fadeIn(duration: 600.ms, delay: 200.ms),

                    // Espaçamento final
                    const SizedBox(height: 60),
                  ],
                ),
              ),
              // CAMADA 6: Botão de Tema Flutuante (Canto Superior Direito)
              Positioned(
                top: 20,
                right: 20,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(200), // Mais opaco
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colors.border,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colors.glow,
                          blurRadius: 20,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: const ThemeSwitcherDropdown(),
                  ),
                ),
              ),
              // CAMADA 7: Botão Voltar ao Topo (Canto Inferior Direito)
              if (_showBackToTop)
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: () => _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    ),
                    backgroundColor: colors.primary,
                    child: const Icon(Icons.arrow_upward, color: Colors.white),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
