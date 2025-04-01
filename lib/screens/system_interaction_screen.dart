import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class SystemInteractionScreen extends StatefulWidget {
  const SystemInteractionScreen({super.key});

  @override
  State<SystemInteractionScreen> createState() =>
      _SystemInteractionScreenState();
}

class _SystemInteractionScreenState extends State<SystemInteractionScreen> {
  CameraController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Fehler bei der Kamera-Initialisierung: $e');
    }
  }

  Future<void> _takePicture() async {
    if (!_isInitialized) return;

    try {
      final image = await _controller!.takePicture();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Foto gespeichert: ${image.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Fotografieren: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Systeminteraktion'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (_isInitialized)
            Expanded(
              child: CameraPreview(_controller!),
            )
          else
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _isInitialized ? _takePicture : null,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Foto aufnehmen'),
            ),
          ),
        ],
      ),
    );
  }
}
