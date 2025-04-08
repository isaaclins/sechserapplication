import 'package:flutter/cupertino.dart';
import '../services/storage_service.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  final StorageService _storage = StorageService();

  bool get isDarkMode => _isDarkMode;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _isDarkMode = await _storage.loadSettings();
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await _storage.saveSettings(this);
    notifyListeners();
  }
}
