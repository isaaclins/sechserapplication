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
  String _inputText = '';

  Future<void> _showInputDialog() async {
    String tempText = _inputText;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Text eingeben'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          tempText += 'A';
                        });
                      },
                      child: const Text('A'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          tempText += 'B';
                        });
                      },
                      child: const Text('B'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          tempText += 'C';
                        });
                      },
                      child: const Text('C'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                child: Text(tempText.isEmpty ? 'Keine Eingabe' : tempText),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                if (tempText.isNotEmpty) {
                  tempText = tempText.substring(0, tempText.length - 1);
                }
                setState(() {});
              },
              child: const Text('Löschen'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _inputText = tempText;
                  _textController.text = tempText;
                });
                Navigator.pop(context);
              },
              child: const Text('Bestätigen'),
            ),
          ],
        );
      },
    );
  }

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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Text zum Schreiben:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _inputText.isEmpty ? 'Keine Eingabe' : _inputText,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _showInputDialog,
                    child: const Text('Text eingeben'),
                  ),
                ],
              ),
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
