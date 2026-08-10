import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
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

Row AppBarCustom() {
  Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.satellite_alt_rounded,
            color: FlutterFlowTheme.of(context).primary,
            size: 24,
          ),
          Text(
            'NETPROBE',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.jetBrainsMono(
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                  lineHeight: 1.3,
                ),
          ),
        ].divide(SizedBox(width: 8)),
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlutterFlowIconButton(
            borderRadius: 8,
            buttonSize: 40,
            fillColor: Colors.transparent,
            icon: Icon(
              Icons.settings_input_component_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 20,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
          FlutterFlowIconButton(
            borderRadius: 8,
            buttonSize: 40,
            fillColor: Colors.transparent,
            icon: Icon(
              Icons.refresh_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ].divide(SizedBox(width: 8)),
      ),
    ],
  );
}
