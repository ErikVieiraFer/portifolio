import 'package:flutter/material.dart';
import 'package:portfolio_flutter/widgets/about_me.dart';
import 'package:portfolio_flutter/widgets/contacts.dart';
import 'package:portfolio_flutter/widgets/projects.dart';

import 'widgets/header.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Portfólio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [Header(), AboutMe(), Projects(), Contacts()],
        ),
      ),
    );
  }
}
