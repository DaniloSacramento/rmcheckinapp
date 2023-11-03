import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmcheckin/app/models/motorista_auth_model.dart';
import 'package:rmcheckin/app/widget/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Motorista? user;
  motoristaUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getString('data');
    setState(() {
      user = Motorista.fromMap(jsonDecode(result!)['data']);
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
      body: Column(
        children: [Text(user!.cpf)],
      ),
    );
  }
}
