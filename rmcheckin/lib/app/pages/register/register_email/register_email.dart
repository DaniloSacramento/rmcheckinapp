import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rmcheckin/app/pages/register/register_codigo/register_codigo_page.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController telefoneController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  var maskformaterCpf = MaskTextInputFormatter(
    mask: '###.###.###.##',
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: darkBlueColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 200));
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Antes de tudo,\nvamos criar\nsua conta.",
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(color: darkBlueColor, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Informe seu numero de CPF",
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: darkBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: cpfController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [maskformaterCpf],
                  cursorColor: Colors.black,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite um numero de cpf válido';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "000.000.000-00",
                    prefixIcon: const Icon(
                      Icons.login,
                      color: Colors.grey,
                    ),
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
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Informe seu email",
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: darkBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.black,
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Por favor, insira um e-mail.';
                    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
                      return 'Digite um email válido';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "exemplo@exemplo.com",
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
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
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Informe seu numero de telefone",
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: darkBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  controller: telefoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [maskFormatter],
                  cursorColor: Colors.black,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Digite um numero de telefone válido';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "(00) 00000-0000",
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.grey,
                    ),
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
                  height: 40,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: yellowColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              isLoading = true;
                            });
                            setState(() {
                              isLoading = false;
                            });

                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterCodigo(),
                                ),
                              );
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator() // Mostrar indicador de carregamento
                        : Text(
                            'Continuar',
                            style: GoogleFonts.dosis(
                              textStyle: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
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