// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';
import 'package:rmcheckin/app/pages/register/register_dados/register_dados.dart';
import 'package:rmcheckin/app/pages/register/register_data/register_data.dart';

import 'package:rmcheckin/app/widget/app_color.dart';

class RegisterCodigo extends StatefulWidget {
  final String telefone;
  const RegisterCodigo({
    Key? key,
    required this.telefone,
  }) : super(key: key);

  @override
  State<RegisterCodigo> createState() => _RegisterCodigoState();
}

class _RegisterCodigoState extends State<RegisterCodigo> {
  bool isLoading = false;
  bool isCodeComplete = false;
  OtpTimerButtonController controller = OtpTimerButtonController();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: yellowColor),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.grey[300],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: darkBlueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Informe o codigo que \nvocê recebeu por sms",
              style: GoogleFonts.dosis(
                textStyle: TextStyle(
                  color: darkBlueColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Numero: ',
                  style: GoogleFonts.dosis(
                    textStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  '*' * (widget.telefone.length - 4) + widget.telefone.substring(widget.telefone.length - 4),
                  style: GoogleFonts.dosis(
                    textStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Pinput(
              length: 6,
              //defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              showCursor: true,
              onChanged: (code) {
                setState(() {
                  isCodeComplete = code.length == 6;
                });
              },
              // onCompleted: (pin) => print(pin),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPhone()));
                  },
                  child: const Text('Editar numero de telefone?'),
                ),
                OtpTimerButton(
                  backgroundColor: yellowColor,
                  controller: controller,
                  onPressed: () {},
                  duration: 60,
                  text: Text(
                    'Reenviar codigo',
                    style: GoogleFonts.dosis(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: isCodeComplete
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellowColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        // Adicione a lógica que deve ser executada quando o botão for pressionado
                      },
                      child: const Text('Continuar'),
                    )
                  : Container(), // Container vazio quando o código não está completo
            ),
          ],
        ),
      ),
    );
  }
}
