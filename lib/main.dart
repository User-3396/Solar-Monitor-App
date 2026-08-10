import 'package:flutter/material.dart';
import 'views/imagesPage.dart';
import 'views/videosPage.dart';
import 'views/marketPage.dart';

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
        scrollbarTheme: ScrollbarThemeData(
          // Configura a cor da barrinha móvel para qualquer estado (clicado, arrastado, etc)
          thumbColor:
              WidgetStateProperty.all(const Color.fromARGB(180, 255, 185, 0)),
          // Configura a cor do trilho se quiser que apareça
          // trackColor: WidgetStateProperty.all(Color(0x7c00ffde)),
        ),
      ),

      // 2. Defina qual rota será a tela inicial do app
      initialRoute: '/',

      // 3. Mapeie os nomes das rotas para as classes das páginas
      routes: {
        '/': (context) => const HomePage(title: 'Pagina inicial'),
        '/images': (context) => const SolarImagePage(),
        '/videos': (context) => const SolarVideoPage(),
        '/mercado': (context) => const MarketPage(),
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
      appBar: AppBar(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.amber),
        ),
        backgroundColor: Color(0xff640000),
        shadowColor: Colors.amber,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        color: const Color(0xff000000),
        child: Container(
          //color: Color(0xff252525),
          decoration: BoxDecoration(
            color: const Color(0xff202000),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, '/images');
                  },
                  child: const Text('imagem'),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, '/videos');
                  },
                  child: const Text('video'),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mercado');
                  },
                  child: const Text('mercado'),
                ),
              ]),
        ),
      ),
    );
  }
}
