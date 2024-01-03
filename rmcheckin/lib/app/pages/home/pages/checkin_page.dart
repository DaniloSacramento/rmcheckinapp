import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rmcheckin/app/const/const.dart';
import 'package:rmcheckin/app/models/tipo_veiculo.dart';
import 'package:http/http.dart' as http;
import 'package:rmcheckin/app/pages/home/pages/checkin_page/iniciar_checkin_page.dart';
import 'package:rmcheckin/app/services/lojas_checkin.dart';
import 'package:rmcheckin/app/widget/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/motorista_auth_model.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  Motorista? user;
  motoristaUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getString("data");
    setState(() {
      user = Motorista.fromMap(jsonDecode(result!)["data"]);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        motoristaUser();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String nomeCompleto = user!.nome;
    List<String> partesDoNome = nomeCompleto.split(' ');
    String primeiroNome = partesDoNome.isNotEmpty ? partesDoNome[0] : '';
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, $primeiroNome',
                  style: GoogleFonts.dosis(
                    textStyle: TextStyle(fontSize: 26, color: darkBlueColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'Checkin em 19/12/2023',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: yellowColor,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const IniciarCheckin()));
              },
              child: Text(
                'Iniciar um novo Checkin',
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(fontSize: 18, color: darkBlueColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loja',
                      style: GoogleFonts.dosis(
                        textStyle: TextStyle(fontSize: 18, color: darkBlueColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text('Recife'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Checkin',
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(fontSize: 18, color: darkBlueColor, fontWeight: FontWeight.bold),
                        )),
                    const Text('KKK-0099'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Data',
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(fontSize: 18, color: darkBlueColor, fontWeight: FontWeight.bold),
                        )),
                    const Text('19/12/2023\nas 11:30'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status',
                        style: GoogleFonts.dosis(
                          textStyle: TextStyle(fontSize: 18, color: darkBlueColor, fontWeight: FontWeight.bold),
                        )),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 380,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Card(
                  elevation: 10,
                  child: ListView(scrollDirection: Axis.horizontal, children: const [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.timer_sharp, color: Colors.red),
                            Text(
                              'Aguardando\nValidacao das\nNF-es',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.device_hub_outlined,
                              color: Colors.blue,
                            ),
                            Text(
                              'Em conferencia',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            Text(
                              'Finalizado',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.fire_truck_outlined,
                              color: Colors.black,
                            ),
                            Text('Veiculo no Patio'),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
