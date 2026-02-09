import 'package:assignments/screens/dashboard.dart';
import 'package:assignments/screens/profile.dart';
import 'package:assignments/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:assignments/screens/attendance.dart';
import 'package:assignments/screens/assignments_screen.dart';
import 'package:assignments/widgets/app_bottom_navigation.dart';
import 'package:assignments/screens/schedule_screen.dart';

import '../models/user_profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTabIndex = 0;
  UserProfile? _userProfile;

  void _handleSignup(UserProfile profile) {
    setState(() {
      _userProfile = profile;
    });
  }

  void _handleSignOut() {
    setState(() {
      _userProfile = null;
      _selectedTabIndex = 0;
    });
  }

  late final List<Widget> _screens = [
    DashboardScreen(),
    AssignmentsScreen(),
    ScheduleScreen(),
    AttendanceScreen(),
    ProfileScreen(profile: _userProfile!, onSignOut: _handleSignOut),
  ];

  void _onTabItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userProfile == null) {
      return SignUpScreen(onSubmit: _handleSignup);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF071A3A),
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