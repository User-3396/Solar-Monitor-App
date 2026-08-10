import 'dart:convert';
import 'package:helloworld/assets/mercado/marketRequests.dart';
import 'package:http/http.dart' as http;
import 'categoria_class.dart';
import 'produto_class.dart';
//import 'data/hortifruti_data.json' as dt;
import 'package:flutter/services.dart' show rootBundle;
// Sammy
// https://sense.osuper.com.br/60/196/search?promotion=true&onlyPersonas=false&cashback=false&size=5&from=0&sortField=sales_count&sortOrder=desc

// Assun
// https://www.asunonline.com.br/
// https://sense.osuper.com.br/319/1545/search?promotion=true&sortField=sales_count&size=8&from=0&onlyPersonas=true&sortOrder=desc
//

final List<String> categorias = [""];

class Mercado {
  final String urlDomain;
  final String urlPath;
  late final RequestAPI requester;
  List<Produto> produtos = [];

  Mercado({
    required this.urlDomain,
    required this.urlPath,
  }) {
    requester = RequestAPI(domain: urlDomain, path: urlPath);
  }

  Future<int> buscarPorCategoria(
      {required String cat, int init = 0, int size = 5}) async {
    //final parametros = {
    //'promotion': "true",
    //'categories': "", // "Mercearia,Bebidas > Vinhos"
    //"tags": "", 'onlyPersonas': "false", 'cashback': "false",
    //'size': size.toString(), 'from': init.toString(), // 12
    //"search": "",
    //'sortField': "sales_count", 'sortOrder': "desc"
    //};

    (int, int, dynamic) search = await requester.getByCategory(cat, init, size);

    if (search.$1 == 200) {
      // Converte os dados para a lista de objetos mapeados
      produtos = search.$3.map((json) => Produto.fromJson(json)).toList();

      return 200;
    }
    return 0;
  }

  Future<Map<String, dynamic>> getJson() async {
    String content =
        await rootBundle.loadString('assets/data/hortifruti_data.json');

    final Map<String, dynamic> dados =
        json.decode(content) as Map<String, dynamic>;

    return dados;
  }
}
