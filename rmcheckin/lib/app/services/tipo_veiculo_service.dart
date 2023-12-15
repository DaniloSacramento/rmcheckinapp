import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rmcheckin/app/const/const.dart';
import 'package:rmcheckin/app/models/tipo_veiculo.dart';

class TipoVeiculoService {
  Future<List<String>> tipoVeiculo() async {
    var url = Uri.parse(ConstsApi.tipoVeiculo);
    var response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': ConstsApi.basicAuth,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data']['tipos'];
      List<String> tipos = data.map((item) => item['descricao'].toString()).toList();

      return tipos;
    } else {
      print('Erro ao buscar tipos de veículos: ${response.statusCode}');
      throw Exception('Erro ao buscar tipos de veículos');
    }
  }
}
