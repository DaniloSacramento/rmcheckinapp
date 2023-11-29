import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/pages/login/login_page.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class FotoMotorista extends StatefulWidget {
  const FotoMotorista({super.key});

  @override
  State<FotoMotorista> createState() => _FotoMotoristaState();
}

class _FotoMotoristaState extends State<FotoMotorista> {
  @override
  Widget build(BuildContext context) {
    double telaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: darkBlueColor,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: telaHeight * 0.1,
            ),
            Center(
              child: Text(
                'Estamos quase lá!',
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(color: darkBlueColor, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: telaHeight * 0.055,
            ),
            Text(
              'Agora, precisamos de uma foto sua \n tudo bem?',
              style: GoogleFonts.dosis(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: telaHeight * 0.055,
            ),
            Text(
              'Tire uma selfie com a camera \nposicionada a frente de seu rosto e \nombros',
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
              height: telaHeight * 0.097,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ),
                  ),
                  child: Text(
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
