import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class LanguagesWidget extends StatefulWidget {
  const LanguagesWidget({super.key});

  @override
  State<LanguagesWidget> createState() => _LanguagesWidgetState();
}

class _LanguagesWidgetState extends State<LanguagesWidget> {
  final Map<String, bool> _isHovering = {};

  final Map<String, String> skillModels = const {
    'assets/assets/models/flutter_logo.glb': 'Flutter',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            'FrameWork',
            style: GoogleFonts.orbitron(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Wrap(
              spacing: 24.0,
              runSpacing: 16.0,
              alignment: WrapAlignment.center,
              children: skillModels.entries.map((entry) {
                final isHovering = _isHovering[entry.key] ?? false;
                return MouseRegion(
                  onEnter: (_) => setState(() => _isHovering[entry.key] = true),
                  onExit: (_) => setState(() => _isHovering[entry.key] = false),
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: Matrix4.identity()..scale(isHovering ? 1.1 : 1.0),
                    transformAlignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 160,
                          child: ModelViewer(
                            src: entry.key,
                            alt: 'Logo 3D de ${entry.value}',
                            autoRotate: isHovering,
                            cameraControls: true,
                            disableZoom: false,
                            cameraOrbit: '30deg 75deg 1.2m',
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry.value,
                          style: GoogleFonts.orbitron(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }}
