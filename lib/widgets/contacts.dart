import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contato',
            style: GoogleFonts.orbitron(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          ContactRow(
            icon: Icons.email,
            label: 'Email',
            value: 'erik.vieiradev@hotmail.com',
          ),
          const SizedBox(height: 10),
          ContactRow(
            icon: Icons.phone,
            label: 'Telefone',
            value: '(27) 998547188',
          ),
          const SizedBox(height: 10),
          ContactRow(
            icon: Icons.web,
            label: 'GitHub',
            value: 'github.com/ErikVieiraFer',
          ),
        ],
      ),
    );
  }
}

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ContactRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: GoogleFonts.orbitron(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.orbitron(fontSize: 16, color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
