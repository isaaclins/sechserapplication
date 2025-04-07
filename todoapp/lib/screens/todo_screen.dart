import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/ghost_widget.dart';
import '../widgets/sad_widget.dart';
import '../widgets/animated_smiley_widget.dart';
import 'new_task_screen.dart';
import 'edit_task_screen.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      navigationBar: const CupertinoNavigationBar(middle: Text('Todo')),
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final tasks = taskProvider.todoTasks;

          return Stack(
            children: [
              ListView.builder(
                itemCount: tasks.isEmpty
                    ? 1
                    : tasks.length +
                        (tasks.any((task) =>
                                task.dueDate != null &&
                                task.dueDate!.isBefore(DateTime.now()))
                            ? 1
                            : 1),
                itemBuilder: (context, index) {
                  if (tasks.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const GhostWidget(),
                            const SizedBox(height: 16),
                            Text(
                              'No tasks yet',
                              style: TextStyle(
                                fontSize: 20,
                                color: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .color,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CupertinoButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const NewTaskScreen(),
                                  ),
                                );
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(CupertinoIcons.add_circled),
                                  SizedBox(width: 8),
                                  Text('Add New Task'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (index == tasks.length) {
                    // Check if there are any overdue tasks
                    bool hasOverdueTasks = tasks.any((task) =>
                        task.dueDate != null &&
                        task.dueDate!.isBefore(DateTime.now()));

                    if (hasOverdueTasks) {
                      // Show sad ghost for overdue tasks
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SadWidget(),
                            const SizedBox(width: 8),
                            Text(
                              'You have overdue tasks!',
                              style: TextStyle(
                                color: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .color,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Show animated smiley for non-overdue tasks
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: AnimatedSmileyWidget(),
                      );
                    }
                  }

                  final task = tasks[index];
                  final bool isOverdue = task.dueDate != null &&
                      task.dueDate!.isBefore(DateTime.now());
                  return Container(
                    decoration: isOverdue
                        ? BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: const Color.fromARGB(255, 255, 0, 0)
                                    .withOpacity(0.8),
                                width: 4,
                              ),
                            ),
                          )
                        : null,
                    child: CupertinoListTile(
                      backgroundColor:
                          CupertinoTheme.of(context).scaffoldBackgroundColor,
                      leading: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          taskProvider.toggleTaskStatus(task.id);
                        },
                        child: const Icon(CupertinoIcons.circle),
                      ),
                      title: Text(task.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (task.description != null) Text(task.description!),
                          if (task.dueDate != null)
                            Row(
                              children: [
                                Text(
                                  'Due: ${task.dueDate!.toLocal().toString().split(' ')[0]} ',
                                  style: const TextStyle(
                                    color: CupertinoColors.systemGrey,
                                  ),
                                ),
                                CountdownTimer(
                                  dueDate: task.dueDate!,
                                  style: const TextStyle(
                                    color: CupertinoColors.systemGrey,
                                  ),
                                ),
                                if (isOverdue)
                                  Container(
                                    margin: const EdgeInsets.only(left: 4),
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 255, 0, 0)
                                              .withOpacity(0.8),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                      trailing: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => CupertinoActionSheet(
                              actions: [
                                CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            EditTaskScreen(task: task),
                                      ),
                                    );
                                  },
                                  child: const Text('Edit Task'),
                                ),
                                CupertinoActionSheetAction(
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoAlertDialog(
                                        title: const Text('Delete Task'),
                                        content: const Text(
                                            'Are you sure you want to delete this task?'),
                                        actions: [
                                          CupertinoDialogAction(
                                            child: const Text('Cancel'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          CupertinoDialogAction(
                                            isDestructiveAction: true,
                                            child: const Text('Delete'),
                                            onPressed: () {
                                              taskProvider.deleteTask(task.id);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text('Delete Task'),
                                ),
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                isDefaultAction: true,
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                            ),
                          );
                        },
                        child: const Icon(CupertinoIcons.ellipsis_circle),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => EditTaskScreen(task: task),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              if (tasks.isNotEmpty)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          CupertinoColors.systemBackground.resolveFrom(context),
                      border: Border(
                        top: BorderSide(
                          color:
                              CupertinoColors.systemGrey4.resolveFrom(context),
                        ),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: CupertinoButton.filled(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const NewTaskScreen(),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.add_circled),
                            SizedBox(width: 8),
                            Text('Add New Task'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
