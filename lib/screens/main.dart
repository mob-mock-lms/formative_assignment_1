import 'package:assignments/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:assignments/screens/attendance.dart';
import 'package:assignments/screens/elearning.dart';
import 'package:assignments/screens/quizzes.dart';
import 'package:assignments/widgets/app_app_bar.dart';
import 'package:assignments/widgets/app_bottom_navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTabIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    QuizzesScreen(),
    ElearningScreen(),
    AttendanceScreen(),
  ];

  void _onTabItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF071A3A),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppAppBar(),
      ),
      // IndexedStack preserves the state of pages like scroll if you switch between them
      body: IndexedStack(
        index: _selectedTabIndex,
        children: _screens,
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _selectedTabIndex,
        onTap: _onTabItemTapped,
      ),
    );
  }
}