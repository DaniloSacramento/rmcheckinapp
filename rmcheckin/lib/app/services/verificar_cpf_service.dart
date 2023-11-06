import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rmcheckin/app/const/const.dart';

class VerificarCpfService {
  Future<bool> login(
    String cpf,
  ) async {
    var url = Uri.parse(ConstsApi.motoristaAuth);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': ConstsApi.basicAuth,
      },
      body: jsonEncode(<String, String>{"cpf": cpf}),
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
