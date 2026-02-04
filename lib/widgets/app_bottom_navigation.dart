import 'package:flutter/material.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF071A3A),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: "Quizzes",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: "E-learning",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "User",
        ),
      ],
    );
  }
}
