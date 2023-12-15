// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';
import 'package:rmcheckin/app/pages/register/register_dados/register_dados.dart';
import 'package:rmcheckin/app/pages/register/register_data/register_data.dart';
import 'package:rmcheckin/app/services/registrar_service.dart';
import 'package:rmcheckin/app/services/verificar_token_service.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class RegisterCodigo extends StatefulWidget {
  final String cpf;
  final String email;
  final String telefone;
  final String tipoValidacao;

  const RegisterCodigo({
    Key? key,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.tipoValidacao,
  }) : super(key: key);

  @override
  State<RegisterCodigo> createState() => _RegisterCodigoState();
}

class _RegisterCodigoState extends State<RegisterCodigo> {
  bool isLoading = false;
  bool isCodeComplete = false;
  OtpTimerButtonController controller = OtpTimerButtonController();
  TextEditingController otpController = TextEditingController();
  String maskPhoneNumber(String phoneNumber) {
    // Adiciona o DDD entre parênteses e mantém os dois últimos dígitos visíveis
    return '${phoneNumber.substring(0, 4)} ****' + phoneNumber.substring(phoneNumber.length - 2);
  }

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
        title: Image.asset(
          'assets/Captura de tela 2023-09-19 181800.png',
          fit: BoxFit.contain,
          height: 62,
        ),
        centerTitle: true,
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
                  maskPhoneNumber(widget.telefone),
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
              controller: otpController,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyPhone()));
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
                      onPressed: () async {
                        try {
                          final apiResponse = await VerificarTokenService().verificarToken(widget.telefone, otpController.text);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterData(
                                cpf: widget.cpf,
                                email: widget.email,
                                telefone: widget.telefone,
                              ),
                            ),
                          );
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Código Inválido',
                                  style: GoogleFonts.dosis(
                                    textStyle: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Continuar'),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
