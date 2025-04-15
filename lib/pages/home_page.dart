import 'package:flutter/material.dart';

import 'package:portfolio_flutter/widgets/about_me.dart';
import 'package:portfolio_flutter/widgets/contacts.dart';
import 'package:portfolio_flutter/widgets/header.dart';
import 'package:portfolio_flutter/widgets/languages.dart';
import 'package:portfolio_flutter/widgets/projects.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AutoScrollController _scrollController = AutoScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
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

          // Conteúdo da página
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                Header(),
                Projects(),
                AboutMe(),
                LinguagensWidget(),
                Contacts(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
