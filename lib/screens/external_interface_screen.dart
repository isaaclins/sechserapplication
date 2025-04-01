import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ExternalInterfaceScreen extends StatefulWidget {
  const ExternalInterfaceScreen({super.key});

  @override
  State<ExternalInterfaceScreen> createState() =>
      _ExternalInterfaceScreenState();
}

class _ExternalInterfaceScreenState extends State<ExternalInterfaceScreen> {
  final TextEditingController _textController = TextEditingController();
  String _readContent = '';

  Future<void> _writeToFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/test.txt');
      await file.writeAsString(_textController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datei wurde erfolgreich geschrieben')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Schreiben: $e')),
        );
      }
    }
  }

  Future<void> _readFromFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/test.txt');
      if (await file.exists()) {
        final content = await file.readAsString();
        setState(() {
          _readContent = content;
        });
      } else {
        setState(() {
          _readContent = 'Keine Datei gefunden';
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Lesen: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Externe Schnittstelle'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Text zum Schreiben',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _writeToFile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('In Datei schreiben'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _readFromFile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Aus Datei lesen'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Gelesener Inhalt:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_readContent),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
