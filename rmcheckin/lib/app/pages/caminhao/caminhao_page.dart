import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/models/motorista_auth_model.dart';
import 'package:rmcheckin/app/pages/caminhao/teste.dart';
import 'package:rmcheckin/app/services/registrar_veiculo_service.dart';
import 'package:rmcheckin/app/services/tipo_veiculo_service.dart';
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

  final TextEditingController placaController = TextEditingController();
  Future<void> _fetchTiposCaminhao() async {
    try {
      final tipos = await TipoVeiculoService().tipoVeiculo();
      tiposCaminhao.value = tipos as List<String>;
    } catch (e) {
      // Trate erros, se necessário
      print('Erro ao buscar tipos de veículos: $e');
    }
  }

  final ValueNotifier<List<String>> tiposCaminhao = ValueNotifier([]);
  final dropValue = ValueNotifier('');

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
              padding: const EdgeInsets.only(left: 2.0, right: 2),
              child: ValueListenableBuilder<List<String>>(
                valueListenable: tiposCaminhao,
                builder: (BuildContext context, List<String> tipos, _) {
                  return DropdownButtonFormField<String>(
                    isExpanded: true,
                    hint: const Text("Selecione o tipo veiculo"),
                    value: dropValue.value.isNotEmpty ? dropValue.value : null,
                    onChanged: (escolha) {
                      dropValue.value = escolha.toString();
                    },
                    items: tipos
                        .map((tipo) => DropdownMenuItem(
                              value: tipo,
                              child: Text(tipo),
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TextFormField(
                controller: placaController,
                inputFormatters: [
                  PlacaVeiculoInputFormatter(),
                ],
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Digite a placa do caminhao",
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            TextButton(
              child: Text(
                'Concluir',
                style: GoogleFonts.dosis(
                    textStyle: TextStyle(
                  fontSize: 17,
                  color: darkBlueColor,
                  fontWeight: FontWeight.bold,
                )),
              ),
              onPressed: () {
                if (dropValue.value.isNotEmpty) {
                  registrarVeiculo(
                    cpf: user!.cpf,
                    placa: placaController.text,
                    tipo: dropValue.value.isNotEmpty ? dropValue.value : "Valor Padrão ou Tratamento Adequado",
                  );
                  Navigator.pop(context);
                } else {
                  print('Erro: Tipo de veículo não pode ser vazio.');
                }
              },
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
        _fetchTiposCaminhao();
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
        title: Image.asset(
          'assets/Captura de tela 2023-09-19 181800.png',
          fit: BoxFit.contain,
          height: 62,
        ),
        centerTitle: true,
      ),
      body: user != null ? VeiculoRedeCard(motorista: user!) : const CircularProgressIndicator(),
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
