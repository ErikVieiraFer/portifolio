import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/core/constants/app_strings.dart';
import 'package:portfolio_flutter/infra/cubit/budget/budget_cubit.dart';
import 'package:portfolio_flutter/UI/widgets/budget_form_modal.dart';

class BudgetButton extends StatefulWidget {
  const BudgetButton({super.key});

  @override
  State<BudgetButton> createState() => _BudgetButtonState();
}

class _BudgetButtonState extends State<BudgetButton>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _openBudgetForm() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BlocProvider(
        create: (_) => BudgetCubit(),
        child: const BudgetFormModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _isHovering ? 1.05 : _pulseAnimation.value,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pinkAccent.withAlpha(100),
                    blurRadius: _isHovering ? 25 : 15,
                    spreadRadius: _isHovering ? 3 : 1,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _openBudgetForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: _isHovering ? 8 : 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.request_quote,
                      size: 32,
                      color: _isHovering ? Colors.yellow : Colors.white,
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.budgetButton,
                            style: GoogleFonts.orbitron(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Transforme sua ideia em realidade',
                            style: GoogleFonts.orbitron(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}