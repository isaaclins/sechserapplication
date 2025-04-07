import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;
  TimeOfDay? _dueTime;

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
        builder: (context) => CupertinoAlertDialog(
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

    final DateTime? finalDueDate = _dueDate == null || _dueTime == null
        ? _dueDate
        : DateTime(
            _dueDate!.year,
            _dueDate!.month,
            _dueDate!.day,
            _dueTime!.hour,
            _dueTime!.minute,
          );

    final task = Task(
      id: const Uuid().v4(),
      title: _titleController.text,
      description: _descriptionController.text.isEmpty
          ? null
          : _descriptionController.text,
      dueDate: finalDueDate,
    );

    context.read<TaskProvider>().addTask(task);
    Navigator.pop(context);
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('New Task'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _saveTask,
          child: const Text('Save'),
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
                await showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 300,
                      padding: const EdgeInsets.only(top: 6.0),
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      color:
                          CupertinoColors.systemBackground.resolveFrom(context),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoButton(
                                  child: const Text('Done'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            Expanded(
                              child: CupertinoDatePicker(
                                initialDateTime: _dueDate ?? DateTime.now(),
                                mode: CupertinoDatePickerMode.date,
                                use24hFormat: true,
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(() {
                                    _dueDate = DateTime(
                                      newDate.year,
                                      newDate.month,
                                      newDate.day,
                                      _dueTime?.hour ?? 0,
                                      _dueTime?.minute ?? 0,
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                if (_dueDate != null) {
                  // Show time picker after date is selected
                  await showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 300,
                        padding: const EdgeInsets.only(top: 6.0),
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        color: CupertinoColors.systemBackground
                            .resolveFrom(context),
                        child: SafeArea(
                          top: false,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CupertinoButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  CupertinoButton(
                                    child: const Text('Done'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                              Expanded(
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  mode: CupertinoDatePickerMode.time,
                                  use24hFormat: true,
                                  onDateTimeChanged: (DateTime newTime) {
                                    setState(() {
                                      _dueTime = TimeOfDay(
                                        hour: newTime.hour,
                                        minute: newTime.minute,
                                      );
                                      if (_dueDate != null) {
                                        _dueDate = DateTime(
                                          _dueDate!.year,
                                          _dueDate!.month,
                                          _dueDate!.day,
                                          newTime.hour,
                                          newTime.minute,
                                        );
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: Text(
                _dueDate == null
                    ? 'Add Due Date (optional)'
                    : 'Due: ${_dueDate!.toLocal().toString().split(' ')[0]} ${_dueTime != null ? _formatTime(_dueDate!) : ''}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
