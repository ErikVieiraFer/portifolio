import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cursor.dart'; // Importe o cursor horizontal

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _showCursor = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container para alinhar texto + cursor
            Container(
              padding: const EdgeInsets.only(bottom: 4), // Ajuste de posição
              child: Row(
                mainAxisSize: MainAxisSize.min, // Evita ocupar largura total
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end, // Alinha na base
                children: [
                  // Texto com efeito de digitação
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
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    onFinished: () => setState(() => _showCursor = true),
                  ),
                  // Cursor horizontal rosa
                  if (_showCursor) const HorizontalBlinkingCursor(),
                ],
              ),
            ),

            // Subtítulo
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'FLUTTER DEVELOPER',
                style: GoogleFonts.pressStart2p(
                  fontSize: 16,
                  color: Colors.cyan,
                ),
              ),
            ),

            // Efeito de borda neon
            Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(185, 255, 235, 59),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_downward,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
