import 'package:helloworld/assets/mercado/produto_class.dart';

class Categoria {
  final int id;
  int quantidade = 0;
  List<Produto> produtos = [];

  Categoria({required this.id});

  void setProdutos(Map<String, dynamic> json) {
    print(json.length);
    /*produtos(
      id: json['id'] as String,
      nome: json['name'] as String,
      //preco: json['pricing']['promotionalPrice'] ?? 0.0, // as num)?.toDouble() ?? 0.0,
      preco: json['pricing']['price'] ?? 0.0,
      desconto: json['pricing']['promotionalPrice'] ?? 0.0,
      //desconto: json['pricing']['discount'] ?? 0,
    );*/
  }
  //void setQuantidade (int x){quantidade =x;}
}
