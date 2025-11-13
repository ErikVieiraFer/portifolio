import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TechCarousel extends StatefulWidget {
  const TechCarousel({super.key});

  @override
  State<TechCarousel> createState() => _TechCarouselState();
}

class _TechCarouselState extends State<TechCarousel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<TechItem> _technologies = [
    TechItem(name: 'Flutter', icon: Icons.flutter_dash, color: const Color(0xFF02569B)),
    TechItem(name: 'Python', icon: Icons.code, color: const Color(0xFF3776AB)),
    TechItem(name: 'React', icon: Icons.code, color: const Color(0xFF61DAFB)),
    TechItem(name: 'TypeScript', icon: Icons.code, color: const Color(0xFF3178C6)),
    TechItem(name: 'Firebase', icon: Icons.local_fire_department, color: const Color(0xFFFFCA28)),
    TechItem(name: 'Next.js', icon: Icons.web, color: Colors.white),
    TechItem(name: 'HTML5', icon: Icons.html, color: const Color(0xFFE34F26)),
    TechItem(name: 'CSS3', icon: Icons.css, color: const Color(0xFF1572B6)),
    TechItem(name: 'JavaScript', icon: Icons.javascript, color: const Color(0xFFF7DF1E)),
    TechItem(name: 'Git', icon: Icons.code_outlined, color: const Color(0xFFF05032)),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      height: 120,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = 150.0; // Largura de cada item
              final totalWidth = _technologies.length * itemWidth;
              final offset = _animation.value * totalWidth;

              return ClipRect(
                child: OverflowBox(
                  maxWidth: double.infinity,
                  child: Transform.translate(
                    offset: Offset(-offset, 0),
                    child: Row(
                      children: [
                        ..._buildTechList(),
                        ..._buildTechList(), // Duplica para loop infinito
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<Widget> _buildTechList() {
    return _technologies.map((tech) {
      return Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: tech.color.withAlpha(30),
                shape: BoxShape.circle,
                border: Border.all(color: tech.color, width: 2),
              ),
              child: Icon(
                tech.icon,
                size: 40,
                color: tech.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tech.name,
              style: GoogleFonts.orbitron(
                fontSize: 12,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

class TechItem {
  final String name;
  final IconData icon;
  final Color color;

  TechItem({
    required this.name,
    required this.icon,
    required this.color,
  });
}
