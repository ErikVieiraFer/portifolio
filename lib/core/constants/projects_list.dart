import 'package:portfolio_flutter/core/models/project_model.dart';

final projectsList = [
  Project(
    title: 'AlanoCrypto',
    description:
        'App Flutter de comunidade de trading com chat real-time, sinais de mercado, dados financeiros via APIs e painel admin React.',
    imagePath: 'assets/images/projects/alanocrypto.jpg',
    demoUrl: 'https://alanocryptofx.com.br/',
    techs: ['Flutter', 'Firebase', 'React', 'Node'],
  ),
  Project(
    title: 'TechTaste',
    description:
        'Aplicativo Flutter para avaliação de restaurantes e pratos, com interface moderna e integração com mapas.',
    imagePath: 'assets/images/projects/techtaste.jpeg',
    githubUrl: 'https://github.com/ErikVieiraFer/TechTaste',
    techs: ['Flutter', 'Google Maps', 'Firebase', 'BLoC'],
  ),
  Project(
    title: 'DaiAIlog',
    description:
        'O app usa a API do Google Gemini para gerar perguntas personalizadas, projetadas para facilitar o networking em eventos.',
    imagePath: 'assets/images/projects/diailog.jpg',
    githubUrl: 'https://github.com/ErikVieiraFer/diailog',
    techs: ['Flutter', 'Gemini AI', 'Material Design'],
  ),
  Project(
    title: 'Calculadora de IMC',
    description:
        'App simples desenvolvido em Flutter para cálculo de IMC. Interface amigável e lógica bem estruturada.',
    imagePath: 'assets/images/projects/bmicalculator.jpg',
    githubUrl: 'https://github.com/ErikVieiraFer/imc_state_manager',
    demoUrl: 'https://erikvieirafer.github.io/imc_state_manager/',
    techs: ['Flutter', 'State Management', 'Responsive'],
  ),
  Project(
    title: 'Site do Grupo Resiliência',
    description:
        'Site institucional para o Grupo Resiliência, que oferece apoio e orientação a famílias, conectando dependentes químicos à clínica de reabilitação ideal para sua jornada de recuperação e superação.',
    imagePath: 'assets/images/projects/site-resiliencia.jpg',
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
