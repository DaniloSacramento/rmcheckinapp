import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/pages/home/pages/checkin_page/selecionar_veiculo_page.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class IniciarCheckin extends StatefulWidget {
  const IniciarCheckin({super.key});

  @override
  State<IniciarCheckin> createState() => _IniciarCheckinState();
}

class _IniciarCheckinState extends State<IniciarCheckin> {
  bool primeiroItem = false;
  bool segundoItem = false;
  double opacity = 0.0;
  void desmarcarPrimeiroCheckbox() {
    setState(() {
      primeiroItem = false;
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
            Text(
              'Iniciando um novo Checkin',
              style: GoogleFonts.dosis(
                textStyle: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Selecionar a Loja para Checkin:',
              style: GoogleFonts.dosis(
                textStyle: TextStyle(color: darkBlueColor, fontSize: 22, fontWeight: FontWeight.bold),
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
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Row(
                    children: [
                      Text(
                        'Carpina Centro',
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(''),
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
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Row(
                    children: [
                      Text(
                        'Vitoria',
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(''),
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
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelecionarVeiculo()));
                    },
                    child: Text('Continuar'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
