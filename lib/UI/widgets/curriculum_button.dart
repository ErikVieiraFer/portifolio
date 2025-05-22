import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/curriculum/curriculum_state.dart';

class CurriculumButton extends StatelessWidget {
  const CurriculumButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurriculumCubit, CurriculumState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ElevatedButton(
            onPressed: state is CurriculumReady ? () => _launchPdf() : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon(state),
                const SizedBox(width: 12),
                Text(
                  'Currículo',
                  style: GoogleFonts.orbitron(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(CurriculumState state) {
    if (state is CurriculumLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(color: Colors.black, strokeWidth: 3),
      );
    }
    return const Icon(Icons.picture_as_pdf, color: Colors.black, size: 28);
  }

  Future<void> _launchPdf() async {
    const pdfUrl = '/pdf/curriculum.pdf'; // Caminho relativo no GitHub Pages
    final Uri uri = Uri.parse(pdfUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    } else {
      debugPrint('Could not launch $pdfUrl');
    }
  }
}
