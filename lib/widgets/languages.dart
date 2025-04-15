import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LinguagensWidget extends StatelessWidget {
  const LinguagensWidget({super.key});

  Color _withOpacity(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }

  // Gradiente com cores interpoladas corretamente
  List<Color> _createGradient(Color baseColor) {
    return [baseColor, Color.lerp(baseColor, Colors.white, 0.3) ?? baseColor];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.cyan, width: 2),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _withOpacity(Colors.purple, 0.3),
            _withOpacity(Colors.blue, 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: _withOpacity(Colors.pink, 0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MINHAS LINGUAGENS',
            style: GoogleFonts.orbitron(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(color: _withOpacity(Colors.pink, 0.7), blurRadius: 5),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildLinguagemItem(
            icon: FontAwesomeIcons.mobileScreen,
            label: 'Flutter',
            nivel: 'Intermediário',
            baseColor: Colors.blue,
          ),
          _buildLinguagemItem(
            icon: FontAwesomeIcons.html5,
            label: 'HTML',
            nivel: 'Iniciante',
            baseColor: Colors.orange,
          ),
          _buildLinguagemItem(
            icon: FontAwesomeIcons.css3,
            label: 'CSS',
            nivel: 'Iniciante',
            baseColor: Colors.blueAccent,
          ),
          _buildLinguagemItem(
            icon: FontAwesomeIcons.code,
            label: 'C#',
            nivel: 'Iniciante',
            baseColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildLinguagemItem({
    required IconData icon,
    required String label,
    required String nivel,
    required Color baseColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          FaIcon(icon, color: baseColor, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _withOpacity(Colors.black, 0.5),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: _getNivelFactor(nivel),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _createGradient(baseColor),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getNivelFactor(String nivel) {
    return switch (nivel.toLowerCase()) {
      'iniciante' => 0.3,
      'intermediário' => 0.6,
      'avançado' => 0.9,
      _ => 0.5,
    };
  }
}
