import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final layerMask = MaskTextInputFormatter(
  mask: '##',
  filter: {"#": RegExp(r'[0-9]')}, // Garante que apenas números sejam digitados
  type: MaskAutoCompletionType.lazy,
);

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

final Map<String, TextInputFormatter> mask = {
  'ano': dateMask_year,
  'data': dateMask,
  'lay': layerMask,
  'eixo': axesMask,
};
