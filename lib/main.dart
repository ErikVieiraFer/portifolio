// main.dart
import 'package:flutter/material.dart';
import 'package:portfolio_flutter/pages/home_page.dart';
// import 'package:portfolio_flutter/widgets/about_me.dart';
// import 'package:portfolio_flutter/widgets/contacts.dart';
// import 'package:portfolio_flutter/widgets/projects.dart';
// import 'package:portfolio_flutter/widgets/header.dart';
// import 'package:scroll_to_index/scroll_to_index.dart'; // Adicione esta linha

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfólio Anos 80',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'PressStart2P', // Adicione esta fonte no pubspec.yaml
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.pink, fontSize: 40),
          bodyLarge: TextStyle(color: Colors.cyan, fontSize: 16),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
