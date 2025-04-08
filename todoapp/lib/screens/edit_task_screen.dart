import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(
      text: widget.task.description,
    );
    _dueDate = widget.task.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_titleController.text.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder:
            (context) => CupertinoAlertDialog(
              title: const Text('Error'),
              content: const Text('Title cannot be empty'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
      return;
    }

    final updatedTask = widget.task.copyWith(
      title: _titleController.text,
      description:
          _descriptionController.text.isEmpty
              ? null
              : _descriptionController.text,
      dueDate: _dueDate,
    );

    context.read<TaskProvider>().updateTask(updatedTask);
    Navigator.pop(context);
  }

  void _deleteTask() {
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: const Text('Delete Task'),
            content: const Text('Are you sure you want to delete this task?'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text('Delete'),
                onPressed: () {
                  context.read<TaskProvider>().deleteTask(widget.task.id);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Edit Task'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _deleteTask,
              child: const Icon(CupertinoIcons.delete),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _saveTask,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CupertinoTextField(
              controller: _titleController,
              placeholder: 'Title',
              padding: const EdgeInsets.all(16),
            ),
            const SizedBox(height: 16),
            CupertinoTextField(
              controller: _descriptionController,
              placeholder: 'Description (optional)',
              padding: const EdgeInsets.all(16),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            CupertinoButton(
              onPressed: () async {
                final date = await showCupertinoModalPopup<DateTime>(
                  context: context,
                  builder:
                      (context) => Container(
                        height: 216,
                        padding: const EdgeInsets.only(top: 6.0),
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        color: CupertinoColors.systemBackground.resolveFrom(
                          context,
                        ),
                        child: SafeArea(
                          top: false,
                          child: CupertinoDatePicker(
                            initialDateTime: _dueDate ?? DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: true,
                            onDateTimeChanged: (DateTime newDate) {
                              setState(() {
                                _dueDate = newDate;
                              });
                            },
                          ),
                        ),
                      ),
                );
                if (date != null) {
                  setState(() {
                    _dueDate = date;
                  });
                }
              },
              child: Text(
                _dueDate == null
                    ? 'Add Due Date (optional)'
                    : 'Due Date: ${_dueDate!.toLocal().toString().split(' ')[0]}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
