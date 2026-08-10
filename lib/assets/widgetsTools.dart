import 'package:flutter/material.dart';
import 'mercado/produto_class.dart';
import 'styles.dart';

dynamic produtosListView(Future<List<Produto>> _futureProdutos) {
  return FutureBuilder<List<Produto>>(
    future: _futureProdutos,
    builder: (context, snapshot) {
      // 1. Estado de carregamento (mostra indicador circular)
      if (snapshot.connectionState == ConnectionState.waiting) {
        print("Carregando...");
        return Center(child: CircularProgressIndicator());
      }

      // 2. Estado de erro (mostra mensagem caso a API falhe)
      if (snapshot.hasError) {
        //print(snapshot.hasError);
        return Center(
            child: textos.txt('Erro: ${snapshot.error}', "attribute"));
      }

      // 3. Estado de sucesso (renderiza a lista de produtos)
      if (snapshot.hasData) {
        final produtos = snapshot.data!;
        return Expanded(
            child: ListView.builder(
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            final p = produtos[index];
            return ListTile(
              //value: ,
              //leading: Icon(Icons.shopping_bag),
              title: textos.txt(p.nome, "change"),
              subtitle: Text(
                  'R\$ ${p.preco.toStringAsFixed(2)} -${(p.preco - p.desconto).toStringAsFixed(2)}'),
              //trailing: Checkbox(),
            );
          },
        ));
        //return textos.txt('$produtos[0].url', 'defaut');
      }

      return const Center(
          child: Text(
        'Nenhum produto encontrado.',
        style: TextStyle(color: Color(0xff9a9a9a)),
      ));
    },
  );
}
