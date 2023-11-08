import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/pages/alterar_senha/alterar_senha.dart';
import 'package:rmcheckin/app/pages/input/input_screen.dart';
import 'package:rmcheckin/app/widget/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
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

  bool isSwitched = false;
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Notificações",
              style: GoogleFonts.dosis(
                textStyle: TextStyle(
                  color: darkBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Perfimitir notificações na tela bloqueada',
                  style: GoogleFonts.dosis(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Expanded(
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(
                          () {
                            isSwitched = value;
                          },
                        );
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                'Acesso',
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(
                    color: darkBlueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: SizedBox(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: yellowColor, minimumSize: const Size(double.infinity, 50)),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AlterarSenha()));
                          },
                          child: Text(
                            'Alterar senha',
                            style: GoogleFonts.dosis(
                              textStyle: const TextStyle(color: Colors.black, fontSize: 17),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
