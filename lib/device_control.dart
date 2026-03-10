import 'package:flutter/services.dart';

class DeviceControl {
  static const MethodChannel _channel = MethodChannel(
    'emi_locker/device_control',
  );

  static Future lockDevice() async {
    await _channel.invokeMethod("lockDevice");
  }

  static Future unlockDevice() async {
    await _channel.invokeMethod("unlockDevice");
  }
}
