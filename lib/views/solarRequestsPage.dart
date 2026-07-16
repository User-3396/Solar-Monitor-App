import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:ui_web' as ui_web; // No Flutter moderno
import 'dart:html' as html;

import './ImagemWebDinamica.dart';
import '../assets/styles.dart';
import '../assets/buttons.dart';
import '../assets/controles.dart';

class SolarImages extends StatefulWidget {
  const SolarImages({super.key});

  @override
  State<SolarImages> createState() => _SolarImagesState();
}

class _SolarImagesState extends State<SolarImages> {
  // const SolarImages({super.key})
  // final String _baseAPIUrl = "https://api.helioviewer.org/";
  final ScrollController _scrollController = ScrollController();
  //https://api.helioviewer.org/?action=takeScreenshot&imageScale=11.0&layers=[10,1,100]&date=2026/07/07T21:38:00Z&x1=-1200&x2=1200&y1=-1200&y2=1200&display=true&watermark=false "api.helioviewer.org"
  String _imageUrl = "";
  // String _log = "";
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
    return Scaffold(
      appBar: AppBar(title: const Text("Monitor Solar Móvel")),
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        thickness: 6.0, // Espessura da barra de rolagem
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: double.maxFinite),
            child: Container(
              alignment: Alignment.topCenter,
              // width: double.maxFinite,
              color: const Color(0xff000000),
              child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 100,
                      height: 80,
                      color: Color.fromARGB(255, 255, 255, 200)),
                  SizedBox(height: 20),
                  Container(
                      width: 100,
                      height: 80,
                      color: Color.fromARGB(255, 255, 255, 200)),
                  Container(
                      width: 100,
                      height: 80,
                      color: Color.fromARGB(255, 255, 255, 200))
                  //     _ParamFields(),
                  //     const SizedBox(height: 30),
                  //     botao(text2("Buscar Dados"), _searchImagemSolar),
                  //     const SizedBox(height: 30),
                  //     // Text(_log),
                  //     if (_isLoading)
                  //       const CircularProgressIndicator()
                  //     else if (_imageUrl.isNotEmpty)
                  //       SingleChildScrollView(
                  //           child: Container(
                  //               width: 350,
                  //               height: 350,
                  //               decoration: BoxDecoration(
                  //                   border: Border.all(color: Colors.orange)),
                  //               child: ImagemWebDinamica(url: _imageUrl)))
                  //     else
                  //       const Text("Nenhum dado carregado ainda."),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ParamFields() {
    return Column(children: [
      Center(
        widthFactor: 1.0,
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          children: [
            // const Text("Instrumento: ", style: TextStyle(color: Colors.blue)),
            Container(
                // height: 30,
                // width: 100,
                color: const Color.fromARGB(255, 100, 100, 100),
                child: Expanded(child: campo('layer', controles.layers, "lay")))
          ],
        ),
      )

      // const Center(
      //     child: Text("Recorte: ", style: TextStyle(color: Colors.blue))),
      // Row(children: [
      //   Expanded(child: campo('x1', controles.corte.xaCtrl, 'eixo')),
      //   const SizedBox(width: 10),
      //   Expanded(child: campo('x2', controles.corte.xbCtrl, 'eixo')),
      //   const SizedBox(width: 10),
      //   Expanded(child: campo('y1', controles.corte.yaCtrl, 'eixo')),
      //   const SizedBox(width: 10),
      //   Expanded(child: campo('y2', controles.corte.ybCtrl, 'eixo')),
      // ]),
      // const SizedBox(width: 10),
      // const Center(
      //     child: Text(
      //   "Data: ",
      //   style: TextStyle(color: Colors.blue),
      // )),
      // Row(children: [
      //   Expanded(child: campo('aaaa', controles.data.ano, 'ano')),
      //   const SizedBox(width: 10),
      //   Expanded(child: campo('mm', controles.data.mes, 'data')),
      //   const SizedBox(width: 10),
      //   Expanded(child: campo('dd', controles.data.dia, 'data')),
      // ]),
      // const Center(
      //     child: Text("Hora (UTC, 12 horas atras): ",
      //         style: TextStyle(color: Colors.blue))),
      // Row(children: [
      //   Expanded(child: campo('hh', controles.data.hora, 'data')),
      //   const SizedBox(width: 10),
      //   Expanded(child: campo('mm', controles.data.min, 'data')),
      //   const SizedBox(width: 10),
      //   Expanded(child: campo('ss', controles.data.seg, 'data')),
      // ]),
    ]);
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
}
