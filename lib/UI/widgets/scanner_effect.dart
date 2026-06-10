import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';

class ScannerEffect extends StatefulWidget {
  const ScannerEffect({super.key});

  @override
  State<ScannerEffect> createState() => _ScannerEffectState();
}

class _ScannerEffectState extends State<ScannerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final themeColor = themeState.currentTheme.colors.secondary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned.fill(
          child: CustomPaint(
            painter: _ScannerPainter(_controller.value, themeColor),
          ),
        );
      },
    );
  }
}

class _ScannerPainter extends CustomPainter {
  final double position;
  final Color color;

  _ScannerPainter(this.position, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0),
          color.withValues(alpha: 0.8),
          color,
          color.withValues(alpha: 0.8),
          color.withValues(alpha: 0),
        ],
        stops: const [0.0, 0.4, 0.5, 0.6, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0);

    final scannerY = size.height * position;
    const scannerHeight = 150.0;

    canvas.drawRect(
      Rect.fromLTWH(0, scannerY - (scannerHeight / 2), size.width, scannerHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScannerPainter oldDelegate) {
    return oldDelegate.position != position || oldDelegate.color != color;
  }
}
