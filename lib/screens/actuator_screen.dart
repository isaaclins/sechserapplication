import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActuatorScreen extends StatelessWidget {
  const ActuatorScreen({super.key});

  Future<void> _vibrate() async {
    // Use Flutter's built-in haptic feedback
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aktuator Demo'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Vibrations-Aktuator',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Drücken Sie den Button, um Vibration zu spüren',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _vibrate,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Vibrieren'),
            ),
          ],
        ),
      ),
    );
  }
}
