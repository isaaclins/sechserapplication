import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../services/storage_service.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  final StorageService _storage = StorageService();

  List<Task> get tasks => _tasks;
  List<Task> get todoTasks => _tasks.where((task) => !task.isDone).toList();
  List<Task> get doneTasks => _tasks.where((task) => task.isDone).toList();

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final loadedTasks = await _storage.loadTasks();
    _tasks.addAll(loadedTasks);
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _storage.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> updateTask(Task updatedTask) async {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      await _storage.saveTasks(_tasks);
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    await _storage.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> deleteAllTasks() async {
    _tasks.clear();
    await _storage.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> deleteDoneTasks() async {
    _tasks.removeWhere((task) => task.isDone);
    await _storage.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> toggleTaskStatus(String taskId) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(isDone: !_tasks[index].isDone);
      await _storage.saveTasks(_tasks);
      notifyListeners();
    }
  }
}
