import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/storage_service.dart';
import 'todo_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StorageService _storageService = StorageService();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _storageService.loadTodos();
    setState(() {
      _todos = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return Dismissible(
            key: Key(todo.id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 16),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async {
              await _storageService.deleteTodo(todo.id);
              setState(() {
                _todos.removeAt(index);
              });
            },
            child: ListTile(
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (bool? value) async {
                  if (value != null) {
                    todo.isCompleted = value;
                    await _storageService.updateTodo(todo);
                    setState(() {});
                  }
                },
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration:
                      todo.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text(todo.description),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoDetailScreen(todo: todo),
                  ),
                );
                if (result == true) {
                  _loadTodos();
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TodoDetailScreen(),
            ),
          );
          if (result == true) {
            _loadTodos();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
