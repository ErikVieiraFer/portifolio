import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/UI/pages/splash_screen.dart';
import 'package:portfolio_flutter/core/theme/app_themes.dart';
import 'package:portfolio_flutter/infra/cubit/contacts/contacts_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_state.dart';


void main() {
  runApp(
    // ThemeCubit precisa estar no topo para toda a árvore ter acesso
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: const MyPortfolioApp(),
    ),
  );
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder escuta mudanças no tema
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ContactsCubit()),
            BlocProvider(create: (_) => CurriculumCubit()),
          ],
          child: MaterialApp(
            title: 'Meu Portfólio',
            // Aplica o tema baseado no estado atual
            theme: AppThemes.getTheme(themeState.currentTheme),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}