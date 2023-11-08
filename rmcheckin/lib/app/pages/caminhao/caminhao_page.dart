import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final dropValue = ValueNotifier('');
  final dropOpcoes = ['Caminhao', 'Carro', 'Moto', 'Bicicleta'];
  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Adicione um novo veiculo',
            style: GoogleFonts.dosis(
                textStyle: TextStyle(
              fontSize: 26,
              color: darkBlueColor,
              fontWeight: FontWeight.bold,
            )),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: ValueListenableBuilder(
                valueListenable: dropValue,
                builder: (BuildContext context, String value, _) {
                  return DropdownButtonFormField<String>(
                    isExpanded: true,
                    hint: const Text("Selecione o tipo veiculo"),
                    value: (value.isEmpty) ? null : value,
                    onChanged: (escolha) {
                      dropValue.value = escolha.toString();
                    },
                    items: dropOpcoes
                        .map((op) => DropdownMenuItem(
                              value: op,
                              child: Text(op),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextFormField(),
            ),
            TextButton(
              child: Text(
                'Cancelar',
                style: GoogleFonts.dosis(
                    textStyle: TextStyle(
                  fontSize: 17,
                  color: darkBlueColor,
                  fontWeight: FontWeight.bold,
                )),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: yellowColor,
        onPressed: () async {
          _showExitConfirmationDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
