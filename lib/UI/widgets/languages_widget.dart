import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/infra/cubit/languages/languages_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/languages/languages_state.dart';
import 'package:portfolio_flutter/core/models/language.dart';

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({super.key});

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
      child: BlocBuilder<LanguagesCubit, LanguagesState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título da seção
              Text(
                'Linguagens',
                style: GoogleFonts.orbitron(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Lista de linguagens sempre visível
              ...state.languages.map(
                (language) => _buildLanguageItem(language),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageItem(Language language) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                language.name,
                style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: language.color,
                ),
              ),
              Text(
                '${(language.proficiency * 100).toInt()}%',
                style: GoogleFonts.orbitron(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: language.proficiency,
            backgroundColor: Colors.grey[800],
            valueColor: AlwaysStoppedAnimation<Color>(language.color),
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }
}
