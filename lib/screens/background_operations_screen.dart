import 'package:flutter/material.dart';

class BackgroundOperationsScreen extends StatefulWidget {
  const BackgroundOperationsScreen({super.key});

  @override
  State<BackgroundOperationsScreen> createState() =>
      _BackgroundOperationsScreenState();
}

class _BackgroundOperationsScreenState
    extends State<BackgroundOperationsScreen> {
  bool _isProcessing = false;
  int _progress = 0;

  Future<void> _showNotification() async {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Eine Benachrichtigung wurde gesendet'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _startBackgroundTask() async {
    setState(() {
      _isProcessing = true;
      _progress = 0;
    });

    // Simuliere eine Hintergrundoperation
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          _progress = i;
        });
      }
    }

    setState(() {
      _isProcessing = false;
    });

    await _showNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hintergrundoperationen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hintergrundoperationen Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (_isProcessing) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                'Fortschritt: $_progress%',
                style: const TextStyle(fontSize: 18),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isProcessing ? null : _startBackgroundTask,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: Text(_isProcessing
                  ? 'Verarbeitung läuft...'
                  : 'Hintergrundoperation starten'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showNotification,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Benachrichtigung senden'),
            ),
          ],
        ),
      ),
    );
  }
}
