// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/pages/login/login_page.dart';
import 'package:rmcheckin/app/pages/register/register_codigo/register_codigo_page.dart';
import 'package:rmcheckin/app/pages/register/register_email/register_email_auth.dart';

import 'package:rmcheckin/app/widget/app_color.dart';

class Auth extends StatefulWidget {
  final String cpf;
  final String email;
  final String telefone;
  const Auth({
    Key? key,
    required this.cpf,
    required this.email,
    required this.telefone,
  }) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool primeiroValor = false;
  bool segundoValor = false;
  double opacity = 0.0;
  void desmarcarPrimeiroCheckbox() {
    setState(() {
      primeiroValor = false;
    });
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
                  value: primeiroValor,
                  onChanged: (value) {
                    setState(() {
                      primeiroValor = value!;
                      if (value!) {
                        segundoValor = false; // Desmarca o segundo checkbox se o primeiro for marcado
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
                        '*' * (widget.telefone.length - 4) + widget.telefone.substring(widget.telefone.length - 4),
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                  value: segundoValor,
                  onChanged: (value) {
                    setState(() {
                      segundoValor = value!;
                      if (segundoValor) {
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
                        widget.email.substring(0, 5) + '*' * (widget.email.length - 5),
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: AnimatedOpacity(
                opacity: primeiroValor || segundoValor ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    if (primeiroValor && segundoValor) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Por favor, escolha apenas uma opção.',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (primeiroValor) {
                      // Navegar para a página SMS
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterCodigo(telefone: widget.telefone)),
                      );
                    } else if (segundoValor) {
                      // Navegar para a página E-MAIL
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterEmailAuth()),
                      );
                    }
                  },
                  child: Text('Continuar'),
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
      opacity = (primeiroValor || segundoValor) ? 1.0 : 0.0;
    });
  }
}
