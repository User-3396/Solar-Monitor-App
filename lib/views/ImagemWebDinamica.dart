import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;
import 'dart:html' as html;

class ImagemWebDinamica extends StatelessWidget {
  final String url;

  const ImagemWebDinamica({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // Usamos a própria URL como ID único do elemento HTML
    // Substituindo caracteres especiais para evitar falhas no HTML
    final String htmlId = 'img-${url.hashCode}';

    // Registra a factory dinamicamente baseada na URL atual
    ui_web.platformViewRegistry.registerViewFactory(
      htmlId,
      (int viewId) => html.ImageElement()
        ..src = url
        ..style.objectFit = 'contain'
        ..style.width = '100%'
        ..style.height = '100%',
    );

    return HtmlElementView(
      key: UniqueKey(), // Força o Flutter a renderizar o novo elemento HTML
      viewType: htmlId,
    );
  }
}
