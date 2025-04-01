import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BackgroundOperationsScreen extends StatefulWidget {
  const BackgroundOperationsScreen({super.key});

  @override
  State<BackgroundOperationsScreen> createState() =>
      _BackgroundOperationsScreenState();
}

class _BackgroundOperationsScreenState
    extends State<BackgroundOperationsScreen> {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _isProcessing = false;
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _notifications.initialize(initSettings);
  }

  Future<void> _showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'background_channel',
      'Background Operations',
      channelDescription: 'Notifications for background operations',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notifications.show(
      0,
      'Hintergrundoperation',
      'Eine Benachrichtigung wurde gesendet',
      details,
    );
  }

  Future<void> _startBackgroundTask() async {
    setState(() {
      _isProcessing = true;
      _progress = 0;
    });

    // Simuliere eine Hintergrundoperation
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _progress = i;
      });
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
