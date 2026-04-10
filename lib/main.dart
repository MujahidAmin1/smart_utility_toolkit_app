import 'package:flutter/material.dart';
import 'package:smart_utility_toolkit_app/homescreen.dart';
import 'package:smart_utility_toolkit_app/utils/app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.dark,

      title: 'Flutter Demo',
      home: const HomeScreen(),
    );
  }
}
