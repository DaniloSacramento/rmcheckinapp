import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rmcheckin/app/const/const.dart';

class VerificarTokenService {
  Future<bool> verificarToken(
    String telefone,
    String token,
  ) async {
    var url = Uri.parse(ConstsApi.verificarToken);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': ConstsApi.basicAuth,
      },
      body: jsonEncode(
        <String, String>{"telefone": telefone, "token": token},
      ),
    );

    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      print('deu erro');
      return false;
    }
  }
}
