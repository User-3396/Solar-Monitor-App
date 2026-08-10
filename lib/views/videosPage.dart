import 'package:flutter/material.dart';
//import 'package:dotted_border/dotted_border.dart';
// import 'package:http/http.dart' as http;
import 'dart:ui_web' as ui_web; // No Flutter moderno
import 'dart:html' as html;

// import './ImagemWebDinamica.dart';
import '../assets/styles.dart';
// import '../assets/buttons.dart';
// import '../assets/controles.dart';
// import '../assets/parametros.dart';

class SolarVideoPage extends StatefulWidget {
  const SolarVideoPage({super.key});

  @override
  State<SolarVideoPage> createState() => _SolarVideoPageState();
}

class _SolarVideoPageState extends State<SolarVideoPage> {
  // const SolarImages({super.key})
  // final String _baseAPIUrl = "https://api.helioviewer.org/";
  final ScrollController _scrollController = ScrollController();
  //https://api.helioviewer.org/?action=takeScreenshot&imageScale=11.0&layers=[10,1,100]&date=2026/07/07T21:38:00Z&x1=-1200&x2=1200&y1=-1200&y2=1200&display=true&watermark=false "api.helioviewer.org"
  String _imageUrl = "";
  bool _isLoading = false;
  DateTime agora = DateTime.now();
  //late final Controles controles;

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
  }

  // Lembre-se de limpá-los para evitar vazamento de memória
  @override
  void dispose() {
    super.dispose();
  }
  //_imageUrl ="$_baseUrl??action=takeScreenshot&imageScale=10.654375&layers=[13,1,100]&events=&eventLabels=false&scale=false&scaleType=earth&scaleX=0&scaleY=0&date=2026/07/09T16:49:05Z&x1=-1073&x2=1655&y1=-1143&y2=1028&display=true&watermark=false&v=${DateTime.now().millisecondsSinceEpoch}"; // Evita cache do app

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Monitor Solar",
              style: TextStyle(color: Colors.amber)),
          backgroundColor: Color.fromARGB(200, 40, 40, 40)),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.black,
            child: Container(
              // margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(8),
              color: const Color(0xff212121),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                thickness: 6.0, // Espessura da barra de rolagem
                child: SingleChildScrollView(
                  controller: _scrollController,
                  primary:
                      false, // Garante que o scroll ocupará toda a área visível do dispositivo
                  child: Column(children: [
                    _ParamFields(),
                    const SizedBox(height: 30),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ParamFields() {
    return Container(
      padding: const EdgeInsets.all(6),
      color: const Color(0xff002b2e),
      child: Column(children: [
        Row(children: [
          textos.txt("Medição: ", "attribute"),
          const SizedBox(width: 5),
        ]),
        const SizedBox(height: 10),
        const SizedBox(height: 10),
        Row(children: [
          textos.txt("Data: ", "attribute"),
          const SizedBox(width: 5),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          textos.txt("Horario: ", "attribute"),
        ]),
      ]),
    );
  }

  List<DropdownMenuItem<String>> listaMedicoes(Map<String, int> m) {
    return [
      for (var chave in m.keys)
        DropdownMenuItem<String>(value: chave, child: Text(chave)),
    ];
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
      'date': '2026-05-31T23:00:00Z', //controles.data.toText(),
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

  Widget test() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        height: 100,
        color: Colors.green,
      ),
      const SizedBox(height: 20),
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
              const SizedBox(width: 20),
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
      const SizedBox(height: 20),
      Container(
        height: 300,
        color: Colors.green,
      ),
      const SizedBox(height: 20),
    ]);
  }
}
