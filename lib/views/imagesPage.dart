import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
// import 'package:http/http.dart' as http;
import 'dart:ui_web' as ui_web; // No Flutter moderno
import 'dart:html' as html;

import './ImagemWebDinamica.dart';
import '../assets/styles.dart';
import '../assets/buttons.dart';
import '../assets/controles.dart';
import '../assets/parametros.dart';

class SolarImagePage extends StatefulWidget {
  const SolarImagePage({super.key});

  @override
  State<SolarImagePage> createState() => _SolarImagePageState();
}

class _SolarImagePageState extends State<SolarImagePage> {
  // const SolarImages({super.key})
  // final String _baseAPIUrl = "https://api.helioviewer.org/";
  final ScrollController _scrollController = ScrollController();
  //https://api.helioviewer.org/?action=takeScreenshot&imageScale=11.0&layers=[10,1,100]&date=2026/07/07T21:38:00Z&x1=-1200&x2=1200&y1=-1200&y2=1200&display=true&watermark=false "api.helioviewer.org"
  String _imageUrl = "";
  bool _isLoading = false;
  DateTime agora = DateTime.now();
  late final Controles controles;

  @override
  void initState() {
    super.initState();

    // Registra a factory apenas uma vez quando a tela nasce
    ui_web.platformViewRegistry.registerViewFactory(
      'imagem-sol',
      (int viewId) => html.ImageElement()
        ..src = _imageUrl
        ..style.objectFit = 'contain'
        ..style.width = '100%'
        ..style.height = '100%',
    );

    controles = Controles(9, [-1200, 1200, -1200, 1200],
        DateTime.now().toUtc().subtract(const Duration(hours: 12)));
    // controles = TextEditingController(text: agora.year.toString());
  }

  // Lembre-se de limpá-los para evitar vazamento de memória
  @override
  void dispose() {
    controles.toDispose();
    super.dispose();
  }
  //_imageUrl ="$_baseUrl??action=takeScreenshot&imageScale=10.654375&layers=[13,1,100]&events=&eventLabels=false&scale=false&scaleType=earth&scaleX=0&scaleY=0&date=2026/07/09T16:49:05Z&x1=-1073&x2=1655&y1=-1143&y2=1028&display=true&watermark=false&v=${DateTime.now().millisecondsSinceEpoch}"; // Evita cache do app

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Imagens", style: TextStyle(color: Colors.amber)),
            backgroundColor: const Color(0xc81b1b1b),
            bottom: const TabBar(
              indicatorColor: Color(0xff00aaff),
              tabs: [
                Tab(
                  icon: Icon(
                    color: Color.fromARGB(255, 255, 215, 0),
                    Icons.calendar_month_outlined,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.timelapse_outlined,
                    color: Color.fromARGB(255, 255, 215, 0),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.image,
                    color: Color.fromARGB(255, 255, 215, 0),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            // Aba 1: data
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
                  textos.txt("Data: ", "attribute"),
                  const SizedBox(height: 24),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        width: 70,
                        child: campo('ano', controles.data.ano, 'data')),
                    const SizedBox(width: 10),
                    Container(
                        width: 70,
                        child: campo('mês', controles.data.mes, 'data')),
                    const SizedBox(width: 10),
                    Container(
                        width: 70,
                        child: campo('dia', controles.data.dia, 'data')),
                  ]),
                ]),
              ),
            ),
            // Aba 2: horario
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 64,
                          child: campo('hora', controles.data.hora, 'data'),
                        ),
                        const SizedBox(width: 10),
                        Container(
                            width: 64,
                            child: campo('min', controles.data.min, 'data')),
                        const SizedBox(width: 10),
                        Container(
                            width: 64,
                            child: campo('seg', controles.data.seg, 'data')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Aba 3: imagem resultado
            Container(
              color: const Color(0xff000000),
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xff303030),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(children: [
                  textos.txt("Imagem:", "attribute"),
                  Container(
                    width: 300,
                    height: 300,
                    color: Color(0x3000eeff),
                    //decoration: BoxDecoration(
                    //  border: BoxBorder.all(
                    //    color: Color(0xff636363),
                    //style: BorderStyle
                    //  ),
                    //  borderRadius: BorderRadius.circular(6),
                    //),
                  ),
                ]),
              ),
            ),
          ]),
        ));
    //Container(
    //padding: const EdgeInsets.all(12),
    //color: Colors.black,
    //child: Container(
    // margin: const EdgeInsets.all(10),
    //padding: const EdgeInsets.all(8),
    //color: const Color(0xff212121),
    //child: Column(children: [
    //_ParamFields(),
    //const SizedBox(height: 30),

    //botao(estilos.txt("Buscar Dados", "button"), _searchImagemSolar),
    //const SizedBox(height: 30),
    //Container(width: 150, child: campoTeste())
    //if (_isLoading)
    //  const CircularProgressIndicator()
    //else if (_imageUrl.isNotEmpty)
    //   SingleChildScrollView(
    /*DottedBorder(
                  color: _isLoading
                      ? Colors.yellow
                      : _imageUrl.isEmpty
                          ? Colors.blue
                          : Colors.green,
                  strokeWidth: 2,
                  dashPattern: const [1, 2],
                  borderType: BorderType
                      .RRect, // Tipo da borda (Arredondada) // [comprimento, espaco]
                  radius:
                      const Radius.circular(12), // Raio do arredondamento
                  child: Container(
                    width: 300,
                    height: 300,
                    //decoration: BoxDecoration(
                    //border: Border.all(
                    //style: BorderStyle, color: Colors.orange)),
                    child: Center(
                        child: Text(
                      "(sem imagem)",
                      style: TextStyle(color: Color(0xff7a7a7a)),
                    )), //ImagemWebDinamica(url: _imageUrl),
                  ),
                ),*/
  }

  int? layer1 = measurement['red'];

  Widget _ParamFields() {
    return Container(
      padding: const EdgeInsets.all(6),
      color: const Color(0xff002b2e),
      child: Column(children: [
        Row(children: [
          textos.txt("Medição: ", "attribute"),
          const SizedBox(width: 5),
          Container(
              width: 150,
              // height: 100,
              //color: Color(0xff88ad01),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'measurement',
                  labelStyle: TextStyle(color: Color(0xff5cae00)),
                  //filled: true,
                  //fillColor: Color(0x55008888),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                dropdownColor: const Color(0xa0003070),
                style: textos.textStylesMap["change"],
                value: measurement.keys.first,
                onChanged: (String? novoValor) {
                  if (novoValor != null) {
                    // 2. Atualiza a tela e a variável global com o 'int' do Map
                    setState(() {
                      layer1 = measurement[novoValor] ?? measurement['red'];
                    });
                  }
                  //print(layer1);
                },
                items: listaMedicoes(measurement),
              )),
        ]),
        const SizedBox(height: 10),
        Row(
          children: [
            textos.txt("Recorte: ", "attribute"),
            const SizedBox(width: 5),
            Container(
              width: 60,
              child: campo('xa', controles.corte.xaCtrl, 'eixo'),
            ),
            const SizedBox(width: 2),
            Container(
              width: 60,
              child: campo('xb', controles.corte.xbCtrl, 'eixo'),
            ),
            const SizedBox(width: 2),
            Container(
              width: 60,
              child: campo('ya', controles.corte.yaCtrl, 'eixo'),
            ),
            const SizedBox(width: 2),
            Container(
              width: 60,
              child: campo('yb', controles.corte.ybCtrl, 'eixo'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(children: [
          textos.txt("Data: ", "attribute"),
          const SizedBox(width: 5),
          Container(child: campoTeste(controles.data.ano)),
          // Container(
          //   width: 60,
          //   child: campo('ano', controles.data.ano, 'ano'),
          // ),
          // const SizedBox(width: 5),
          // Container(
          //   width: 60,
          //   child: campo('mes', controles.data.mes, 'data'),
          // ),
          // const SizedBox(width: 5),
          // Container(
          //   width: 60,
          //   child: campo('dia', controles.data.dia, 'data'),
          // ),
        ]),
        const SizedBox(height: 10),
      ]),
    );
  }

  List<DropdownMenuItem<String>> listaMedicoes(Map<String, int> m) {
    return [
      for (var chave in m.keys)
        DropdownMenuItem<String>(value: chave, child: Text(chave)),
    ];

    // return DropdownMenu(
    //   dropdownMenuEntries: m.entries.map((entry) {
    //     return DropdownMenuEntry<int>(
    //       value: entry.value, // O número int
    //       label: entry.key,   // O texto String
    //     );
    //   }).toList(),
    // );
  }

  Future<void> _searchImagemSolar() async {
    setState(() {
      _isLoading = true;
    });
    // 1. Defina o endereço base da API (sem as interrogações e parâmetros)
    const String baseUrl =
        "api.helioviewer.org"; // Se for HTTPS, use apenas o domínio aqui

    // 2. Separe todos os parâmetros da URL em um Map estruturado
    final Map<String, String> parametros = {
      'action': 'takeScreenshot',
      'imageScale': '3.0', //'10.654375',
      'layers': //'[SDO,AIA,131]',
          '[13,1,100]', // O Dart vai codificar os colchetes automaticamente
      //'events': '',
      //'eventLabels': 'false',
      //'scale': 'false',
      //'scaleType': 'earth',
      //'scaleX': '0',
      //'scaleY': '0',
      'date': controles.data.toText(),
      // '${.ano.text}-${_mesCtrl.text}-${_diaCtrl.text}T${_horaCtrl.text}:${_minCtrl.text}:${_segCtrl.text}Z', // Nota: Ajustado para o padrão ISO (hífen) que a API do Helioviewer espera
      'x0': '0', 'y0': '0',
      // 'x1': '-1200', //_xaCtrl.text,
      // 'x2': '1200', //_xbCtrl.text,
      // 'y1': '-1200', //_yaCtrl.text,
      // 'y2': '1200', //_ybCtrl.text,
      'width': '1024',
      'height': '1024',
      'display': 'true',
      'watermark': 'false',
    };

    // 3. Monte a URL de forma segura usando o construtor Uri.https ou Uri.http
    final Uri urlCompleta = Uri.https(baseUrl, '/', parametros);
    _imageUrl = urlCompleta.toString();
    _isLoading = false;

    // Opcional: Se quiser ver como ficou a URL montada no console
    print("URL Gerada: $urlCompleta");
  }

  /*Widget test() {
    return Column(
        //<Widget>[]
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            color: Colors.green,
          ),
          SizedBox(height: 20),
          Container(
              //height: 200,
              color: Colors.green,
              child: Column(children: [
                Row(children: [
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                ]),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      color: Colors.red,
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                  ],
                ),
              ])),
          SizedBox(height: 20),
          Container(
            height: 300,
            color: Colors.green,
          ),
          SizedBox(height: 20),
        ]);
  }*/
}
