import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final dateMask = MaskTextInputFormatter(
  mask: '##',
  filter: {"#": RegExp(r'[0-9]')}, // Garante que apenas números sejam digitados
  type: MaskAutoCompletionType.lazy,
);

final dateMask_year = MaskTextInputFormatter(
  mask: '####',
  filter: {"#": RegExp(r'[0-9]')}, // Garante que apenas números sejam digitados
  type: MaskAutoCompletionType.lazy,
);

final axesMask = MaskTextInputFormatter(
  mask: '#####',
  filter: {
    "#": RegExp(r'^-?\d$')
  }, // Garante que apenas números sejam digitados
  type: MaskAutoCompletionType.lazy,
);

TextField campo(String lbl, TextEditingController ctrl, String tipo) {
  final MaskTextInputFormatter msk;

  if (tipo == 'ano') {
    msk = dateMask_year;
  } else if (tipo == 'data') {
    msk = dateMask;
  } else {
    msk = axesMask;
  }

  return TextField(
    keyboardType: const TextInputType.numberWithOptions(
      signed: true, // Habilita o sinal de menos (-)
      decimal: false, // Bloqueia ponto e vírgula
    ),
    inputFormatters: [msk],
    controller: ctrl,
    decoration: InputDecoration(
      labelText: lbl,
      // Muda a cor da label quando o campo NÃO está focado:
      labelStyle: const TextStyle(
        color: Colors.blueGrey,
      ),
      // Opcional: muda a cor da label QUANDO o usuário clica no campo (foco):
      floatingLabelStyle: const TextStyle(
        color: Color(0xff9c9c9c),
      ),
      border: const OutlineInputBorder(),
    ),
    style: const TextStyle(color: Color(0xff9d55ff)),
  );
}
