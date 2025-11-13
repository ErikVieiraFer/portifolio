import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio_flutter/UI/widgets/about_me.dart';
import 'package:portfolio_flutter/UI/widgets/contacts.dart';
import 'package:portfolio_flutter/UI/widgets/curriculum_button.dart';
import 'package:portfolio_flutter/UI/widgets/header.dart';
import 'package:portfolio_flutter/UI/widgets/languages_widget.dart';
import 'package:portfolio_flutter/UI/widgets/projects_carousel.dart';
import 'package:portfolio_flutter/UI/widgets/budget_button.dart';
import 'package:portfolio_flutter/UI/widgets/theme_switcher.dart';
import 'package:portfolio_flutter/UI/widgets/particle_background.dart';
import 'package:portfolio_flutter/UI/widgets/spotlight_effect.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/languages/languages_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_state.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AutoScrollController _scrollController = AutoScrollController();
  bool _showBackToTop = false;

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
        final colors = themeState.currentTheme.colors;
        return Scaffold(
          backgroundColor: colors.background, // Cor de fundo base
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: const [
              ThemeSwitcherDropdown(),
              SizedBox(width: 8),
            ],
          ),
          floatingActionButton: _showBackToTop
              ? FloatingActionButton(
                  onPressed: () => _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                  ),
                  backgroundColor: colors.primary,
                  child: const Icon(Icons.arrow_upward, color: Colors.white),
                )
              : null,
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
              // CAMADA 3: Efeito de Luz do Mouse
              const Positioned.fill(
                child: SpotlightEffect(),
              ),
              // CAMADA 4: Conteúdo Rolável
              SingleChildScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    // SafeArea para o Header para não ficar sob a status bar
                    SafeArea(
                      bottom: false, // Apenas no topo
                      child: Header(scrollController: _scrollController),
                    ),
                    AutoScrollTag(
                      key: const ValueKey(1),
                      controller: _scrollController,
                      index: 1,
                      child: const ProjectsCarousel().animate().fade(
                            duration: 600.ms,
                            delay: 200.ms,
                          ).slide(begin: const Offset(0, 0.2)),
                    ),
                    const BudgetButton().animate().fade(
                          duration: 600.ms,
                          delay: 300.ms,
                        ).scaleXY(begin: 0.8, end: 1.0),
                    const AboutMe().animate().fade(
                          duration: 600.ms,
                          delay: 400.ms,
                        ).slide(begin: const Offset(-0.2, 0)),
                    MultiBlocProvider(
                      providers: [BlocProvider(create: (_) => LanguagesCubit())],
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: LanguagesWidget(),
                      ).animate().fade(
                            duration: 600.ms,
                            delay: 200.ms,
                          ).slide(begin: const Offset(0, 0.2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BlocProvider(
                        create: (_) => CurriculumCubit(),
                        child: const CurriculumButton(),
                      ).animate().fade(
                            duration: 600.ms,
                            delay: 400.ms,
                          ).slide(begin: const Offset(0.2, 0)),
                    ),
                    const Contacts().animate().fade(
                          duration: 600.ms,
                          delay: 200.ms,
                        ).slide(begin: const Offset(0, 0.2)),
                    // Espaçamento no final para garantir que o último item possa ser rolado para cima
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
