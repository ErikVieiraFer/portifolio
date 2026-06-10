import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_state.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';
import 'particle_painter.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _particles = [];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        for (var particle in _particles) {
          particle.update(context.size ?? Size.zero, _mousePosition);
        }
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeParticles();
  }

  void _initializeParticles() {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final particleCount = isMobile ? 30 : 70;
    final themeState = context.read<ThemeCubit>().state;
    final particleColor = themeState.currentTheme.colors.secondary.withValues(alpha: 0.6);

    _particles = List.generate(
      particleCount,
      (index) => Particle(bounds: size, color: particleColor),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final colors = themeState.currentTheme.colors;
        for (var p in _particles) {
          p.color = colors.secondary.withValues(alpha: 0.6);
        }

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
            painter: ParticlePainter(
              particles: _particles,
              mousePosition: _mousePosition,
              connectionColor: colors.primary.withValues(alpha: 0.2),
            ),
          ),
        );
      },
    );
  }
}
