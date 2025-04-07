import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/ghost_widget.dart';
import 'edit_task_screen.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Done'),
      ),
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final tasks = taskProvider.doneTasks;

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
                      'No completed tasks yet',
                      style: TextStyle(
                        fontSize: 20,
                        color: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .color
                            ?.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return CupertinoListTile(
                backgroundColor:
                    CupertinoTheme.of(context).scaffoldBackgroundColor,
                leading: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    taskProvider.toggleTaskStatus(task.id);
                  },
                  child: const Icon(CupertinoIcons.check_mark_circled),
                ),
                title: Text(
                  task.title,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (task.description != null)
                      Text(
                        task.description!,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    if (task.dueDate != null)
                      Row(
                        children: [
                          Text(
                            'Due: ${task.dueDate!.toLocal().toString().split(' ')[0]} ',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          CountdownTimer(
                            dueDate: task.dueDate!,
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: CupertinoColors.systemGrey,
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
                                builder: (context) => CupertinoAlertDialog(
                                  title: const Text('Delete Task'),
                                  content: const Text(
                                      'Are you sure you want to delete this task?'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text('Cancel'),
                                      onPressed: () => Navigator.pop(context),
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
              );
            },
          );
        },
      ),
    );
  }
}
