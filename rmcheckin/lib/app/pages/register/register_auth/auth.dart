// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/pages/login/login_page.dart';
import 'package:rmcheckin/app/pages/register/register_codigo/register_codigo_page.dart';
import 'package:rmcheckin/app/pages/register/register_email/register_email_auth.dart';
import 'package:rmcheckin/app/services/registrar_service.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class Auth extends StatefulWidget {
  final String cpf;
  final String email;
  final String telefone;
  final String tipoValidacao;
  const Auth({
    Key? key,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.tipoValidacao,
  }) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool primeiroItem = false;
  bool segundoItem = false;
  double opacity = 0.0;
  void desmarcarPrimeiroCheckbox() {
    setState(() {
      primeiroItem = false;
    });
  }

  String maskEmail(String email) {
    int atIndex = email.indexOf('@');
    String username = email.substring(0, 3);
    String domain = email.substring(atIndex);
    String maskedUsername = username + '*' * (email.length - atIndex - 3);
    return maskedUsername + domain;
  }

  String maskPhoneNumber(String phoneNumber) {
    return '${phoneNumber.substring(0, 4)} ****${phoneNumber.substring(phoneNumber.length - 2)}';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Autenticar por:',
              style: GoogleFonts.dosis(
                textStyle: TextStyle(color: darkBlueColor, fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                  value: primeiroItem,
                  onChanged: (value) {
                    setState(
                      () {
                        primeiroItem = value!;
                        if (value) {
                          segundoItem = false;
                        }
                      },
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Row(
                        children: [
                          const Icon(Icons.phone),
                          Text(
                            'SMS',
                            style: GoogleFonts.dosis(
                              textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        maskPhoneNumber(widget.telefone),
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                  value: segundoItem,
                  onChanged: (value) {
                    setState(() {
                      segundoItem = value!;
                      if (segundoItem) {
                        desmarcarPrimeiroCheckbox();
                      }
                    });
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Row(
                        children: [
                          const Icon(Icons.email),
                          Text(
                            'E-MAIL',
                            style: GoogleFonts.dosis(
                              textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        maskEmail(widget.email),
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: AnimatedOpacity(
                opacity: primeiroItem || segundoItem ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    if (primeiroItem && segundoItem) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Por favor, escolha apenas uma opção.',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      bool apiResponseSuccessful = false;
                      if (primeiroItem) {
                        apiResponseSuccessful = await registrarUser(
                          cpf: widget.cpf,
                          email: widget.email,
                          telefone: widget.telefone,
                          tipoValidacao: "sms",
                        );
                        if (apiResponseSuccessful) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterCodigo(
                                telefone: widget.telefone,
                                cpf: widget.cpf,
                                email: widget.email,
                                tipoValidacao: 'sms',
                              ),
                            ),
                          );
                        }
                      } else if (segundoItem) {
                        apiResponseSuccessful = await registrarUser(
                          cpf: widget.cpf,
                          email: widget.email,
                          telefone: widget.telefone,
                          tipoValidacao: "email",
                        );
                        if (apiResponseSuccessful) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterEmailAuth(
                                telefone: widget.telefone,
                                cpf: widget.cpf,
                                email: widget.email,
                                tipoValidacao: 'email',
                              ),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text('Continuar'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateOpacity() {
    setState(() {
      opacity = (primeiroItem || segundoItem) ? 1.0 : 0.0;
    });
  }
}
