import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlService {
  /// Lança uma URL no navegador externo
  /// Retorna true se teve sucesso, false caso contrário
  static Future<bool> launchURL(String url, BuildContext context) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (!context.mounted) return false;
        _showError(context, 'Não foi possível abrir o link');
        return false;
      }
    } catch (e) {
      if (!context.mounted) return false;
      _showError(context, 'Erro ao processar URL: $e');
      return false;
    }
  }

  /// Mostra um SnackBar de erro
  static void _showError(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
    }
  }

  /// Lança email com mailto
  static Future<bool> launchEmail(String email, BuildContext context) async {
    return await launchURL('mailto:$email', context);
  }

  /// Lança WhatsApp
  static Future<bool> launchWhatsApp(String phone, BuildContext context) async {
    // Remove caracteres especiais do telefone
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    return await launchURL('https://wa.me/$cleanPhone', context);
  }

  /// Lança URL genérica do GitHub
  static Future<bool> launchGitHub(String username, BuildContext context) async {
    return await launchURL('https://github.com/$username', context);
  }
}