import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';

class SpotlightEffect extends StatefulWidget {
  const SpotlightEffect({super.key});

  @override
  State<SpotlightEffect> createState() => _SpotlightEffectState();
}

class _SpotlightEffectState extends State<SpotlightEffect> {
  Offset _mousePosition = const Offset(-200, -200);

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final glowColor = themeState.currentTheme.colors.glow;

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.position;
        });
      },
      onExit: (event) {
        setState(() {
          _mousePosition = const Offset(-200, -200);
        });
      },
      child: CustomPaint(
        size: Size.infinite,
        painter: _SpotlightPainter(
          mousePosition: _mousePosition,
          glowColor: glowColor,
        ),
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  final Offset mousePosition;
  final Color glowColor;

  _SpotlightPainter({required this.mousePosition, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (mousePosition.dx < 0 || mousePosition.dy < 0) return;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          glowColor.withOpacity(0.15),
          glowColor.withOpacity(0.0),
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: mousePosition, radius: 250));

    canvas.drawCircle(mousePosition, 250, paint);
  }

  @override
  bool shouldRepaint(covariant _SpotlightPainter oldDelegate) {
    return oldDelegate.mousePosition != mousePosition ||
           oldDelegate.glowColor != glowColor;
  }
}
