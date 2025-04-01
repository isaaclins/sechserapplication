import 'package:flutter/material.dart';
import 'screens/sensor_screen.dart';
import 'screens/actuator_screen.dart';
import 'screens/communication_screen.dart';
import 'screens/external_interface_screen.dart';
import 'screens/multi_view_screen.dart';
import 'screens/data_storage_screen.dart';
import 'screens/background_operations_screen.dart';
import 'screens/system_interaction_screen.dart';
import 'screens/animation_screen.dart';
import 'screens/platform_specific_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projektarbeit 335',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projektarbeit 335'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFeatureButton(
              context,
              'Sensor auslesen (5 Punkte)',
              const SensorScreen(),
            ),
            _buildFeatureButton(
              context,
              'Aktuator verwenden (4 Punkte)',
              const ActuatorScreen(),
            ),
            _buildFeatureButton(
              context,
              'Bluetooth/NFC/WiFi Kommunikation (6 Punkte)',
              const CommunicationScreen(),
            ),
            _buildFeatureButton(
              context,
              'Externe Schnittstelle (5 Punkte)',
              const ExternalInterfaceScreen(),
            ),
            _buildFeatureButton(
              context,
              'Mehrere Views & Kommunikation (2 Punkte)',
              const MultiViewScreen(),
            ),
            _buildFeatureButton(
              context,
              'Datenablage (2 Punkte)',
              const DataStorageScreen(),
            ),
            _buildFeatureButton(
              context,
              'Hintergrundoperationen (4 Punkte)',
              const BackgroundOperationsScreen(),
            ),
            _buildFeatureButton(
              context,
              'Systeminteraktion (2 Punkte)',
              const SystemInteractionScreen(),
            ),
            _buildFeatureButton(
              context,
              'Animationen (2 Punkte)',
              const AnimationScreen(),
            ),
            _buildFeatureButton(
              context,
              'Plattformspezifische APIs (6 Punkte)',
              const PlatformSpecificScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(
    BuildContext context,
    String title,
    Widget screen,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: 16),
        ),
        child: Text(title),
      ),
    );
  }
}
