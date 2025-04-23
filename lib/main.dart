import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/UI/pages/splash_screen.dart';
import 'package:portfolio_flutter/UI/theme/app_theme.dart';
import 'package:portfolio_flutter/infra/cubit/contacts/contacts_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/languages/languages_cubit.dart';

void main() {
  runApp(
    MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ContactsCubit()),
          BlocProvider(create: (_) => LanguagesCubit()),
          BlocProvider(create: (_) => CurriculumCubit()),
        ],
        child: const MyPortfolioApp(),
      ),
    ),
  );
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfólio Anos 80',
      theme: appTheme(),
      home: const SplashScreen(), // Alterado para iniciar com a tela de splash
      debugShowCheckedModeBanner: false,
    );
  }
}
