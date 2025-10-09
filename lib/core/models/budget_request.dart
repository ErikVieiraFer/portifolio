class BudgetRequest {
  final String name;
  final String email;
  final ProjectType projectType;
  final BudgetRange budgetRange;
  final String description;

  const BudgetRequest({
    required this.name,
    required this.email,
    required this.projectType,
    required this.budgetRange,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'projectType': projectType.label,
      'budgetRange': budgetRange.label,
      'description': description,
    };
  }
}

enum ProjectType {
  mobileApp('Aplicativo Mobile'),
  webApp('Aplicação Web'),
  landingPage('Landing Page / Site Institucional'),
  ecommerce('E-commerce'),
  automation('Automação / Sistema Interno'),
  maintenance('Manutenção de Projeto Existente'),
  other('Outro');

  final String label;
  const ProjectType(this.label);
}

enum BudgetRange {
  micro('Até R\$ 2.000'),
  small('R\$ 2.000 - R\$ 5.000'),
  medium('R\$ 5.000 - R\$ 10.000'),
  large('R\$ 10.000 - R\$ 20.000'),
  enterprise('Acima de R\$ 20.000'),
  notSure('Não tenho certeza');

  final String label;
  const BudgetRange(this.label);
}