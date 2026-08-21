import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Battery_Channel {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  int nivel = 0;

  //static const _channel = MethodChannel('user_3301.dev/battery');

  //Escuta mudanças contínuas (stream)
  //static const EventChannel _eventChannel =EventChannel('user_3301.dev/batteryStream');
  //

  Future<String> getBatteryLevel() async {
    try {
      //final int? result = await platform.invokeMethod<int>('getBatteryLevel');
      final int? result = await platform.invokeMethod('getBatteryLevel');
      return result.toString();
      //batteryLevelResult = 'Nível da bateria: $result%.';
      //} on PlatformException catch (e) {
    } catch (e) {
      //batteryLevelResult = "Falha ao obter a bateria: '${e.message}'.";
      return e.toString();
    }

    //return -1;
  }
}
