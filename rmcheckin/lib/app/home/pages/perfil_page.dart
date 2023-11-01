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
  _getUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getString("data");
    if (result != null) {
      setState(() {
        user = Motorista.fromMap(jsonDecode(result)["data"]);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _getUser();
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
          ? Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 170,
                      child: Image.network(user!.nome), // Use user's foto as the image URL
                    ),
                  ],
                ),
                // Display other user data as needed
              ],
            )
          : const Center(
              child: CircularProgressIndicator(), // Show a loading indicator while data is being fetched
            ),
    );
  }
}
