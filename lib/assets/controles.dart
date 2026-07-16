import 'package:flutter/material.dart';

class Data {
  final TextEditingController ano; // = TextEditingController();
  final TextEditingController mes; // = TextEditingController();
  final TextEditingController dia; // = TextEditingController();
  final TextEditingController hora; // = TextEditingController();
  final TextEditingController min; // = TextEditingController();
  final TextEditingController seg; // = TextEditingController();

  Data(DateTime data)
      : ano = TextEditingController(text: data.year.toString()),
        mes =
            TextEditingController(text: data.month.toString().padLeft(2, '0')),
        dia = TextEditingController(text: data.day.toString().padLeft(2, '0')),
        hora =
            TextEditingController(text: data.hour.toString().padLeft(2, '0')),
        min =
            TextEditingController(text: data.minute.toString().padLeft(2, '0')),
        seg =
            TextEditingController(text: data.second.toString().padLeft(2, '0'));

  void disp() {
    ano.dispose();
    mes.dispose();
    dia.dispose();
    hora.dispose();
    min.dispose();
    seg.dispose();
  }

  String toText() {
    return '${ano.text}-${mes.text}-${dia.text}T${hora.text}:${min.text}:${seg.text}Z';
  }
}

class Corte {
  final TextEditingController xaCtrl;
  final TextEditingController xbCtrl;
  final TextEditingController yaCtrl;
  final TextEditingController ybCtrl;

  Corte(List<int> corte)
      : xaCtrl = TextEditingController(text: corte[0].toString()),
        xbCtrl = TextEditingController(text: corte[1].toString()),
        yaCtrl = TextEditingController(text: corte[2].toString()),
        ybCtrl = TextEditingController(text: corte[3].toString());

  void disp() {
    xaCtrl.dispose();
    xbCtrl.dispose();
    yaCtrl.dispose();
    ybCtrl.dispose();
  }
}

class Controles {
  final TextEditingController layers;
  final Corte corte;
  final Data data;

  Controles(int l, List<int> c, DateTime d)
      : layers = TextEditingController(text: l.toString()),
        corte = Corte(c),
        data = Data(d);

  void toDispose() {
    corte.disp();
    data.disp();
    layers.dispose();
  }
}
