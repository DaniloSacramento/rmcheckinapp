import 'package:flutter/material.dart';
import 'package:rmcheckin/app/pages/login/login_page.dart';
import 'package:rmcheckin/app/pages/register/register_dados/register_dados.dart';
import 'package:rmcheckin/app/widget/app_color.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    double telaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBlueColor,
        title: Image.asset(
          'assets/Captura de tela 2023-09-19 181800.png',
          fit: BoxFit.contain,
          height: 62,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: telaHeight * 0.18,
              ),
              Image.asset("assets/foto1tela.jpeg"),
              SizedBox(
                height: telaHeight * 0.18,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    minimumSize: const Size(double.infinity, 50), // Largura total e altura mínima
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPhone(),
                      ),
                    );
                  },
                  child: Text('Quero me cadastrar'),
                ),
              ),
              SizedBox(
                height: telaHeight * 0.015,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: const Size(double.infinity, 50), // Largura total e altura mínima
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Já tenho conta'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
