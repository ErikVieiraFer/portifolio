import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:portfolio_flutter/core/constants/app_strings.dart';

class Header extends StatefulWidget {
  final AutoScrollController scrollController;
  const Header({super.key, required this.scrollController});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isHovering = false;
  Offset _mousePosition = Offset.zero;
  Timer? _throttleTimer;

  Future<void> _scrollToProjects() async {
    await widget.scrollController.scrollToIndex(
      1,
      duration: const Duration(milliseconds: 800),
      preferPosition: AutoScrollPosition.begin,
    );
  }

  void _updateMousePosition(Offset position) {
    if (_throttleTimer?.isActive ?? false) return;

    setState(() => _mousePosition = position);

    _throttleTimer = Timer(const Duration(milliseconds: 16), () {});
  }

  @override
  void dispose() {
    _throttleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    final textParallaxOffset = isMobile
        ? Offset.zero
        : Offset(
            (_mousePosition.dx - size.width / 2) / 40,
            (_mousePosition.dy - size.height / 2) / 40,
          );

    return MouseRegion(
      onHover: (event) => _updateMousePosition(event.localPosition),
      child: SizedBox(
        height: size.height,
        child: ClipRect(
          child: Stack(
            children: [
              if (!isMobile)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 100),
                  left: _mousePosition.dx - 150,
                  top: _mousePosition.dy - 150,
                  child: IgnorePointer(
                    child: Container(
                      width: 300,
                      height: 300,
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
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isMobile ? 20 : 0),
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
                              Flexible(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        AppStrings.developerName,
                                        textStyle: GoogleFonts.pressStart2p(
                                          fontSize: isMobile ? 24 : 32,
                                          color: const Color.fromARGB(
                                              255, 233, 77, 30),
                                          shadows: [
                                            Shadow(
                                              color: const Color.fromARGB(
                                                  185, 255, 235, 59),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        speed:
                                            const Duration(milliseconds: 200),
                                      ),
                                    ],
                                    repeatForever: true,
                                    pause: const Duration(milliseconds: 500),
                                  ),
                                ),
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
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              AppStrings.developerTitle,
                              style: GoogleFonts.pressStart2p(
                                fontSize: isMobile ? 12 : 16,
                                color: Colors.cyan,
                              ),
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
                              color: _isHovering
                                  ? Colors.yellow
                                  : Colors.transparent,
                              border: Border.all(color: Colors.yellow, width: 2),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: _isHovering
                                  ? [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                            150, 255, 235, 59),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}