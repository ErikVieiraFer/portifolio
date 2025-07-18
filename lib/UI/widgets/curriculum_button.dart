import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CurriculumButton extends StatelessWidget {
  const CurriculumButton({super.key});
  static final Uri _curriculumUrl = Uri.parse(
    'https://ErikVieiraFer.github.io/jscurriculum/',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: _launchCurriculumUrl, 
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
            const Icon(Icons.article_outlined, color: Colors.black, size: 28),
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
  }

  Future<void> _launchCurriculumUrl() async {
    if (!await launchUrl(_curriculumUrl)) {
      throw 'Could not launch $_curriculumUrl';
    }
  }
}
