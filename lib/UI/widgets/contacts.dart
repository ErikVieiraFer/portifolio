import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/core/constants/app_strings.dart';
import 'package:portfolio_flutter/core/theme/theme_colors.dart';
import 'package:portfolio_flutter/infra/cubit/contacts/contacts_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/theme/theme_state.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final colors = ThemeColors.fromType(themeState.currentTheme);
          final isMobile = MediaQuery.of(context).size.width < 600;

          return Container(
            margin: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: isMobile ? 16 : 80,
            ),
            child: isMobile
                ? Column(
                    children: [
                      _buildImageSection(colors, isMobile),
                      const SizedBox(height: 20),
                      _buildContactSection(context, colors, isMobile),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildImageSection(colors, isMobile),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 2,
                        child: _buildContactSection(context, colors, isMobile),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildImageSection(colors, bool isMobile) {
    return Container(
      height: isMobile ? 400 : 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(127),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/images/contact_character.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colors.border, width: 2),
              ),
              child: Icon(
                Icons.person,
                size: isMobile ? 150 : 200,
                color: colors.primary,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context, colors, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border, width: 2),
        boxShadow: [
          BoxShadow(color: colors.glow, blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CONTATO',
            style: GoogleFonts.orbitron(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 32),
          _buildContactItem(
            context: context,
            icon: Icons.email,
            label: AppStrings.emailLabel,
            value: 'erik.vieiradev@hotmail.com',
            colors: colors,
            onTap: () => context.read<ContactsCubit>().launchEmail(context),
          ),
          const SizedBox(height: 20),
          _buildContactItem(
            context: context,
            icon: Icons.phone,
            label: AppStrings.phoneLabel,
            value: '(27) 99854-7188',
            colors: colors,
            onTap: () => context.read<ContactsCubit>().launchWhatsApp(context),
          ),
          const SizedBox(height: 20),
          _buildContactItem(
            context: context,
            icon: Icons.code,
            label: AppStrings.githubLabel,
            value: 'github.com/ErikVieiraFer',
            colors: colors,
            onTap: () => context.read<ContactsCubit>().launchGitHub(context),
            isLink: true,
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required colors,
    required VoidCallback onTap,
    bool isLink = false,
  }) {
    return ContactItemWidget(
      icon: icon,
      label: label,
      value: value,
      colors: colors,
      onTap: onTap,
      isLink: isLink,
    );
  }
}

class ContactItemWidget extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final dynamic colors;
  final VoidCallback onTap;
  final bool isLink;

  const ContactItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.colors,
    required this.onTap,
    this.isLink = false,
  });

  @override
  State<ContactItemWidget> createState() => _ContactItemWidgetState();
}

class _ContactItemWidgetState extends State<ContactItemWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _isHovering
                ? widget.colors.border.withAlpha(30)
                : widget.colors.border.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovering
                  ? widget.colors.border
                  : widget.colors.border.withAlpha(80),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.colors.primary.withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon, color: widget.colors.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: GoogleFonts.orbitron(
                        fontSize: 12,
                        color: widget.colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: GoogleFonts.orbitron(
                        fontSize: 16,
                        color: widget.colors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.isLink)
                Icon(Icons.open_in_new, color: widget.colors.secondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}