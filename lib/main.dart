import 'package:assignments/screens/attendance.dart';
import 'package:assignments/screens/dashboard.dart';
import 'package:assignments/screens/elearning.dart';
import 'package:assignments/screens/quizzes.dart';
import 'package:assignments/screens/profile.dart';
import 'package:assignments/screens/signup.dart';
import 'package:assignments/widgets/app_app_bar.dart';
import 'package:assignments/widgets/app_bottom_navigation.dart';
import 'package:assignments/models/user_profile.dart';
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
<<<<<<< irene-dashboard

  // List of screens to display for each tab
  final List<Widget> _screens = [
    DashboardScreen(),
    const AttendanceScreen(),
    const QuizzesScreen(),
    const ElearningScreen(),
    const ProfileScreen(),
  ];
=======
  UserProfile? _userProfile;
>>>>>>> main

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    if (_userProfile == null) {
      return MaterialApp(
        title: 'Formative Assessment 1',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF071A3A)),
        ),
        home: SignUpScreen(onSubmit: _handleSignup),
      );
    }

    final screens = [
      const AttendanceScreen(),
      const QuizzesScreen(),
      const ElearningScreen(),
      ProfileScreen(profile: _userProfile!, onSignOut: _handleSignOut),
    ];

    return MaterialApp(
      title: 'Formative Assessment 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF071A3A)),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFF071A3A),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: AppAppBar(),
        ),
        body: screens[_selectedTabIndex],
        bottomNavigationBar: AppBottomNavigation(
          currentIndex: _selectedTabIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
