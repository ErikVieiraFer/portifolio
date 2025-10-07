import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/UI/widgets/hover_animated_title.dart';
import 'package:portfolio_flutter/core/constants/app_strings.dart';

class LanguagesWidget extends StatefulWidget {
  const LanguagesWidget({super.key});

  @override
  State<LanguagesWidget> createState() => _LanguagesWidgetState();
}

class _LanguagesWidgetState extends State<LanguagesWidget> {
  final String mainSkillIcon = 'assets/icons/flutter.svg';
  final String mainSkillName = 'Flutter';

  final Map<String, String> secondarySkills = const {
    'assets/icons/python.svg': 'Python',
    'assets/icons/html5.svg': 'HTML5',
    'assets/icons/css3.svg': 'CSS3',
    'assets/icons/javascript.svg': 'JavaScript',
  };

  final Map<String, bool> _isHovering = {};
  bool _isCardHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isCardHovering = true),
      onExit: (_) => setState(() => _isCardHovering = false),
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.cyanAccent, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HoverAnimatedTitle(
              title: AppStrings.skillsTitle,
              isHovering: _isCardHovering,
              style: GoogleFonts.orbitron(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            Center(
                child: _buildSkillWidget(mainSkillIcon, mainSkillName,
                    isPrimary: true)),
            const SizedBox(height: 40),
            Center(
              child: Wrap(
                spacing: 48.0,
                runSpacing: 32.0,
                alignment: WrapAlignment.center,
                children: secondarySkills.entries
                    .map((entry) => _buildSkillWidget(entry.key, entry.value,
                        isPrimary: false))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillWidget(String iconPath, String name,
      {bool isPrimary = false}) {
    final bool isHovering = _isHovering[iconPath] ?? false;
    final double iconSize = isPrimary ? 120.0 : 70.0;
    final double fontSize = isPrimary ? 22.0 : 16.0;

    ColorFilter? iconColorFilter;
    if (isPrimary) {
      iconColorFilter =
          const ColorFilter.mode(Colors.cyanAccent, BlendMode.srcIn);
    } else if (!isHovering) {
      iconColorFilter = const ColorFilter.mode(Colors.grey, BlendMode.srcIn);
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering[iconPath] = true),
      onExit: (_) => setState(() => _isHovering[iconPath] = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(isHovering ? 1.1 : 1.0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isHovering && !isPrimary
              ? Colors.cyanAccent.withAlpha(20)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isHovering && !isPrimary
              ? [
                  BoxShadow(
                    color: Colors.cyanAccent.withAlpha(80),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        transformAlignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: iconSize,
              height: iconSize,
              child: SvgPicture.asset(
                iconPath,
                semanticsLabel: 'Logo de $name',
                colorFilter: iconColorFilter,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: GoogleFonts.orbitron(
                fontSize: fontSize,
                color: Colors.white,
                fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}