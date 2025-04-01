import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothService {
  static Future<bool> isBluetoothAvailable() async {
    return await FlutterBluePlus.isSupported;
  }

  static Future<void> turnOnBluetooth() async {
    if (await FlutterBluePlus.adapterState.first == BluetoothAdapterState.off) {
      await FlutterBluePlus.turnOn();
    }
  }

  static Future<List<ScanResult>> scanDevices() async {
    if (!await isBluetoothAvailable()) {
      throw Exception('Bluetooth wird auf diesem Gerät nicht unterstützt');
    }

    await turnOnBluetooth();
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    return await FlutterBluePlus.scanResults.first;
  }
}
