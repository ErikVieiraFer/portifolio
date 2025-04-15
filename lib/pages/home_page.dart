import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/about_me.dart';
import '../widgets/projects.dart';
import '../widgets/contacts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: SingleChildScrollView(
        child: Column(
          children: const [Header(), AboutMe(), Projects(), Contacts()],
        ),
      ),
    );
  }
}
