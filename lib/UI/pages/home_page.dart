import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/UI/widgets/about_me.dart';
import 'package:portfolio_flutter/UI/widgets/contacts.dart';
import 'package:portfolio_flutter/UI/widgets/curriculum_button.dart';
import 'package:portfolio_flutter/UI/widgets/header.dart';
import 'package:portfolio_flutter/UI/widgets/languages_widget.dart';
import 'package:portfolio_flutter/UI/widgets/projects.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/languages/languages_cubit.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AutoScrollController _scrollController = AutoScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color.fromARGB(186, 58, 1, 63),
                  Color.fromARGB(197, 0, 0, 0),
                ],
                stops: [0.1, 1.0],
                center: Alignment.topLeft,
                radius: 1.5,
              ),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Header(scrollController: _scrollController),
                AutoScrollTag(
                  key: const ValueKey(1),
                  controller: _scrollController,
                  index: 1,
                  child: const Projects(),
                ),
                const AboutMe(),
                
                MultiBlocProvider(
                  providers: [BlocProvider(create: (_) => LanguagesCubit())],
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: LanguagesWidget(),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocProvider(
                    create: (_) => CurriculumCubit(),
                    child: const CurriculumButton(),
                  ),
                ),
                const Contacts(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
