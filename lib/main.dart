import 'package:flutter/material.dart';
import 'views/solarRequests.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'My Solar App',
      debugShowCheckedModeBanner: false,
      // Application theme data, you can set the colors for the application as you want
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),

      // 2. Defina qual rota será a tela inicial do app
      initialRoute: '/',

      // 3. Mapeie os nomes das rotas para as classes das páginas
      routes: {
        '/': (context) => const HomePage(title: 'Pagina inicial'),
        '/images': (context) => SolarImages(),
      },

      // A widget which will be started on application startup
      // home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Container(
            width: double.infinity,
            color: const Color(0xff242424),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Good bye, World!',
                    style: TextStyle(color: Colors.amber),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/images');
                    },
                    child: const Text('imagens'),
                  ),
                ])));
  }
}
