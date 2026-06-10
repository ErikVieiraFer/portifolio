import 'package:flutter/material.dart';
import 'dart:math';

class Particle {
  late Offset position;
  late Offset speed;
  late double radius;
  late Color color;

  Particle({
    required Size bounds,
    required this.color,
  }) {
    position = Offset(
      Random().nextDouble() * bounds.width,
      Random().nextDouble() * bounds.height,
    );
    speed = Offset(
      (Random().nextDouble() - 0.5) * 1.5,
      (Random().nextDouble() - 0.5) * 1.5,
    );
    radius = Random().nextDouble() * 2.0 + 1.0;
  }

  void update(Size bounds, Offset mousePosition) {
    position += speed;
    final double distanceToMouse = (position - mousePosition).distance;
    if (distanceToMouse < 100.0) {
      final direction = (position - mousePosition).scale(1, 1);
      final force = (100.0 - distanceToMouse) / 100.0;
      position += direction.scale(force, force) * 0.1;
    }

    if (position.dx < 0) position = Offset(bounds.width, position.dy);
    if (position.dx > bounds.width) position = Offset(0, position.dy);
    if (position.dy < 0) position = Offset(position.dx, bounds.height);
    if (position.dy > bounds.height) position = Offset(position.dx, 0);
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Offset mousePosition;
  final Color connectionColor;

  ParticlePainter({
    required this.particles,
    required this.mousePosition,
    required this.connectionColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final particlePaint = Paint();
    final linePaint = Paint()
      ..color = connectionColor
      ..strokeWidth = 0.5;

    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      particlePaint.color = p1.color;
      canvas.drawCircle(p1.position, p1.radius, particlePaint);

      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final distance = (p1.position - p2.position).distance;

        if (distance < 150.0) {
          linePaint.color = connectionColor.withValues(alpha: 1.0 - (distance / 150.0));
          canvas.drawLine(p1.position, p2.position, linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    return true;
  }
}
