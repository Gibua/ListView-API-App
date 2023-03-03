import 'dart:async';
import 'package:http/http.dart' as http;

import 'dart:convert';

class Bem {
  late final int id;
  late final String nome;
  late final int lotes;

  Bem({
    required this.id,
    required this.nome,
    required this.lotes,
  });

  Bem.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    nome = jsonData['nome'];
    lotes = jsonData['lotes'];
  }
}


Future<List<Bem>> getData(apiUri) async {
  final response = await http.get(
    apiUri,
    headers: {"Accept": "application/json"}
  );

  if (response.statusCode == 200) { // 200 = OK
    List jsonResponse = json.decode(response.body); // List<Map<String,dynamic>>
    return jsonResponse.map((data) => Bem.fromJson(data)).toList();
    // Ao invés de construir uma lista com um forEach, utilizamos um .map() para
    //que possamos retornar um Future de uma lista ao invés de uma lista para manter
    //o assincronismo
  } else {
    throw Exception('Erro ao adquirir recursos da API!');
  }
}