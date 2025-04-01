import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../services/bluetooth_service.dart' as bt_service;

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  List<ScanResult> devices = [];
  bool isLoading = false;

  Future<void> _scanDevices() async {
    setState(() {
      isLoading = true;
      devices.clear();
    });

    try {
      final results = await bt_service.BluetoothService.scanDevices();
      if (mounted) {
        setState(() {
          devices = results;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Scannen: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Kommunikation'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _scanDevices,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: Text(isLoading ? 'Suche...' : 'Bluetooth-Geräte suchen'),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return ListTile(
                        leading: const Icon(Icons.bluetooth),
                        title: Text(device.device.name.isEmpty
                            ? 'Unbekanntes Gerät'
                            : device.device.name),
                        subtitle: Text(device.device.id.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
