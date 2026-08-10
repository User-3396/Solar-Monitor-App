import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'produto_class.dart';

const Map<String, Map<String, String>> categorias = {
  'mercearia': {
    'graos': '291853',
    'molhos': '291714',
    'sereais': '291758',
    'massas': '291791',
    'conservas': '291893',
    'cafes': '291932',
    'paes': '291776'
  },
  'hortifruti': {
    'ovos': '291960',
    'frutas': '291961',
    'temperos-frescos': '291963',
    'verduras': '291964',
    'outros': '291965'
  },
};

class RequestAPI {
  Map<String, dynamic> parametros = {
    //'promotion': "true",
    'categories': "", // "Mercearia,Bebidas > Vinhos"
    //'categoryId': "",
    //"tags": "",
    //'onlyPersonas': "false",
    //'cashback': "false",
    'size': "10",
    'from': "0",
    //"search": "",
    //'sortField': "sales_count",
    //'sortOrder': "desc"
  };

  late final String domain;
  late final String path;

  RequestAPI({
    required String domain,
    required String path,
  });

  Future<(int, int, dynamic)> getByCategory(
      String cat, int init, int size) async {
    //print("Buscando produtos...");
    parametros['categories'] = cat;
    parametros['size'] = size;

    final finalUrl = Uri.https(domain, path, parametros);
    final dynamic response;
    //print(url.toString());

    try {
      //final url = Uri.https('sense.osuper.com.br', '/60/196/search', parametros);
      int qnt = 0;
      List<dynamic> listaDeHits = [];
      response = await http.get(finalUrl);

      if (response.statusCode == 200) {
        // Decodifica a resposta em formato UTF-8 para evitar erros de acentuação
        final Map<String, dynamic> dadosJson = jsonDecode(
            utf8.decode(response.bodyBytes)); //jsonDecode(response.body);

        // Se 'hits' não existir, usa uma lista vazia para evitar quebras no app
        listaDeHits = dadosJson['hits'] ?? [];
        qnt = dadosJson['total'];
      }

      return (response.statusCode as int, qnt, listaDeHits);
    } catch (e) {
      return (-1, 0, 'Erro: $e');
      //throw Exception('Falha ao carregar produtos do mercado');
    }

    //throw Exception('Falha ao carregar produtos do mercado');
    //return (response.statusCode as int ?? 0, 0, "");
  }
}
