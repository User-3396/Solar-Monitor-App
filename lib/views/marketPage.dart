import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
// import 'package:http/http.dart' as http;
import 'dart:ui_web' as ui_web; // No Flutter moderno
import 'dart:html' as html;

import '../assets/styles.dart';
import '../assets/buttons.dart';
import '../assets/mercado/marketRequests.dart';
import '../assets/mercado/produto_class.dart';
import '../assets/mercado/mercado_class.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  // const SolarImages({super.key})
  // final String _baseAPIUrl = "https://api.helioviewer.org/";

  //https://api.helioviewer.org/?action=takeScreenshot&imageScale=11.0&layers=[10,1,100]&date=2026/07/07T21:38:00Z&x1=-1200&x2=1200&y1=-1200&y2=1200&display=true&watermark=false "api.helioviewer.org"

  //DateTime agora = DateTime.now();
  //late Future<List<Produto>> _futureProdutos;
  final Sammy =
      Mercado(urlDomain: "sense.osuper.com.br", urlPath: "/60/196/search");
  final Assun =
      Mercado(urlDomain: "sense.osuper.com.br", urlPath: "/319/1545/search");
  bool _sammyIsLoading = false;
  bool _assunIsLoading = false;
  int _sortColumnIndex = 0;
  bool _isAscending = false;
  //TextEditingController _catCtrl =new TextEditingController()

  @override
  void initState() {
    super.initState();
  }

  // Lembre-se de limpá-los para evitar vazamento de memória
  @override
  void dispose() {
    // Controllers, Streams, Timer.periodic...
    super.dispose();
  }

  Future<void> _carregar(int x) async {
    if (x == 1 && Sammy.produtos.isEmpty) {
      setState(() {
        _sammyIsLoading = true;
      });

      //await Sammy.buscarPorCategoria(cat: "", init: 0, size: 20);
      final x = await Sammy.getJson();
      print(x['name']['0']);

      setState(() {
        _sammyIsLoading = false;
      });

      //ScaffoldMessenger.of(context).showSnackBar(
      //  SnackBar(content: Text(Sammy.produtos[0].nome)),
      //);
    }
  }

  void _ordenar(bool columnIndex, bool ascending) {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title:
                const Text("Produtos", style: TextStyle(color: Colors.amber)),
            backgroundColor: const Color(0xff313131),
            bottom: const TabBar(
              labelStyle: TextStyle(color: Color(0xff008080)),
              indicatorColor: Color(0xff00aaff),
              tabs: [
                Tab(text: "Sammy"),
                Tab(text: "Assun"),
              ],
            ),
          ),
          body: TabBarView(children: [
            // Aba 1 [Sammy]
            Container(
              color: const Color(0xff000000),
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff303030),
                  borderRadius: BorderRadius.circular(12),
                ),
                //color: const Color(0xff303030),
                child: Column(children: [
                  ElevatedButton(
                    onPressed: _sammyIsLoading ? null : () => _carregar(1),
                    child: Text("Carregar"),
                  ),
                  textos.txt("Lista: ", "attribute"),
                  const SizedBox(height: 24),
                  // _Tabela_build (),
                  if (!_sammyIsLoading) ...[
                    if (Sammy.produtos.isNotEmpty) ...[
                      Expanded(
                        child: ListView.builder(
                          itemCount: Sammy.produtos.length,
                          itemBuilder: (context, index) {
                            final p = Sammy.produtos[index];
                            return ListTile(
                              //value: ,
                              //leading: Icon(Icons.shopping_bag),
                              title: textos.txt(p.nome, "change"),
                              subtitle: //Row(children: [
                                  textos.txt(
                                      'R\$ ${p.preco.toStringAsFixed(2)} -${(p.preco - p.desconto).toStringAsFixed(2)}',
                                      'button'),
                              //]),

                              //trailing: Text("oo"),
                            );
                          },
                        ),
                      )
                    ] else
                      Center(child: textos.txt("Vazio", 'default'))
                  ] else
                    const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0x8b000000),
                      ),
                    ),
                ]),
              ),
            ),

            // Aba 2: [Assun]
            Container(
              color: const Color(0xff000000),
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff303030),
                  borderRadius: BorderRadius.circular(12),
                ),
                //color: const Color(0xff303030),
                child: Column(
                  children: [
                    textos.txt("Horario: ", "attribute"),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  /*SingleChildScrollView _Tabela_build (Map<String, String> data){
    SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          decoration: BoxDecoration(color: Color(0xff868686)),
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _isAscending,
          columns: const [
            DataColumn(
              label: Text("nome"),
              onSort: (columnIndex, ascending) =>
                  _ordenar(columnIndex, ascending),
            ),
            DataColumn(
              label: Text("preço"),
              numeric: true,
              onSort: (columnIndex, ascending) =>
                  _ordenar(columnIndex, ascending),
            ),
            DataColumn(label: Text("promo")),
            DataColumn(label: Text("desc")),
          ],
          rows: [
            const DataRow(cells: [
              DataCell(Text("10")),
              DataCell(Text("10")),
              DataCell(Text("40")),
              DataCell(Text("30")),
            ]),
            const DataRow(cells: [
              DataCell(Text("90")),
              DataCell(Text("30")),
              DataCell(Text("20")),
              DataCell(Text("90")),
            ])
          ],
          //     Sammy.produtos.isEmpty
          //         ? '${Sammy.produtos.length}'
          //         : Sammy.produtos[0].nome,
          //style: const TextStyle(color: Color(0xff808080))
        ),
      ),
    );
  }*/
}

/*
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> getJson() async {
  String content = await rootBundle.loadString('assets/data/hortifruti_data.json');
  return jsonDecode(content) as Map<String, dynamic>;
}

class TabelaHortifrutiOrdenavel extends StatefulWidget {
  const TabelaHortifrutiOrdenavel({super.key});

  @override
  State<TabelaHortifrutiOrdenavel> createState() => _TabelaHortifrutiOrdenavelState();
}

class _TabelaHortifrutiOrdenavelState extends State<TabelaHortifrutiOrdenavel> {
  // Variáveis para controlar o estado da ordenação
  int? _sortColumnIndex;
  bool _isAscending = true;
  
  // Lista local para armazenar os dados processados e permitir a ordenação rápida
  List<Map<String, String>> _listaProdutos = [];
  bool _dadosCarregados = false;

  // Função que faz a ordenação lógica da lista de mapas
  void _ordenar(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;

      _listaProdutos.sort((a, b) {
        // Seleciona o campo correto baseado na coluna clicada
        String campoA = columnIndex == 0 ? a['id']! : a['name']!;
        String campoB = columnIndex == 0 ? b['id']! : b['name']!;

        if (columnIndex == 0) {
          // Se for a coluna ID, converte para número para ordenar corretamente (ex: 2 vem antes de 10)
          int numA = int.tryParse(campoA) ?? 0;
          int numB = int.tryParse(campoB) ?? 0;
          return ascending ? numA.compareTo(numB) : numB.compareTo(numA);
        } else {
          // Se for a coluna Nome, ordena como texto alfabético
          return ascending ? campoA.compareTo(campoB) : campoB.compareTo(campoA);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos Ordenáveis')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dadosCarregados ? null : getJson(), // Evita recarregar o JSON ao ordenar
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !_dadosCarregados) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          // Inicializa a lista local apenas na primeira vez que o JSON é lido
          if (snapshot.hasData && !_dadosCarregados) {
            final dados = snapshot.data!;
            final ids = dados['id'] as Map<String, dynamic>;
            final nomes = dados['name'] as Map<String, dynamic>;

            _listaProdutos = ids.keys.map((key) {
              return {
                'id': ids[key].toString(),
                'name': nomes[key].toString(),
              };
            }).toList();
            _dadosCarregados = true;
          }

          // Monta as linhas a partir da nossa lista ordenada na memória
          List<DataRow> linhas = _listaProdutos.map((produto) {
            return DataRow(
              cells: [
                DataCell(Text(produto['id']!)),
                DataCell(Text(produto['name']!)),
              ],
            );
          }).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _isAscending,
                columns: [
                  DataColumn(
                    label: const Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                    numeric: true, // Alinha os números à direita
                    onSort: (columnIndex, ascending) => _ordenar(columnIndex, ascending),
                  ),
                  DataColumn(
                    label: const Text('Nome', style: TextStyle(fontWeight: FontWeight.bold)),
                    onSort: (columnIndex, ascending) => _ordenar(columnIndex, ascending),
                  ),
                ],
                rows: linhas,
              ),
            ),
          );
        },
      ),
    );
  }
}

- onSort nos cabeçalhos: O parâmetro onSort das DataColumn ativa a setinha visual de ordenação na tabela e detecta o clique do usuário.
- _dadosCarregados de controle: Se o FutureBuilder rodasse de novo a cada clique na coluna, a ordenação se perderia porque o JSON seria relido do zero. Essa variável trava o estado para ordenar direto na memória (_listaProdutos).
- Comparação Numérica vs Alfabética: Na função _ordenar, o ID é convertido para inteiro (int.tryParse) antes de ordenar. Se ordenássemos o ID como texto simples, o número "16" viria antes do "2" (porque "1" vem antes de "2").
 */
