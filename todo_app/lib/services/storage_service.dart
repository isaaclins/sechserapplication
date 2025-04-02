import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/todo.dart';

class StorageService {
  static const String _fileName = 'todos.json';
  List<Todo> _todos = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  Future<List<Todo>> loadTodos() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(contents);
      _todos = jsonList.map((json) => Todo.fromJson(json)).toList();
      return _todos;
    } catch (e) {
      return [];
    }
  }

  Future<void> saveTodos() async {
    final file = await _localFile;
    final jsonList = _todos.map((todo) => todo.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  Future<void> addTodo(Todo todo) async {
    _todos.add(todo);
    await saveTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      await saveTodos();
    }
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((todo) => todo.id == id);
    await saveTodos();
  }
}
