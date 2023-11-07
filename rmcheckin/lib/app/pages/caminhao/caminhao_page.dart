import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmcheckin/app/models/motorista_auth_model.dart';
import 'package:rmcheckin/app/pages/caminhao/teste.dart';
import 'package:rmcheckin/app/widget/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaminhaoPage extends StatefulWidget {
  const CaminhaoPage({super.key});

  @override
  State<CaminhaoPage> createState() => _CaminhaoPageState();
}

class _CaminhaoPageState extends State<CaminhaoPage> {
  Motorista? user;

  motoristaUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getString("data");
    setState(() {
      user = Motorista.fromMap(jsonDecode(result!)["data"]);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        motoristaUser();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: darkBlueColor,
      ),
      body: user != null
          ? VeiculoRedeCard(motorista: user!)
          : const CircularProgressIndicator(), // Você pode mostrar um indicador de carregamento enquanto os dados estão sendo buscados.
    );
  }
}
