import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/infra/cubit/contacts/contacts_cubit.dart';
import 'package:portfolio_flutter/UI/widgets/hover_animated_title.dart';
import 'package:portfolio_flutter/core/constants/app_strings.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  bool _isCardHovering = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit(),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isCardHovering = true),
        onExit: (_) => setState(() => _isCardHovering = false),
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.redAccent, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HoverAnimatedTitle(
                title: AppStrings.contactTitle,
                isHovering: _isCardHovering,
                style: GoogleFonts.orbitron(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              ContactRow(
                icon: Icons.email,
                label: AppStrings.emailLabel,
                value: 'erik.vieiradev@hotmail.com',
                onTap: () => context.read<ContactsCubit>().launchEmail(context),
              ),
              const SizedBox(height: 10),
              ContactRow(
                icon: Icons.phone,
                label: AppStrings.phoneLabel,
                value: '(27) 99854-7188',
                onTap: () => context.read<ContactsCubit>().launchWhatsApp(context),
              ),
              const SizedBox(height: 10),
              ContactRow(
                icon: Icons.web,
                label: AppStrings.githubLabel,
                value: 'github.com/ErikVieiraFer',
                onTap: () => context.read<ContactsCubit>().launchGitHub(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactRow extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const ContactRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<ContactRow> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: 'Clique para acessar ${widget.label.toLowerCase()}',
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.redAccent.withAlpha(100),
          highlightColor: Colors.redAccent.withAlpha(30),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: _isHovering
                  ? Colors.redAccent.withAlpha(50)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: Colors.white70),
                const SizedBox(width: 12),
                Text(
                  '${widget.label}: ',
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.value,
                    style: GoogleFonts.orbitron(
                        fontSize: 16, color: Colors.white70),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.white70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}