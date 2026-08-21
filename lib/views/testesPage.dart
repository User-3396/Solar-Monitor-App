import 'package:flutter/material.dart';
//import 'package:dotted_border/dotted_border.dart';
// import 'package:http/http.dart' as http;
import 'dart:ui_web' as ui_web; // No Flutter moderno
import 'dart:html' as html;

import '../assets/channels/battery_channel.dart';

class TestesPage extends StatefulWidget {
  const TestesPage({super.key});

  @override
  State<TestesPage> createState() => _TestesPageState();
}

class _TestesPageState extends State<TestesPage> {
  //const TestesPage({super.key})
  //DateTime agora = DateTime.now();
  final Battery_Channel _bateria = Battery_Channel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            const Icon(Icons.satellite_alt_rounded, color: Color(0xffd1d100)),
        title: const Text("Bateria", style: TextStyle(color: Colors.amber)),
        backgroundColor: const Color.fromARGB(200, 40, 40, 40),
        actions: [
          Row(children: [
            Icon(Icons.battery_full_sharp, color: Color(0xff00ff00)),
          ]),
        ],
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.black,
            child: FutureBuilder<String>(
                future: _bateria.getBatteryLevel(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Erro',
                        style: TextStyle(color: Color(0xffffffff)));
                  } else {
                    print(snapshot.data);
                    return Text('${snapshot.data}',
                        style: const TextStyle(color: Color(0xffffffff)));
                  }
                }),
          ),
        ),
      ),
    );
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

  // Future<double> _getBatteryLevel() async {
  //   return 1.0;
  // }
}
