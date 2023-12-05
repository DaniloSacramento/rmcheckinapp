import 'dart:convert';

import 'package:rmcheckin/app/const/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<bool> registrarUser({
  required String cpf,
  required String email,
  required String telefone,
  required String tipoValidacao,
}) async {
  var url = Uri.parse(ConstsApi.registrarUser);
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'authorization': ConstsApi.basicAuth,
    },
    body: jsonEncode(
      <String, String>{
        'email': email,
        'cpf': cpf,
        'telefone': telefone,
        'tipoValidacao': tipoValidacao,
      },
    ),
  );
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print('Deu tudo certo no cadastro');

    return true;
  } else {
    print('Erro na chamada da API: ${response.statusCode}');
    return false;
  }
}
