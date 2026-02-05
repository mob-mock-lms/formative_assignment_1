import 'package:flutter/material.dart';

class AppAppBar extends StatelessWidget {
  final String title;

  const AppAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF071A3A),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
    );
  }
}
