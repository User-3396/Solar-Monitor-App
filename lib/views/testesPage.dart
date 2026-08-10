import 'package:flutter/material.dart';
//import 'package:dotted_border/dotted_border.dart';
// import 'package:http/http.dart' as http;
import 'dart:ui_web' as ui_web; // No Flutter moderno
import 'dart:html' as html;

class TestesPage extends StatefulWidget {
  const TestesPage({super.key});

  @override
  State<TestesPage> createState() => _TestesPageState();
}

class _TestesPageState extends State<TestesPage> {
  //const TestesPage({super.key})
  
  //DateTime agora = DateTime.now();
  

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
          title: const Text("Monitor Solar",
              style: TextStyle(color: Colors.amber)),
          backgroundColor: Color.fromARGB(200, 40, 40, 40)),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.black,
            child: ,
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
}
