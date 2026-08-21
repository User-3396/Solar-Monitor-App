# Initial Example: 

<details><summary>detalhes</summary>

### Código em Dart (Interface)

No seu arquivo principal em Dart (como `main.dart`), crie o canal e chame a função nativa:

- Importe os serviços do Flutter.
- Defina um `MethodChannel` com um nome único.
- Chame o método assíncrono passando o nome da função do Kotlin.

```kotlin
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KotlinIntegrationDemo extends StatefulWidget {
  @override
  _KotlinIntegrationDemoState createState() => _KotlinIntegrationDemoState();
}

class _KotlinIntegrationDemoState extends State<KotlinIntegrationDemo> {
  static const platform = MethodChannel('com.exemplo/kotlin_bridge');
  String _resultado = 'Aguardando valor do Kotlin...';

  Future<void> _chamarKotlin() async {
    String resposta;
    try {
      final int resultadoInt = await platform.invokeMethod('obterNumeroNativo');
      resposta = 'Sucesso! Número do Kotlin: $resultadoInt';
    } on PlatformException catch (e) {
      resposta = 'Erro: '${e.message};
    }
    setState(() {
      _resultado = resposta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dart + Kotlin no FlutLab')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_resultado),
            ElevatedButton(
              onPressed: _chamarKotlin,
              child: Text('Chamar Código Kotlin'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Código em Kotlin (Nativo Android)

No projeto do FlutLab, abra a pasta estrutural do Android em `android/app/src/main/kotlin/.../MainActivity.kt` e configure o receptor:

- Registre o mesmo nome de canal usado no Dart.
- Use `setMethodCallHandler` para escutar as chamadas.
- Retorne um valor aleatório ou dado nativo com `result.success()`.

```kotlin
package com.exemplo.app // ajuste para o pacote do seu app

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.exemplo/kotlin_bridge"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "obterNumeroNativo") {
                val numeroAleatorio = (1..100).random()
                result.success(numeroAleatorio)
            } else {
                result.notImplemented()
            }
        }
    }
}
```

[How To Use Kotlin Code In Flutter](https://www.youtube.com/watch?v=b6vwXxV0W4Q)

</details>

# Bateria: 

### homepage.dart

<details><summary>detalhes</summary>

```dart
import 'package:user_3301/models/bateria.dart';

...

class _HomePageState extends State<HomePage> {
  final Battery _battery = Battery();
  int _nivelBateria = 0;

  @override
  void initState() {
    super.initState();

    // leitura inicial
    _getBatteryLevel();

    // escuta contínua
    Battery.batteryLevelStream().listen((nivel) {
      setState(() => _nivelBateria = nivel);
    }, onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("<Erro> (batteryLevelStream): $e"),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  Future<void> _getBatteryLevel() async {
    try {
      final nivel = await _battery.getBatteryLevel();
      setState(() => _nivelBateria = nivel);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: const Color(0xff490500),
            content: Text("<Erro> (_getBatteryLevel): $e",
                style: const TextStyle(color: Colors.white)),
            action: SnackBarAction(
              label: "Ok",
              textColor: Colors.yellow,
              onPressed: () {
                // Exemplo: apenas fechar o snackbar ou registrar log
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            )
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ...
  }
}
```

### Exemplo 2:

```kotlin
package com.example.seu_projeto // Substitua pelo pacote do seu projeto

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    // Nome do canal deve ser EXATAMENTE igual ao definido no Dart
    private val CHANNEL = "samples.flutter.dev/battery"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // 3. Configure o MethodChannel para ouvir os comandos do Dart
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            // Verifica se o comando solicitado é o 'getBatteryLevel'
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    // Retorna o sucesso e o valor para o Dart
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Nível de bateria não disponível.", null)
                }
            } else {
                // Caso o Dart envie um comando não mapeado
                result.notImplemented()
            }
        }
    }

    // 4. Código nativo Android em Kotlin para ler a bateria
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
    }
}
```

</details>

### /models/bateria.dart

<details><summary>detalhes</summary>

```dart
import 'package:flutter/services.dart';
import 'dart:async'; // não é obrigatorio se houver '.listen()'

class Battery {
  static const _channel = MethodChannel('user_3301.dev/battery');
//Escuta mudanças contínuas (stream)
  static const EventChannel _eventChannel =
      EventChannel('user_3301.dev/batteryStream');

  // Consulta pontual:
  Future<int> getBatteryLevel() async {
    try {
      final nivel = await _channel.invokeMethod<int>('getBatteryLevel');
      return nivel ?? 0;
    } on PlatformException catch (e) {
      print("Erro > Nivel_bateria > consulta_pontual: ${e.message}");
      return 0;
    } catch (e, s) {
      print("$e - $s");
      return 0;
    }
  }

  // C
  static Stream<int> batteryLevelStream() {
    return _eventChannel.receiveBroadcastStream().map((event) => event as int);
  }
}
```

</details>

### /android/app/src/main/kotlin/com/example/user_3301/BatteryActivity.kt

<details><summary>detalhes</summary>

```kotlin
package com.example.user_3301

import android.content.Context
import android.os.BatteryManager
import android.content.Intent
import android.content.IntentFilter

object BatteryHelper {
    fun getBatteryLevel(context: Context): Int {
        val bm = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}
```

</details>

### /android/app/src/main/kotlin/com/example/user_3301/MainActivity.kt

<details><summary>detalhes</summary>

```kotlin
package com.example.user_3301
import android.os.BatteryManager
//import android.content.BroadcastReceiver
//import android.content.Context
//import android.content.Intent
//import android.content.IntentFilter


//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugin.common.EventChannel
//import kotlin.concurrent.thread
//import kotlinx.coroutines.CompletableDeferred

class MainActivity : FlutterActivity(){
  // Channel para bateria
  MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "user_3301.dev/battery").setMethodCallHandler { call, result ->
    if (call.method == "obterNivel") {
      val nivel = BatteryHelper.getBatteryLevel(this)
      result.success(nivel)
    } else {
      result.notImplemented()
    }
  } //MethodChannel


  // Stream contínuo de bateria: 
  EventChannel(flutterEngine.dartExecutor.binaryMessenger, "user_3301.dev/batteryStream").setStreamHandler(object : EventChannel.StreamHandler {
    private var receiver: BroadcastReceiver? = null
  
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
      receiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
          val nivel = intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
          events?.success(nivel)
        }
      }
      val filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
      registerReceiver(receiver, filter)
    }
  
    override fun onCancel(arguments: Any?) {
      unregisterReceiver(receiver)
      receiver = null
    }
  })
}
```

</details>

# VPN

### android/app/src/main/kotlin/com/example/user_3301/TrafficVpnService.kt

<details><summary>detalhes</summary>

```kotlin
package com.example.user_3301

import io.flutter.plugin.common.EventChannel
import android.net.VpnService
import android.os.ParcelFileDescriptor
import android.os.BatteryManager
import android.content.Intent 
import android.content.IntentFilter
import java.io.FileInputStream
import java.nio.ByteBuffer
import java.net.InetAddress



class TrafficVpnService : VpnService(), Runnable {
    private var vpnInterface: ParcelFileDescriptor? = null
    private var thread: Thread? = null
    private var eventSink: EventChannel.EventSink? = null

    // Flutter injeta o EventSink para enviar dados ao Dart
    fun setEventSink(sink: EventChannel.EventSink?) {
        eventSink = sink
    }

    override fun onCreate() {
        super.onCreate()
        thread = Thread(this, "TrafficVpnThread")
        thread?.start()
    }

    override fun onDestroy() {
        thread?.interrupt()
        vpnInterface?.close()
        super.onDestroy()
    }

    override fun run() {
        // Configuração básica da VPN
        val builder = Builder()
        builder.addAddress("10.0.0.2", 32)
        builder.addRoute("0.0.0.0", 0)
        vpnInterface = builder.establish()

        val inputStream = FileInputStream(vpnInterface!!.fileDescriptor)
        val buffer = ByteBuffer.allocate(32767)

        while (!Thread.interrupted()) {
            val nivelBat =getBatteryLevel()
            if (nivelBat <= 17){
                eventSink?.success("Captura encerrada: $nivelBat% de bateria.")
                stopSelf()
                break
            }
            
            buffer.clear()
            val length = inputStream.read(buffer.array())
            if (length > 0) {
                buffer.limit(length)
                if (length >= 20) { // Mínimo para header IP
                    val info = PacketParser.parsePacket(buffer)
                    eventSink?.success(info)
                } else {
                    eventSink?.success("Pacote ignorado: tamanho $length < 20")
                }
            } else if (length == -1) {
                // EOF, talvez reconectar ou parar
                break
            }
            // Pequena pausa para não sobrecarregar
            Thread.sleep(10)
        }
    }

    // Obtém nível de bateria atual
    private fun getBatteryLevel(): Int {
        val bm = getSystemService(BATTERY_SERVICE) as BatteryManager 
        return bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}

// Parser de pacotes IPv4/TCP/UDP
object PacketParser {
    fun parsePacket(buffer: ByteBuffer): String {
        buffer.position(0)

        if (buffer.remaining() < 20) return "Pacote muito pequeno"

        val versionAndIhl = buffer.get().toInt()
        val version = (versionAndIhl shr 4) and 0xF
        val ihl = (versionAndIhl and 0xF) * 4

        if (version == 4) {
            return parseIPv4(buffer, ihl)
        } else if (version == 6) {
            return parseIPv6(buffer)
        } else {
            return "Versão IP não suportada: $version"
        }
    }

    private fun parseIPv4(buffer: ByteBuffer, ihl: Int): String {
        if (buffer.remaining() < ihl) return "Header IPv4 incompleto"

        buffer.get() // TOS
        val totalLength = buffer.short.toInt() and 0xFFFF
        buffer.short // identificação
        buffer.short // flags + fragment offset
        val ttl = buffer.get().toInt() and 0xFF
        val protocol = buffer.get().toInt() and 0xFF
        buffer.short // checksum

        val srcBytes = ByteArray(4)
        buffer.get(srcBytes)
        val srcIp = try {
            InetAddress.getByAddress(srcBytes).hostAddress
        } catch (e: Exception) {
            "IP inválido"
        }

        val dstBytes = ByteArray(4)
        buffer.get(dstBytes)
        val dstIp = try {
            InetAddress.getByAddress(dstBytes).hostAddress
        } catch (e: Exception) {
            "IP inválido"
        }

        // Pular opções se houver
        val optionsLength = ihl - 20
        if (optionsLength > 0 && buffer.remaining() >= optionsLength) {
            buffer.position(buffer.position() + optionsLength)
        }

        var srcPort = -1
        var dstPort = -1
        var protoName = getProtocolName(protocol)

        if ((protocol == 6 || protocol == 17) && buffer.remaining() >= 8) { // TCP ou UDP
            srcPort = buffer.short.toInt() and 0xFFFF
            dstPort = buffer.short.toInt() and 0xFFFF
        }

        return "$protoName $srcIp:$srcPort → $dstIp:$dstPort (TTL=$ttl, Len=$totalLength)"
    }

    private fun parseIPv6(buffer: ByteBuffer): String {
        if (buffer.remaining() < 40) return "Header IPv6 incompleto"

        buffer.get() // Traffic Class (parte)
        buffer.short // Flow Label
        val payloadLength = buffer.short.toInt() and 0xFFFF
        val nextHeader = buffer.get().toInt() and 0xFF
        val hopLimit = buffer.get().toInt() and 0xFF

        val srcBytes = ByteArray(16)
        buffer.get(srcBytes)
        val srcIp = try {
            InetAddress.getByAddress(srcBytes).hostAddress
        } catch (e: Exception) {
            "IPv6 inválido"
        }

        val dstBytes = ByteArray(16)
        buffer.get(dstBytes)
        val dstIp = try {
            InetAddress.getByAddress(dstBytes).hostAddress
        } catch (e: Exception) {
            "IPv6 inválido"
        }

        var srcPort = -1
        var dstPort = -1
        var protoName = getProtocolName(nextHeader)

        if ((nextHeader == 6 || nextHeader == 17) && buffer.remaining() >= 8) { // TCP ou UDP
            srcPort = buffer.short.toInt() and 0xFFFF
            dstPort = buffer.short.toInt() and 0xFFFF
        }

        return "$protoName [$srcIp]:$srcPort → [$dstIp]:$dstPort (HopLimit=$hopLimit, PayloadLen=$payloadLength)"
    }

    private fun getProtocolName(protocol: Int): String {
        return when (protocol) {
            1 -> "ICMP"
            2 -> "IGMP"
            6 -> "TCP"
            17 -> "UDP"
            41 -> "IPv6"
            58 -> "ICMPv6"
            else -> "PROTO_$protocol"
        }
    }
}
```

permissoes em /src/main/AndroidManifest.xml

```xml
<manifest 
    xmlns:android="http://schemas.android.com/apk/res/android" 
    xmlns:tools="http://schemas.android.com/tools">
    <!-- Permissão para acessar estatísticas de uso -->
    <uses-permission android:name="android.permission.PACKAGE_USAGE_STATS" tools:ignore="ProtectedPermissions" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <application
        android:label="user3301"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data 
                android:name="io.flutter.embedding.android.NormalTheme" 
                android:resource="@style/NormalTheme"/>
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <service
            android:name=".TrafficVpnService"
            android:permission="android.permission.BIND_VPN_SERVICE"
            android:exported="true">
            <intent-filter>
                <action android:name="android.net.VpnService" />
            </intent-filter>
        </service>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data android:name="flutterEmbedding" android:value="2" />
    </application>
    <!-- Required to query activities that can process text, see:
         https://developer.android.com/training/package-visibility and
         https://developer.android.com/reference/android/content/Intent#ACTION_PROCESS_TEXT.

         In particular, this is used by the Flutter engine in io.flutter.plugin.text.ProcessTextPlugin. -->
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>
```

</details>

### /lib/vpn_channel.dart

<details><summary>detalhes</summary>

```kotlin
import 'package:flutter/services.dart';

/// Classe que encapsula o canal de comunicação com o Android
/// para pedir permissão de VPN em tempo de execução.
class VpnChannel {
  // Nome do canal deve ser o mesmo usado no MainActivity.kt
  static const MethodChannel _channel = MethodChannel('user_3301.dev/vpn');

  /// Pede permissão de VPN ao Android.
  /// Retorna true se já tem permissão ou se o usuário aceitou,
  /// false se ainda está pendente ou foi negado.
  static Future<bool> requestVpnPermission() async {
    try {
      final granted = await _channel.invokeMethod<bool>('requestVpnPermission');
      return granted ?? false;
    } on PlatformException catch (e) {
      // Tratamento de erro caso o canal falhe
      print("Erro ao pedir permissão VPN: ${e.message}");
      return false;
    }
  }
}
```

</details>
  
### lib/traffic_channel.dart

<details><summary>detalhes</summary>

```kotlin
import 'package:flutter/services.dart';

class TrafficChannel {
  static const EventChannel _eventChannel =
      EventChannel('user_3301.dev/traffic');

  static Stream<String> trafficStream() {
    return _eventChannel
        .receiveBroadcastStream()
        .map((event) => event as String);
  }
}

// class VpnChannel {
//   static const MethodChannel _channel = MethodChannel('user_3301.dev/vpn');
//   static Future<bool> requestVpnPermission() async {
//     final granted = await _channel.invokeMethod<bool>('requestVpnPermission');
//     return granted ?? false;
//   }
// }
/*

- Cada pacote interceptado pelo VpnService é parseado pelo PacketParser.
- Extraímos IP origem/destino, portas, protocolo, TTL, tamanho.
- Enviamos como string para o Flutter via EventChannel.
- No Flutter, você pode ouvir TrafficChannel.trafficStream() e atualizar sua UI (TrafficPage) em tempo real.
 
 */
```

</details>

### lib/pages/traffic_page.dart

<details><summary>detalhes</summary>

```kotlin
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:user_3301/traffic_channel.dart';
import 'package:user_3301/vpn_channel.dart'; // canal de permissão VPN

class TrafficPage extends StatefulWidget {
  const TrafficPage({Key? key}) : super(key: key);

  @override
  State<TrafficPage> createState() => _TrafficPageState();
}

class _TrafficPageState extends State<TrafficPage> {
  bool _capturando = false;
  final List<String> _trafego = [];
  Stream<String>? _stream;
  StreamSubscription<String>? _subscription;

  void _startCapture() {
    setState(() {
      _capturando = true;
      _trafego.clear();
    });

    _stream = TrafficChannel.trafficStream();
    _subscription = _stream!.listen((packet) {
      setState(() {
        _trafego.insert(0, packet);
        if (_trafego.length > 70) {
          _trafego.removeLast();
        }
      });
    }, onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao capturar tráfego: $e",
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Color(0xff460500),
        ),
      );
    });
  }

  void _stopCapture() {
    _subscription?.cancel();
    setState(() {
      _capturando = false;
    });
  }

  void _sendReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Relatório enviado (futuro Supabase)"),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tráfego de Rede")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _capturando ? null : _startCapture,
                child: const Text("Start"),
              ),
              ElevatedButton(
                onPressed: _capturando ? _stopCapture : null,
                child: const Text("Stop"),
              ),
              ElevatedButton(
                onPressed: _sendReport,
                child: const Text("Send"),
              ),
            ],
          ),
          const Divider(),
          Column(children: [
            ElevatedButton(
              onPressed: () async {
                final granted = await VpnChannel.requestVpnPermission();
                if (granted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Permissão de VPN concedida. Iniciando captura...")),
                  );

                  // iniciando a captura automaticamente
                  _startCapture();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Permissão de VPN negada ou cancelada")),
                  );
                }
              },
              child: const Text("Pedir Permissão VPN"),
            ),
          ]),
          const Divider(),
          Expanded(
              child: _capturando
                  ? Center(
                      child: CircularProgressIndicator(
                        //value: 0.7, // 70% progress
                        backgroundColor: Color(0xff007ad7),
                        //valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 5.0,
                      ),
                    )
                  : _trafego.isEmpty
                      ? const Text("Sem captura.")
                      : ListView.builder(
                          itemCount: _trafego.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              title: Text(_trafego[index]),
                            );
                          },
                        )),
        ],
      ),
    );
  }
}
```

</details>
