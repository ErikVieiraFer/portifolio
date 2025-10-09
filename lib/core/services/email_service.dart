import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:portfolio_flutter/core/models/budget_request.dart';

class EmailService {
  // ⚠️ CONFIGURAÇÃO NECESSÁRIA
  // 1. Crie uma conta gratuita em https://www.emailjs.com/
  // 2. Crie um template de email
  // 3. Substitua os valores abaixo com seus dados reais:
  
  static const String _serviceId = 'service_m14d9jt';
  static const String _templateId = 'template_n85n44o';
  static const String _publicKey = 'Zg6QMaBQxSKdoGsHx';
  static const String _emailJsUrl = 'https://api.emailjs.com/api/v1.0/email/send';

  /// Envia o formulário de orçamento por email
  /// Retorna true se enviado com sucesso, false caso contrário
  Future<bool> sendBudgetRequest(BudgetRequest request) async {
    try {
      final templateParams = {
        'from_name': request.name,
        'from_email': request.email,
        'project_type': request.projectType.label,
        'budget_range': request.budgetRange.label,
        'message': request.description,
        'to_email': 'erik.vieiradev@hotmail.com', // Seu email
      };

      final response = await http.post(
        Uri.parse(_emailJsUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey,
          'template_params': templateParams,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Erro ao enviar email: $e');
      return false;
    }
  }

  /// Validação simples de email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}