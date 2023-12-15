// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rmcheckin/app/pages/register/foto_motorista/foto_motorista.dart';
import 'package:rmcheckin/app/services/registrar_veiculo_service.dart';
import 'package:rmcheckin/app/services/tipo_veiculo_service.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class RegisterDadosCaminhao extends StatefulWidget {
  final String cpf;
  final String email;
  final String telefone;
  final String nome;
  final String password;
  const RegisterDadosCaminhao({
    Key? key,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.nome,
    required this.password,
  }) : super(key: key);

  @override
  State<RegisterDadosCaminhao> createState() => _RegisterDadosCaminhaoState();
}

class _RegisterDadosCaminhaoState extends State<RegisterDadosCaminhao> {
  bool _showPassword = false;

  final TextEditingController placaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<List<String>> tiposCaminhao = ValueNotifier([]);
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
  void initState() {
    super.initState();
    _fetchTiposCaminhao();
  }

  Future<void> _fetchTiposCaminhao() async {
    try {
      final tipos = await TipoVeiculoService().tipoVeiculo();
      tiposCaminhao.value = tipos as List<String>;
    } catch (e) {
      // Trate erros, se necessário
      print('Erro ao buscar tipos de veículos: $e');
    }
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
                SizedBox(
                  height: 0,
                ),
                const SizedBox(
                  height: 150,
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
                              registrarVeiculo(
                                cpf: widget.cpf,
                                placa: placaController.text,
                                tipo: dropValue.value.toString(),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FotoMotorista(
                                    cpf: widget.cpf,
                                    email: widget.email,
                                    password: widget.password,
                                    telefone: widget.telefone,
                                    nome: widget.nome,
                                  ),
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
