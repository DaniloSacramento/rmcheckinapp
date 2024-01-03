import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:rmcheckin/app/const/const.dart';
import 'package:rmcheckin/app/models/motorista_auth_model.dart';
import 'package:rmcheckin/app/models/tipo_veiculo.dart';
import 'package:rmcheckin/app/pages/home/pages/checkin_page/location.sertive.dart';
import 'package:rmcheckin/app/pages/home/pages/checkin_page/selecionar_veiculo_page.dart';
import 'package:rmcheckin/app/widget/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IniciarCheckin extends StatefulWidget {
  const IniciarCheckin({super.key});

  @override
  State<IniciarCheckin> createState() => _IniciarCheckinState();
}

class _IniciarCheckinState extends State<IniciarCheckin> {
  bool primeiroItem = false;
  Future<Position?> getLocation() async {
    LocationPermission permission;

    // Check if permission is granted
    if (!await Geolocator.isLocationServiceEnabled()) {
      // Location services are not enabled
      // You might want to show a dialog to prompt the user to enable location services
      return null;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle accordingly
      return null;
    }

    if (permission == LocationPermission.denied) {
      // Request permission
      permission = await Geolocator.requestPermission();

      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // Permissions are still not granted, handle accordingly
        return null;
      }
    }

    try {
      // Try getting the location
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  bool segundoItem = false;
  double opacity = 0.0;
  Motorista? user;
  Position? currentPosition;
  List<LojaModel> lojas = [];
  List<int> lojasSelecionadas = [];
  void desmarcarPrimeiroCheckbox() {
    setState(() {
      primeiroItem = false;
    });
  }

  Future<List<LojaModel>> getLojasProximas() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final result = sharedPreferences.getString("data");
    final user = Motorista.fromMap(jsonDecode(result!)["data"]);

    currentPosition = await getLocation();

    if (currentPosition != null) {
      final response = await http.post(
        Uri.parse(ConstsApi.lojasCheckin),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': ConstsApi.basicAuth,
        },
        body: jsonEncode({
          'cpf': user.cpf,
          'latitude': currentPosition!.latitude,
          'longitude': currentPosition!.longitude,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<LojaModel> lojas = [];
        for (var lojaData in data['data']['lojas']) {
          lojas.add(LojaModel.fromMap(lojaData));
        }
        return lojas;
      } else {
        throw Exception('Erro ao carregar lojas próximas');
      }
    } else {
      throw Exception('Não foi possível obter a localização atual');
    }
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
              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Selecionar a Loja para Checkin:',
              style: TextStyle(color: darkBlueColor, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<LojaModel>>(
              future: getLojasProximas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else {
                  lojas = snapshot.data!;
                  return Column(
                    children: [
                      for (var index = 0; index < lojas.length; index++)
                        ListTile(
                          title: Text(
                            lojas[index].descricao,
                            style: TextStyle(color: darkBlueColor, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          leading: Checkbox(
                            value: lojasSelecionadas.contains(index),
                            onChanged: (value) {
                              setState(() {
                                if (value!) {
                                  lojasSelecionadas.add(index);
                                } else {
                                  lojasSelecionadas.remove(index);
                                }
                              });
                            },
                          ),
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
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SelecionarVeiculo()),
                                );
                              }
                            },
                            child: const Text('Continuar'),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
