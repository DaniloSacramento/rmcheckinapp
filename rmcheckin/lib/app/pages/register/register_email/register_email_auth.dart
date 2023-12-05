// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/pages/register/register_data/register_data.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class RegisterEmailAuth extends StatefulWidget {
  RegisterEmailAuth({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterEmailAuth> createState() => _RegisterEmailAuthState();
}

class _RegisterEmailAuthState extends State<RegisterEmailAuth> {
  bool isLoading = false;

  _RegisterEmailAuthState();

  @override
  Widget build(BuildContext context) {
    double telaHeight = MediaQuery.of(context).size.height;
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 15),
            SizedBox(
              height: telaHeight * 0.32,
            ),
            Center(
              child: Text(
                'Conta criada!',
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkBlueColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: telaHeight * 0.02,
            ),
            Text(
              'Verifique seu e-mail para valida-lo \mantes de continuar',
              style: GoogleFonts.dosis(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: telaHeight * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterData()));
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
    );
  }
}
