import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../providers/task_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showDeleteOptions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Delete Tasks'),
        message: const Text('Choose what to delete'),
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              context.read<TaskProvider>().deleteAllTasks();
            },
            child: const Text('Delete All Tasks'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              context.read<TaskProvider>().deleteDoneTasks();
            },
            child: const Text('Delete Done Tasks'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection(
              children: [
                CupertinoListTile(
                  title: const Text('Dark Mode'),
                  trailing: Consumer<SettingsProvider>(
                    builder: (context, settings, child) {
                      return CupertinoSwitch(
                        value: settings.isDarkMode,
                        onChanged: (value) {
                          settings.toggleDarkMode();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CupertinoButton(
                color: CupertinoColors.destructiveRed,
                onPressed: () => _showDeleteOptions(context),
                child: const Text(
                  'Delete Tasks',
                  style: TextStyle(color: CupertinoColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
