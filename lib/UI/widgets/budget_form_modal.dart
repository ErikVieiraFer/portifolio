import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/core/constants/app_strings.dart';
import 'package:portfolio_flutter/core/models/budget_request.dart';
import 'package:portfolio_flutter/infra/cubit/budget/budget_cubit.dart';
import 'package:portfolio_flutter/infra/cubit/budget/budget_state.dart';

class BudgetFormModal extends StatefulWidget {
  const BudgetFormModal({super.key});

  @override
  State<BudgetFormModal> createState() => _BudgetFormModalState();
}

class _BudgetFormModalState extends State<BudgetFormModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  ProjectType? _selectedProjectType;
  BudgetRange? _selectedBudgetRange;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && 
        _selectedProjectType != null && 
        _selectedBudgetRange != null) {
      final request = BudgetRequest(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        projectType: _selectedProjectType!,
        budgetRange: _selectedBudgetRange!,
        description: _descriptionController.text.trim(),
      );
      
      context.read<BudgetCubit>().submitBudget(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: BlocConsumer<BudgetCubit, BudgetState>(
        listener: (context, state) {
          if (state.status == BudgetStatus.success) {
            Future.delayed(const Duration(seconds: 3), () {
              if (!mounted) return;
              Navigator.of(context).pop();
              context.read<BudgetCubit>().reset();
            });
          }
        },
        builder: (context, state) {
          if (state.status == BudgetStatus.success) {
            return _buildSuccessView();
          }

          return Container(
            width: isMobile ? size.width * 0.9 : 600,
            constraints: BoxConstraints(
              maxHeight: size.height * 0.9,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(10, 10, 10, 0.95),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.pinkAccent, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.pinkAccent.withAlpha(80),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 20 : 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.budgetFormTitle,
                                  style: GoogleFonts.orbitron(
                                    fontSize: isMobile ? 22 : 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  AppStrings.budgetFormSubtitle,
                                  style: GoogleFonts.orbitron(
                                    fontSize: isMobile ? 12 : 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close, color: Colors.white70),
                            tooltip: AppStrings.closeButton,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Nome
                      _buildTextField(
                        controller: _nameController,
                        label: AppStrings.nameLabel,
                        hint: AppStrings.nameHint,
                        icon: Icons.person,
                        validator: context.read<BudgetCubit>().validateName,
                      ),
                      const SizedBox(height: 16),
                      
                      // Email
                      _buildTextField(
                        controller: _emailController,
                        label: AppStrings.emailLabel,
                        hint: AppStrings.emailHint,
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: context.read<BudgetCubit>().validateEmail,
                      ),
                      const SizedBox(height: 16),
                      
                      // Tipo de Projeto
                      _buildDropdown<ProjectType>(
                        label: AppStrings.projectTypeLabel,
                        hint: AppStrings.projectTypeHint,
                        icon: Icons.category,
                        value: _selectedProjectType,
                        items: ProjectType.values,
                        onChanged: (value) => setState(() => _selectedProjectType = value),
                        itemLabel: (type) => type.label,
                      ),
                      const SizedBox(height: 16),
                      
                      // Orçamento
                      _buildDropdown<BudgetRange>(
                        label: AppStrings.budgetRangeLabel,
                        hint: AppStrings.budgetRangeHint,
                        icon: Icons.attach_money,
                        value: _selectedBudgetRange,
                        items: BudgetRange.values,
                        onChanged: (value) => setState(() => _selectedBudgetRange = value),
                        itemLabel: (range) => range.label,
                      ),
                      const SizedBox(height: 16),
                      
                      // Descrição
                      _buildTextField(
                        controller: _descriptionController,
                        label: AppStrings.descriptionLabel,
                        hint: AppStrings.descriptionHint,
                        icon: Icons.description,
                        maxLines: 5,
                        validator: context.read<BudgetCubit>().validateDescription,
                      ),
                      const SizedBox(height: 24),
                      
                      // Erro
                      if (state.status == BudgetStatus.error)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withAlpha(30),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.redAccent),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error, color: Colors.redAccent),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    state.errorMessage ?? AppStrings.budgetError,
                                    style: GoogleFonts.orbitron(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      
                      // Botões
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: state.status == BudgetStatus.loading
                                  ? null
                                  : () => Navigator.of(context).pop(),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white70,
                                side: const BorderSide(color: Colors.white30),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                AppStrings.cancelButton,
                                style: GoogleFonts.orbitron(fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: state.status == BudgetStatus.loading
                                  ? null
                                  : _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pinkAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: state.status == BudgetStatus.loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      AppStrings.sendButton,
                                      style: GoogleFonts.orbitron(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.orbitron(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.orbitron(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.orbitron(color: Colors.white38),
            prefixIcon: Icon(icon, color: Colors.pinkAccent),
            filled: true,
            fillColor: Colors.white.withAlpha(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white24),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white24),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required String hint,
    required IconData icon,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
    required String Function(T) itemLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.orbitron(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(10),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24),
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            hint: Text(
              hint,
              style: GoogleFonts.orbitron(color: Colors.white38),
            ),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.pinkAccent),
            dropdownColor: const Color.fromRGBO(20, 20, 20, 1),
            style: GoogleFonts.orbitron(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.pinkAccent),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
            validator: (value) {
              if (value == null) {
                return 'Campo obrigatório';
              }
              return null;
            },
            items: items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(itemLabel(item)),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView() {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(10, 10, 10, 0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.greenAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withAlpha(80),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.greenAccent,
              size: 64,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.budgetSuccess,
            textAlign: TextAlign.center,
            style: GoogleFonts.orbitron(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.budgetSuccessMessage,
            textAlign: TextAlign.center,
            style: GoogleFonts.orbitron(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}