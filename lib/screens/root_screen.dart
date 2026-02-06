import 'package:assignments/screens/assignments_screen.dart';
import 'package:flutter/material.dart';
import 'package:assignments/screens/signup_screen.dart';
import 'package:assignments/widgets/app_bottom_navigation.dart';
import 'package:assignments/screens/dashboard_screen.dart';
import 'package:assignments/screens/profile_screen.dart';

import '../models/user_profile.dart';
import '../repositories/user_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTabIndex = 0;
  UserProfile? _userProfile;
  final _userRepo = UserRepository();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _userRepo.load();
    if (mounted) {
      setState(() {
        _userProfile = user;
      });
    }
  }

  Future<void> _handleSignup(UserProfile profile) async {
    await _userRepo.save(profile);
    setState(() {
      _userProfile = profile;
    });
  }

  Future<void> _handleSignOut() async {
    await _userRepo.clear();
    setState(() {
      _userProfile = null;
      _selectedTabIndex = 0;
    });
  }

  List<Widget> get _screens => [
    const DashboardScreen(),
    const AssignmentsScreen(),
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
      body: IndexedStack(index: _selectedTabIndex, children: _screens),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _selectedTabIndex,
        onTap: _onTabItemTapped,
      ),
    );
  }
}
