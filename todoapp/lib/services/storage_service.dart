import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../providers/settings_provider.dart';

class StorageService {
  static const String _tasksKey = 'tasks';
  static const String _settingsKey = 'settings';

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks
        .map((task) => {
              'id': task.id,
              'title': task.title,
              'description': task.description,
              'dueDate': task.dueDate?.toIso8601String(),
              'isDone': task.isDone,
            })
        .toList();
    await prefs.setString(_tasksKey, jsonEncode(tasksJson));
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString(_tasksKey);
    if (tasksJson == null) return [];

    final List<dynamic> tasksList = jsonDecode(tasksJson);
    return tasksList
        .map((task) => Task(
              id: task['id'],
              title: task['title'],
              description: task['description'],
              dueDate: task['dueDate'] != null
                  ? DateTime.parse(task['dueDate'])
                  : null,
              isDone: task['isDone'],
            ))
        .toList();
  }

  Future<void> saveSettings(SettingsProvider settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_settingsKey, settings.isDarkMode);
  }

  Future<bool> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_settingsKey) ?? false;
  }
}
