import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/UI/widgets/scanner_effect.dart';
import 'package:portfolio_flutter/core/models/project_model.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';

class HolographicCard extends StatelessWidget {
  final Project project;
  final bool isCenter;

  const HolographicCard({
    super.key,
    required this.project,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final colors = themeState.currentTheme.colors;
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.45,
      height: 450, // Altura aumentada para o card
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Card principal
          Positioned(
            top: 0,
            child: Container(
              width: size.width * 0.4,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCenter ? colors.primary.withOpacity(0.8) : colors.border.withOpacity(0.5),
                  width: isCenter ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isCenter ? colors.glow.withOpacity(0.5) : colors.primary.withOpacity(0.2),
                    blurRadius: isCenter ? 30 : 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(project.imagePath, fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                    CustomPaint(
                      size: Size.infinite,
                      painter: _GridPainter(colors.secondary.withOpacity(0.2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(blurRadius: 10, color: colors.glow)],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            project.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    if (isCenter) const ScannerEffect(),
                  ],
                ),
              ),
            ),
          ),
          // Efeito de reflexo
          if (isCenter)
            Positioned(
              top: 300, // Posiciona o reflexo logo abaixo do card
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scale(1.0, -1.0, 1.0),
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white.withOpacity(0.3), Colors.transparent],
                    ).createShader(bounds);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      project.imagePath,
                      width: size.width * 0.4,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    for (var i = 0; i < size.width / 20; i++) {
      canvas.drawLine(Offset(i * 20, 0), Offset(i * 20, size.height), paint);
    }
    for (var i = 0; i < size.height / 20; i++) {
      canvas.drawLine(Offset(0, i * 20), Offset(size.width, i * 20), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

