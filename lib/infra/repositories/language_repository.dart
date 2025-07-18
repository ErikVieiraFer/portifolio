import 'package:portfolio_flutter/core/models/language.dart';

class LanguageRepository {
  // No futuro, este método pode buscar dados de uma API ou arquivo local.
  Future<List<Language>> getLanguages() async {
    // Simulando uma pequena espera, como se fosse uma chamada de rede.
    await Future.delayed(const Duration(milliseconds: 100));

    return const [
      Language(
        name: 'Flutter',
        logoAsset: 'assets/logos/flutter.png',
      ),
      Language(name: 'Dart', logoAsset: 'assets/logos/dart.png'),
    ];
  }
}