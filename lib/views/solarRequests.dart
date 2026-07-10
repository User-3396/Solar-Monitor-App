// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import './ImagemWebDinamica.dart';
import '../assets/styles.dart';
import 'dart:ui_web' as ui_web; // No Flutter moderno
import 'dart:html' as html;

class SolarImages extends StatefulWidget {
  const SolarImages({super.key});

  @override
  State<SolarImages> createState() => _SolarImagesState();
}

class _SolarImagesState extends State<SolarImages> {
  // const SolarImages({super.key})
  // final String _baseAPIUrl = "https://api.helioviewer.org/";

  String _imageUrl = "";
  // String _log = "";
  bool _isLoading = false;
  DateTime agora = DateTime.now();

  TextEditingController _anoCtrl = TextEditingController();
  TextEditingController _mesCtrl = TextEditingController();
  TextEditingController _diaCtrl = TextEditingController();
  TextEditingController _horaCtrl = TextEditingController();
  TextEditingController _minCtrl = TextEditingController();
  TextEditingController _segCtrl = TextEditingController();

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

    // Adicione no início da sua classe de estado:
    _anoCtrl = TextEditingController(text: agora.year.toString());
    _mesCtrl =
        TextEditingController(text: agora.month.toString().padLeft(2, '0'));
    _diaCtrl =
        TextEditingController(text: agora.day.toString().padLeft(2, '0'));
    _horaCtrl =
        TextEditingController(text: agora.hour.toString().padLeft(2, '0'));
    _minCtrl =
        TextEditingController(text: agora.minute.toString().padLeft(2, '0'));
    _segCtrl =
        TextEditingController(text: agora.second.toString().padLeft(2, '0'));
  }

  // Lembre-se de limpá-los para evitar vazamento de memória
  @override
  void dispose() {
    _anoCtrl.dispose();
    _mesCtrl.dispose();
    _diaCtrl.dispose();
    _horaCtrl.dispose();
    _minCtrl.dispose();
    _segCtrl.dispose();
    super.dispose();
  }
  //_imageUrl ="$_baseUrl??action=takeScreenshot&imageScale=10.654375&layers=[13,1,100]&events=&eventLabels=false&scale=false&scaleType=earth&scaleX=0&scaleY=0&date=2026/07/09T16:49:05Z&x1=-1073&x2=1655&y1=-1143&y2=1028&display=true&watermark=false&v=${DateTime.now().millisecondsSinceEpoch}"; // Evita cache do app

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Monitor Solar Móvel")),
      body: Container(
        color: Color(0xff0f202e),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dataTimeField(),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                _searchImagemSolar();
              },
              icon: const Icon(Icons.wb_sunny),
              label: const Text("Buscar Dados"),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff3d2e00)),
            ),
            const SizedBox(height: 30),
            // Text(_log),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_imageUrl.isNotEmpty)
              SingleChildScrollView(
                  child: Container(
                      width: 350,
                      height: 350,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange)),
                      child: ImagemWebDinamica(url: _imageUrl)))
            else
              const Text("Nenhum dado carregado ainda."),
          ],
        ),
      ),
    );
  }

  Widget _dataTimeField() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(children: [
        const Text("Data: "),
        Expanded(child: campo('aaaa', _anoCtrl)),

        const SizedBox(width: 10), // Espaço entre o campo 1 e 2
        Expanded(child: campo('mm', _mesCtrl)),

        const SizedBox(width: 10),
        Expanded(child: campo('dd', _diaCtrl)),
      ]),
      Row(children: [
        const Text("Hora: "),
        Expanded(child: campo('hh', _horaCtrl)),
        const SizedBox(width: 10),
        Expanded(child: campo('mm', _minCtrl)),
        const SizedBox(width: 10),
        Expanded(child: campo('ss', _segCtrl)),
      ]),
    ]);
  }

  Future<void> _searchImagemSolar() async {
    // 1. Defina o endereço base da API (sem as interrogações e parâmetros)
    const String baseUrl =
        "api.helioviewer.org"; // Se for HTTPS, use apenas o domínio aqui

    // 2. Separe todos os parâmetros da URL em um Map estruturado
    final Map<String, String> parametros = {
      'action': 'takeScreenshot',
      'imageScale': '10.654375',
      'layers':
          '[13,1,100]', // O Dart vai codificar os colchetes automaticamente
      'events': '',
      'eventLabels': 'false',
      'scale': 'false',
      'scaleType': 'earth',
      'scaleX': '0',
      'scaleY': '0',
      'date':
          '${_anoCtrl.text}-${_mesCtrl.text}-${_diaCtrl.text}T${_horaCtrl.text}:${_minCtrl.text}:${_segCtrl.text}Z', // Nota: Ajustado para o padrão ISO (hífen) que a API do Helioviewer espera
      'x1': '-1200',
      'x2': '1200',
      'y1': '-1200',
      'y2': '1200',
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
