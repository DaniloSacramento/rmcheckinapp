import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/pages/home/pages/checkin_page/adicionar_key.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class SelecionarVeiculo extends StatefulWidget {
  const SelecionarVeiculo({super.key});

  @override
  State<SelecionarVeiculo> createState() => _SelecionarVeiculoState();
}

class _SelecionarVeiculoState extends State<SelecionarVeiculo> {
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
            const SizedBox(
              height: 30,
            ),
            Text(
              'Selecione o seu Veiculo:',
              style: GoogleFonts.dosis(
                textStyle: TextStyle(color: darkBlueColor, fontSize: 24, fontWeight: FontWeight.bold),
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
                        'KKK-0991',
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'TOCO',
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
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
                        'KKK-0889',
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Truck',
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(''),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.add),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                  ),
                  onPressed: () {},
                  child: Text('Novo Veiculo'),
                ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AdicionarKey()));
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
