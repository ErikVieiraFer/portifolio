import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [NeonName(), SizedBox(height: 8), GradientSubtitle()],
      ),
    );
  }
}

// NOME COM GRADIENTE + SOMBRA NEON ANIMADA
class NeonName extends StatefulWidget {
  const NeonName({super.key});

  @override
  State<NeonName> createState() => _NeonNameState();
}

class _NeonNameState extends State<NeonName>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glow = Tween<double>(
      begin: 5.0,
      end: 20.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
                colors: [Colors.pinkAccent, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
          child: Text(
            'Erik Vieira',
            style: GoogleFonts.orbitron(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.blueAccent.withAlpha(
                    (_glow.value * 10).toInt(),
                  ),
                  blurRadius: _glow.value,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// SUBTÍTULO COM GRADIENTE (AZUL PRA ROSA)
class GradientSubtitle extends StatelessWidget {
  const GradientSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => const LinearGradient(
            colors: [Colors.blueAccent, Colors.pinkAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
      child: Text(
        'Desenvolvedor Flutter & Mobile',
        style: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
