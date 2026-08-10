import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'mascaras.dart';

class TextEstilos {
  final Map<String, TextStyle> textStylesMap = {
    "defaut": const TextStyle(color: Color(0Xffffffff)),
    "button": const TextStyle(color: Color(0xff00aa77)),
    "attribute": const TextStyle(color: Colors.amber, fontSize: 20.0),
    "change": const TextStyle(color: Color(0xff0090ff), fontSize: 14.0),
    // [0] default
    // [1] Titulo de botoes
    // [2] Nome de atributo
    // [3] valor de atributo
  };

  // Text t({String? txt = 'default', int x = 0}) {
  Text txt(String txt, String target) {
    return Text(txt,
        style: textStylesMap[target],
        maxLines: 1, // Limita a quantidade de linhas
        overflow: TextOverflow.ellipsis);
  }
}

String? validarData(String? value) {
  if (value == null || value.isEmpty) {
    return 'não pode ficar vazio';
  }

  // Verifica se completou todos os dígitos da máscara
  if (value.length < 10) {
    return 'não pode ficar incompleto';
  }

  // Separa o texto em Ano, Mês e Dia
  final parts = value.split('-');
  final int year = int.parse(parts[0]);
  final int month = int.parse(parts[1]);
  final int day = int.parse(parts[2]);

  // Valida o intervalo do mês
  if (month < 1 || month > 12) {
    return 'Mês inválido (use 01 a 12)';
  }

  // Lista com o limite de dias de cada mês (considerando ano bissexto)
  final isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  final List<int> daysInMonth = [
    31,
    isLeapYear ? 29 : 28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];

  // Valida o limite de dias do mês específico
  if (day < 1 || day > daysInMonth[month - 1]) {
    return 'Dia inválido para este mês (máx: ${daysInMonth[month - 1]})';
  }

  return null; // Data válida!
}

final textos = TextEstilos();

// Campos
TextField campo(String lbl, TextEditingController ctrl, String tipo) {
  return TextField(
    // keyboardType: const TextInputType.numberWithOptions(
    //   signed: true, // Habilita o sinal de menos (-)
    //   decimal: false, // Bloqueia ponto e vírgula
    // ),

    inputFormatters: [mask[tipo]!],
    controller: ctrl,
    decoration: InputDecoration(
      labelText: lbl,
      // Muda a cor da label quando o campo NÃO está focado:
      labelStyle: const TextStyle(
        color: Colors.blueGrey,
      ),
      // Opcional: muda a cor da label QUANDO o usuário clica no campo (foco):
      floatingLabelStyle: const TextStyle(
        color: Color(0xff5cae00),
      ),
      border: const OutlineInputBorder(),
    ),
    style: textos.textStylesMap["change"],
  );
}

final dataMask = MaskTextInputFormatter(
  mask: '####-##-##',
  filter: {'#': RegExp(r'\d')}, // r'(\d{3})+\.?(\d{3})+-?([\dxX]{1,2})+'
  type: MaskAutoCompletionType.lazy,
);

TextField campoTeste(TextEditingController ctrl) {
  return TextField(
    maxLength: 10,
    inputFormatters: [
      //FilteringTextInputFormatter.allow(RegExp(r'(\d{3})')),
      dataMask
    ],
    controller: ctrl,
    style: textos.textStylesMap["change"],

    //onSubmitted: function () {
    //  print(ctrl.toString());
    //},
  );
}

/*
import 'package:flutter/material.dart';

class ExemploValidacao extends StatefulWidget {
  const ExemploValidacao({super.key});

  @override
  State<ExemploValidacao> createState() => _ExemploValidacaoState();
}

class _ExemploValidacaoState extends State<ExemploValidacao> {
  // 1. Crie a chave global para controlar o estado do formulário
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // 2. Envolva os campos com o Form e passe a chave
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 3. Use TextFormField (ele possui a propriedade validator)
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Digite seu E-mail',
                border: OutlineInputBorder(),
              ),
              // 4. Implemente a função de validação
              validator: (value) {
                // Se retornar uma String, o Flutter exibe ela como mensagem de erro embaixo do campo
                if (value == null || value.isEmpty) {
                  return 'Este campo não pode ficar vazio';
                }
                if (!value.contains('@')) {
                  return 'Digite um e-mail válido (falta o @)';
                }
                // Se retornar null, significa que o campo está válido!
                return null; 
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 5. Dispare a validação ao clicar no botão
                if (_formKey.currentState!.validate()) {
                  // Se todos os campos forem válidos, este bloco é executado
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Formulário enviado com sucesso!')),
                  );
                }
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}

*/
