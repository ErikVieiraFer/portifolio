import 'package:portfolio_flutter/core/models/project_model.dart';

final projectsList = [
  Project(
    title: 'TechTaste',
    description:
        'Aplicativo Flutter para avaliação de restaurantes e pratos, com interface moderna e integração com mapas.',
    imagePath: 'assets/images/projects/techtaste.jpeg',
    githubUrl: 'https://github.com/ErikVieiraFer/TechTaste',
    demoUrl: 'https://erikvieirafer.github.io/TechTaste/',
    techs: ['Flutter', 'Google Maps', 'Firebase', 'BLoC'],
  ),
  Project(
    title: 'DaiAIlog',
    description:
        'O app usa a API do Google Gemini para gerar perguntas personalizadas, projetadas para facilitar o networking em eventos.',
    imagePath: 'assets/images/projects/diailog.jpeg',
    githubUrl: 'https://github.com/ErikVieiraFer/diailog',
    demoUrl: 'https://erikvieirafer.github.io/diailog/',
    techs: ['Flutter', 'Gemini AI', 'Material Design'],
  ),
  Project(
    title: 'Calculadora de IMC',
    description:
        'App simples desenvolvido em Flutter para cálculo de IMC. Interface amigável e lógica bem estruturada.',
    imagePath: 'assets/images/projects/bmicalculator.jpeg',
    githubUrl: 'https://github.com/ErikVieiraFer/imc_state_manager',
    demoUrl: 'https://erikvieirafer.github.io/imc_state_manager/',
    techs: ['Flutter', 'State Management', 'Responsive'],
  ),
  Project(
    title: 'Site do Grupo Resiliência',
    description:
        'Site institucional para o Grupo Resiliência, que oferece apoio e orientação a famílias, conectando dependentes químicos à clínica de reabilitação ideal para sua jornada de recuperação e superação.',
    imagePath: 'assets/images/projects/site-resiliencia.jpeg',
    demoUrl: 'https://fsresiliencia.com.br/',
    techs: ['HTML', 'CSS', 'JavaScript'],
  ),
  Project(
    title: 'EasyWheight',
    description:
        'Aplicativo de controle de estoque desenvolvido para a Conquant Inteligencia Economica,  Permite o registo de produtos offline, com captura automática das informações dos produtos via balanças Bluetooth. Os dados são sincronizados com um servidor central (Python/Django) quando online, garantindo controlo total do estoque.',
    imagePath: 'assets/images/projects/easyweigh.jpeg',
    isDraft: true,
    techs: ['Flutter', 'Python', 'Django', 'Bluetooth', 'SQLite'],
  ),
];
