import 'package:assignments/screens/root_screen.dart';
import 'package:assignments/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formative Assessment 1',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainScreen(),
    );
  }
}
