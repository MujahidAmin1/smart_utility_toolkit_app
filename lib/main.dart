import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:smart_utility_toolkit_app/homescreen.dart';
import 'package:smart_utility_toolkit_app/models/task_model.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.dark,
      title: 'Smart Toolkit',
      home: const HomeScreen(),
    );
  }
}
