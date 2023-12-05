import 'package:flutter/material.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class AlterarDadosPage extends StatelessWidget {
  const AlterarDadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: darkBlueColor,
        title: Image.asset(
          'assets/Captura de tela 2023-09-19 181800.png',
          fit: BoxFit.contain,
          height: 62,
        ),
        centerTitle: true,
      ),
    );
  }
}
