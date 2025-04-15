import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/widgets/about_me.dart';
import 'package:portfolio_flutter/widgets/contacts.dart';
import 'package:portfolio_flutter/widgets/header.dart';
import 'package:portfolio_flutter/widgets/projects.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AutoScrollController _scrollController = AutoScrollController();
  final _scrollDuration = const Duration(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          '80s',
          style: GoogleFonts.pressStart2p(
            fontSize: 14,
            color: const Color.fromARGB(195, 207, 49, 1),
            shadows: [Shadow(color: Color(0xB32196F3), blurRadius: 10)],
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 103, 39, 255),
              Color.fromARGB(255, 0, 0, 0),
            ],
            stops: [0.1, 1.0],
            center: Alignment.topLeft,
            radius: 1.5,
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [const Header(), AboutMe(), Projects(), Contacts()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => _scrollController.scrollToIndex(0, duration: _scrollDuration),
        backgroundColor: const Color.fromARGB(221, 230, 233, 30),
        child: const Icon(Icons.arrow_upward, color: Colors.white),
      ),
    );
  }
}
