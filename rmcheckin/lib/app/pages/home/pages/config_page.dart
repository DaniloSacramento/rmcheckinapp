import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/pages/input/input_screen.dart';
import 'package:rmcheckin/app/widget/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});
  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Impede o fechamento do diálogo ao tocar fora dele
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Sair do aplicativo?',
            style: GoogleFonts.dosis(
                textStyle: TextStyle(
              fontSize: 26,
              color: darkBlueColor,
              fontWeight: FontWeight.bold,
            )),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Tem certeza de que deseja sair do aplicativo?',
                  style: GoogleFonts.dosis(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
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
            TextButton(
              child: Text(
                'Sair',
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(
                    fontSize: 17,
                    color: darkBlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () async {
                bool saiu = await sair();
                if (saiu) {
                  Navigator.of(context).pop(); // Fecha o diálogo
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InputScreen(),
                    ),
                  );
                }
              },
            ),
          ],
        );
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: yellowColor,
        onPressed: () async {
          _showExitConfirmationDialog(context);
        },
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}
