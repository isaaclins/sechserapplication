import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return CupertinoApp(
            title: 'Todo App',
            theme: CupertinoThemeData(
              primaryColor: CupertinoColors.systemBlue,
              brightness:
                  settings.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
