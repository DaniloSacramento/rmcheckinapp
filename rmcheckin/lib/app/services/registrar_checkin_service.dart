import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rmcheckin/app/const/const.dart';

class RegistrarLoja {
  Future<bool> registrarLoja({
    required String cpf,
    required String lojaId,
    required String veiculoId,
    required String checkInId,
    required String chaveNf,
  }) async {
    var url = Uri.parse(ConstsApi.registrarCheckin);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': ConstsApi.basicAuth,
      },
      body: jsonEncode(
        <String, String>{
          "cpf": cpf,
          "lojaId": lojaId,
          "veiculoId": veiculoId,
          "checkInId": checkInId,
          "chaveNf": chaveNf,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      return false;
    }
  }
}
