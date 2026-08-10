class Produto {
  final String id;
  final String nome;
  final dynamic preco;
  final dynamic desconto;
  //String url;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.desconto,
    //this.url = '',
  });

  // Converte o JSON recebido da API em um objeto Produto
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'] as String,
      nome: json['name'] as String,
      //preco: json['pricing']['promotionalPrice'] ?? 0.0, // as num)?.toDouble() ?? 0.0,
      preco: json['pricing']['price'] ?? 0.0,
      desconto: json['pricing']['promotionalPrice'] ?? 0.0,
      //desconto: json['pricing']['discount'] ?? 0,
    );
  }
}
