import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TechCarousel extends StatefulWidget {
  const TechCarousel({super.key});

  @override
  State<TechCarousel> createState() => _TechCarouselState();
}

class _TechCarouselState extends State<TechCarousel> {
  late ScrollController _scrollController;
  late Timer _timer;

  final List<TechItem> _technologies = [
    TechItem(name: 'Flutter', iconPath: 'assets/icons/flutter.svg', color: const Color(0xFF02569B)),
    TechItem(name: 'Python', iconPath: 'assets/icons/python.svg', color: const Color(0xFF3776AB)),
    TechItem(name: 'React', iconPath: 'assets/icons/react.svg', color: const Color(0xFF61DAFB)),
    TechItem(name: 'TypeScript', iconPath: 'assets/icons/typescript.svg', color: const Color(0xFF3178C6)),
    TechItem(name: 'Firebase', iconPath: 'assets/icons/firebase.svg', color: const Color(0xFFFFCA28)),
    TechItem(name: 'Next.js', iconPath: 'assets/icons/nextdotjs.svg', color: const Color(0xFF000000)),
    TechItem(name: 'HTML5', iconPath: 'assets/icons/html5.svg', color: const Color(0xFFE34F26)),
    TechItem(name: 'CSS3', iconPath: 'assets/icons/css.svg', color: const Color(0xFF1572B6)),
    TechItem(name: 'JavaScript', iconPath: 'assets/icons/javascript.svg', color: const Color(0xFFF7DF1E)),
    TechItem(name: 'Git', iconPath: 'assets/icons/git.svg', color: const Color(0xFFF05032)),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Iniciar animação após build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    const scrollSpeed = 50.0; // pixels por segundo

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted || !_scrollController.hasClients) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      final nextScroll = currentScroll + (scrollSpeed * 0.05);

      if (nextScroll >= maxScroll) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(nextScroll);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 40),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(), // Desabilita scroll manual
        itemCount: _technologies.length * 100, // Muitos itens para loop infinito
        itemBuilder: (context, index) {
          final tech = _technologies[index % _technologies.length];
          return _buildTechItem(tech);
        },
      ),
    );
  }

  Widget _buildTechItem(TechItem tech) {
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
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              tech.iconPath,
              colorFilter: ColorFilter.mode(tech.color, BlendMode.srcIn),
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
  }
}

class TechItem {
  final String name;
  final String iconPath;
  final Color color;

  TechItem({
    required this.name,
    required this.iconPath,
    required this.color,
  });
}
