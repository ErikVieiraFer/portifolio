import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/core/models/project_model.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';
import 'package:portfolio_flutter/core/services/url_service.dart';

class HolographicCard extends StatefulWidget {
  final Project project;
  final bool isCenter;
  final VoidCallback? onTap;

  const HolographicCard({
    super.key,
    required this.project,
    this.isCenter = false,
    this.onTap,
  });

  @override
  State<HolographicCard> createState() => _HolographicCardState();
}

class _HolographicCardState extends State<HolographicCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final colors = themeState.currentTheme.colors;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_isHovering && widget.isCenter ? -0.05 : 0)
            ..scale(widget.isCenter ? (_isHovering ? 1.03 : 1.0) : 0.95, widget.isCenter ? (_isHovering ? 1.03 : 1.0) : 0.95, 1.0),
        child: Container(
          width: 280,
          height: 580,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: widget.isCenter
                  ? colors.primary.withValues(alpha: 0.8)
                  : colors.border.withValues(alpha: 0.5),
              width: 3,
            ),
            boxShadow: _isHovering && widget.isCenter
                ? [
                    BoxShadow(
                      color: colors.glow,
                      blurRadius: 30,
                      spreadRadius: 5,
                    )
                  ]
                : [
                    BoxShadow(
                      color: widget.isCenter
                          ? colors.primary.withValues(alpha: 0.3)
                          : Colors.black.withAlpha(127),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    )
                  ],
          ),
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.black,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: Colors.black,
                  child: Center(
                    child: Container(
                      width: 120,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          widget.project.imagePath,
                          fit: BoxFit.cover,
                        ),

                        if (_isHovering || widget.isCenter)
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withAlpha(230),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.project.title,
                                  style: GoogleFonts.orbitron(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.project.description,
                                  style: GoogleFonts.orbitron(
                                    fontSize: 11,
                                    color: Colors.white70,
                                    height: 1.4,
                                  ),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 12),

                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: widget.project.techs
                                      .map((tech) => Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: colors.primary.withAlpha(180),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              tech,
                                              style: GoogleFonts.orbitron(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),

                                const SizedBox(height: 12),

                                Row(
                                  children: [
                                    if (widget.project.githubUrl != null)
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () => UrlService.launchURL(
                                            widget.project.githubUrl!,
                                            context,
                                          ),
                                          icon: const Icon(Icons.code, size: 16),
                                          label: Text(
                                            'GitHub',
                                            style: GoogleFonts.orbitron(fontSize: 10),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: colors.secondary,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (widget.project.githubUrl != null &&
                                        widget.project.demoUrl != null)
                                      const SizedBox(width: 8),
                                    if (widget.project.demoUrl != null)
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () => UrlService.launchURL(
                                            widget.project.demoUrl!,
                                            context,
                                          ),
                                          icon: const Icon(Icons.play_arrow, size: 16),
                                          label: Text(
                                            'Demo',
                                            style: GoogleFonts.orbitron(fontSize: 10),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: colors.primary,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                Container(
                  height: 20,
                  color: Colors.black,
                  child: Center(
                    child: Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
