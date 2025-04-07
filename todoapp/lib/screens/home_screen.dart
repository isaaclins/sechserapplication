import 'package:flutter/cupertino.dart';
import 'todo_screen.dart';
import 'done_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.checkmark_circle),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return const TodoScreen();
              case 1:
                return const DoneScreen();
              case 2:
                return const SettingsScreen();
              default:
                return const TodoScreen();
            }
          },
        );
      },
    );
  }
}
