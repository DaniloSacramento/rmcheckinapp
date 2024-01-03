import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rmcheckin/app/const/const.dart';
import 'package:rmcheckin/app/const/const_app.dart';
import 'package:rmcheckin/app/database/lojas_database.dart';
import 'package:rmcheckin/app/models/tipo_veiculo.dart';

Future<List<Loja>> getNearbyStores({
  required String cpf,
  required double latitude,
  required double longitude,
}) async {
  final url = Uri.parse(ConstsApi.lojasCheckin);

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, dynamic>{
          'cpf': cpf,
          'latitude': latitude,
          'longitude': longitude,
        },
      ),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['data'] != null) {
        List<Loja> stores = [];
        for (var storeData in responseData['data']['lojas']) {
          stores.add(Loja.fromMap(storeData));
        }
        return stores;
      } else {
        throw Exception('No stores found');
      }
    } else {
      throw Exception('Failed to load stores');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}
