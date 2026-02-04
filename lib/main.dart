import 'package:assignments/screens/attendance.dart';
import 'package:assignments/screens/elearning.dart';
import 'package:assignments/screens/quizzes.dart';
import 'package:assignments/screens/profile.dart';
import 'package:assignments/widgets/app_app_bar.dart';
import 'package:assignments/widgets/app_bottom_navigation.dart';
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
  int _selectedTabIndex = 0;

  // List of screens to display for each tab
  final List<Widget> _screens = [
    const AttendanceScreen(),
    const QuizzesScreen(),
    const ElearningScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formative Assessment 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Color(0xFF071A3A))),
      home: Scaffold(
        backgroundColor: const Color(0xFF071A3A),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: AppAppBar(),
        ),
        body: _screens[_selectedTabIndex],
        bottomNavigationBar: AppBottomNavigation(
          currentIndex: _selectedTabIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
