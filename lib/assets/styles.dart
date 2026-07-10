import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter';

final dateMask = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')}, // Garante que apenas números sejam digitados
  type: MaskAutoCompletionType.lazy,
);

TextField campo(String lbl, TextEditingController ctrl) {
  return TextField(
    controller: ctrl,
    decoration: InputDecoration(
      labelText: lbl,
      // Muda a cor da label quando o campo NÃO está focado:
      labelStyle: TextStyle(
        color: Colors.blueGrey,
      ),
      // Opcional: muda a cor da label QUANDO o usuário clica no campo (foco):
      floatingLabelStyle: TextStyle(
        color: Color(0xff9c9c9c),
      ),
    ),
    style: TextStyle(color: Color(0xff9d55ff)),
  );
}
