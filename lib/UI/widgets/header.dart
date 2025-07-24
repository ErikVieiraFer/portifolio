import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Header extends StatefulWidget {
  final AutoScrollController scrollController;
  const Header({super.key, required this.scrollController});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isHovering = false;
  Offset _mousePosition = Offset.zero;

  Future<void> _scrollToProjects() async {
    await widget.scrollController.scrollToIndex(
      1,
      duration: const Duration(milliseconds: 800),
      preferPosition: AutoScrollPosition.begin,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textParallaxOffset = Offset(
      (_mousePosition.dx - size.width / 2) / 40,
      (_mousePosition.dy - size.height / 2) / 40,
    );

    return MouseRegion(
      onHover: (event) => setState(() => _mousePosition = event.localPosition),
      child: SizedBox(
        height: size.height,
        child: ClipRect(
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                left: _mousePosition.dx - 150, // Metade da nova largura
                top: _mousePosition.dy - 150,  // Metade da nova altura
                child: IgnorePointer(
                  child: Container(
                    width: 300, // Largura do brilho
                    height: 300, // Altura do brilho
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.cyan.withAlpha(38),
                          Colors.cyan.withAlpha(0),
                        ],
                        stops: const [0, 0.8],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      transform: Matrix4.translationValues(
                        textParallaxOffset.dx,
                        textParallaxOffset.dy,
                        0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'ERIK VIEIRA',
                                  textStyle: GoogleFonts.pressStart2p(
                                    fontSize: 32,
                                    color: const Color.fromARGB(255, 233, 77, 30),
                                    shadows: [
                                      Shadow(
                                        color: const Color.fromARGB(185, 255, 235, 59),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  speed: const Duration(milliseconds: 200),
                                ),
                              ],
                              repeatForever: true,
                              pause: const Duration(milliseconds: 500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      transform: Matrix4.translationValues(
                        textParallaxOffset.dx * 1.5,
                        textParallaxOffset.dy * 1.5,
                        0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'FLUTTER DEVELOPER',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 16,
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      onEnter: (_) => setState(() => _isHovering = true),
                      onExit: (_) => setState(() => _isHovering = false),
                      child: GestureDetector(
                        onTap: _scrollToProjects,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(30),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _isHovering ? Colors.yellow : Colors.transparent,
                            border: Border.all(color: Colors.yellow, width: 2),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: _isHovering
                                ? [
                                    BoxShadow(
                                      color: const Color.fromARGB(150, 255, 235, 59),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Icon(
                            Icons.arrow_downward,
                            color: _isHovering ? Colors.black : Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
