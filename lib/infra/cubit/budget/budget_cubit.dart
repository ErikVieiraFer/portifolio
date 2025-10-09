import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_flutter/core/models/budget_request.dart';
import 'package:portfolio_flutter/core/services/email_service.dart';
import 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  final EmailService _emailService;

  BudgetCubit({EmailService? emailService})
      : _emailService = emailService ?? EmailService(),
        super(const BudgetState());

  /// Envia o formulário de orçamento
  Future<void> submitBudget(BudgetRequest request) async {
    emit(state.copyWith(status: BudgetStatus.loading));

    try {
      final success = await _emailService.sendBudgetRequest(request);

      if (success) {
        emit(state.copyWith(status: BudgetStatus.success));
      } else {
        emit(state.copyWith(
          status: BudgetStatus.error,
          errorMessage: 'Não foi possível enviar a solicitação. Tente novamente.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: BudgetStatus.error,
        errorMessage: 'Erro ao enviar: ${e.toString()}',
      ));
    }
  }

  /// Reseta o estado para permitir novo envio
  void reset() {
    emit(const BudgetState());
  }

  /// Valida os campos do formulário
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nome é obrigatório';
    }
    if (value.trim().length < 3) {
      return 'Nome deve ter pelo menos 3 caracteres';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email é obrigatório';
    }
    if (!EmailService.isValidEmail(value.trim())) {
      return 'Email inválido';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Descrição é obrigatória';
    }
    if (value.trim().length < 20) {
      return 'Descrição deve ter pelo menos 20 caracteres';
    }
    return null;
  }
}