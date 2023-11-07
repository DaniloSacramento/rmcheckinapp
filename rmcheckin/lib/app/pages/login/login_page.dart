import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rmcheckin/app/pages/esqueci_senha/esqueci_senha_page.dart';
import 'package:rmcheckin/app/pages/home/home_page.dart';
import 'package:rmcheckin/app/services/auth_motorista_service.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final cpfController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  var maskformaterCpf = MaskTextInputFormatter(
    mask: '###.###.###.##',
    type: MaskAutoCompletionType.lazy,
  );
  bool showEmailField = true;
  bool showTelefoneField = false;
  bool showCpfField = false;
  bool isLoading = false;
  bool _showPassword = false;
  bool _isLoading = false;
  final dropValue = ValueNotifier('');
  final dropOpcoes = ['E-mail', 'Telefone', 'CPF'];
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();
  final senhaController = TextEditingController();
  bool validarSenha(String senha) {
    if (senha.length < 6) {
      return false;
    }

    if (!senha.contains(RegExp(r'\d'))) {
      return false;
    }

    if (!senha.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    if (!senha.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    if (!senha.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    if (senha.contains(RegExp(r'\s'))) {
      return false;
    }

    return true;
  }

  bool isCPFValid(String cpf) {
    if (cpf == null || cpf.isEmpty) {
      return false;
    }
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (cpf.length != 11) {
      return false;
    }
    if (cpf.runes.toSet().length == 1) {
      return false;
    }
    int soma = 0;
    for (int i = 0; i < 9; i++) {
      soma += int.parse(cpf[i]) * (10 - i);
    }
    int primeiroDigito = (soma * 10) % 11;

    if (primeiroDigito != int.parse(cpf[9])) {
      return false;
    }
    soma = 0;
    for (int i = 0; i < 10; i++) {
      soma += int.parse(cpf[i]) * (11 - i);
    }
    int segundoDigito = (soma * 10) % 11;
    return segundoDigito == int.parse(cpf[10]);
  }

  @override
  Widget build(BuildContext context) {
    double telaHeight = MediaQuery.of(context).size.height;
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
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 15,
                ),
                child: Text("Seja, bem-vindo!",
                    style: GoogleFonts.dosis(
                      textStyle: TextStyle(
                        fontSize: 24,
                        color: darkBlueColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              )
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: telaHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: ValueListenableBuilder(
                    valueListenable: dropValue,
                    builder: (BuildContext context, String value, _) {
                      return DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: const Text("Selecione a forma de login"),
                        value: (value.isEmpty) ? null : value,
                        onChanged: (escolha) {
                          dropValue.value = escolha.toString();

                          setState(() {
                            showEmailField = escolha == 'E-mail';
                            showTelefoneField = escolha == 'Telefone';
                            showCpfField = escolha == 'CPF';
                          });
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
                // Campo de E-mail
                if (showEmailField)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        hintStyle: GoogleFonts.dosis(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Por favor, insira um e-mail.';
                        } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
                          return 'Digite um e-mail correto ';
                        }
                        return null;
                      },
                    ),
                  ),

                if (showTelefoneField)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: TextFormField(
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
                  ),
                // Campo de CPF
                if (showCpfField)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: TextFormField(
                      controller: cpfController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [maskformaterCpf],
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite um CPF válido';
                        }
                        if (!isCPFValid(value)) {
                          return 'CPF inválido';
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
                  ),
                // Campo de Senha
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      hintStyle: GoogleFonts.dosis(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: GestureDetector(
                        child: Icon(_showPassword == false ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.grey[300],
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                    ),
                    obscureText: !_showPassword ? true : false,
                    controller: senhaController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira uma senha.';
                      }
                      if (!validarSenha(value)) {
                        return 'A senha não atende aos critérios de validação.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EsqueciSenha(),
                              ));
                        },
                        child: Text(
                          "Esqueceu sua senha",
                          style: GoogleFonts.dosis(
                            textStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: yellowColor,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: _isLoading
                            ? null
                            : () async {
                                FocusScope.of(context).unfocus();

                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  bool deuCerto = (await login(
                                    emailController.text,
                                    senhaController.text,
                                    // telefoneController.text,
                                  ));
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }

                                  if (deuCerto) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const HomePage(),
                                        ),
                                        (r) => false);
                                  } else {
                                    senhaController.clear();

                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                        child: _isLoading
                            ? const CircularProgressIndicator() // Exibe o indicador de progresso.
                            : Text(
                                'Entrar',
                                style: GoogleFonts.dosis(
                                  textStyle: const TextStyle(color: Colors.black, fontSize: 17),
                                ),
                              ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const snackBar = SnackBar(
  content: Text(
    'E-mail ou senha são inválidos',
    textAlign: TextAlign.center,
  ),
  backgroundColor: Colors.red,
);
