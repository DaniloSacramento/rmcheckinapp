import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rmcheckin/app/pages/register/foto_motorista/foto_motorista.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class RegisterDadosCaminhao extends StatefulWidget {
  const RegisterDadosCaminhao({super.key});

  @override
  State<RegisterDadosCaminhao> createState() => _RegisterDadosCaminhaoState();
}

class _RegisterDadosCaminhaoState extends State<RegisterDadosCaminhao> {
  bool _showPassword = false;

  final TextEditingController nameInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController confirmarSenha = TextEditingController();

  TextEditingController suaSenha = TextEditingController();

  final dropValue = ValueNotifier('');
  final dropOpcoes = ['Caminhao', 'Carro', 'Moto', 'Bicicleta'];
  bool isLoading = false;

  File? _image;
  Future _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Image.asset(
          'assets/Captura de tela 2023-09-19 181800.png',
          fit: BoxFit.contain,
          height: 62,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Dados do caminhao',
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(color: darkBlueColor, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text(
                    'Placa do caminhao',
                    style: GoogleFonts.dosis(
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: darkBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: nameInputController,
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
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text(
                    'Tipo do caminhao',
                    style: GoogleFonts.dosis(
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: darkBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2),
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
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text(
                    'Foto do caminhao',
                    style: GoogleFonts.dosis(
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: darkBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkBlueColor,
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                  ),
                  onPressed: _getImage,
                  label: const Text(
                    'Tirar foto',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellowColor,
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FotoMotorista(),
                                ),
                              );
                            },
                      child: isLoading
                          ? const CircularProgressIndicator() // Mostrar indicador de carregamento
                          : Text(
                              "Continuar",
                              style: GoogleFonts.dosis(
                                textStyle: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
