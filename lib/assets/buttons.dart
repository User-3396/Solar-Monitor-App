import 'package:flutter/material.dart';

// ElevatedButton criarBotaoComParametro({required Text lbl, required Function(String) acaoComDado}) {
ElevatedButton botao(Text lbl, VoidCallback acao) {
  return ElevatedButton.icon(
    onPressed: acao,
    icon: const Icon(Icons.wb_sunny),
    label: lbl,
    style: ElevatedButton.styleFrom(backgroundColor: Color(0xff3d2e00)),
  );
}
