import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class PlatformSpecificScreen extends StatefulWidget {
  const PlatformSpecificScreen({super.key});

  @override
  State<PlatformSpecificScreen> createState() => _PlatformSpecificScreenState();
}

class _PlatformSpecificScreenState extends State<PlatformSpecificScreen> {
  static const platform =
      MethodChannel('com.example.sechserapplication/platform');
  String _platformVersion = 'Unbekannt';
  String _batteryLevel = 'Unbekannt';

  Future<void> _getPlatformVersion() async {
    String platformVersion;
    try {
      platformVersion = await platform.invokeMethod('getPlatformVersion');
    } on PlatformException catch (e) {
      platformVersion =
          "Fehler beim Abrufen der Plattformversion: ${e.message}";
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Batterie-Level: $result%';
    } on PlatformException catch (e) {
      batteryLevel = "Fehler beim Abrufen des Batterie-Levels: ${e.message}";
    }

    if (!mounted) return;

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plattformspezifische Features'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Plattformspezifische Features Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Text(
              'Plattform: ${Platform.isAndroid ? 'Android' : 'iOS'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Plattformversion: $_platformVersion',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              _batteryLevel,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _getPlatformVersion,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Plattformversion abrufen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getBatteryLevel,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Batterie-Level abrufen'),
            ),
            if (Platform.isAndroid) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  SystemChrome.setSystemUIOverlayStyle(
                    const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Statusleiste anpassen'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
