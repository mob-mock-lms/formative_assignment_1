import 'package:flutter/material.dart';

class AppAppBar extends StatelessWidget {
  const AppAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF071A3A),
      title: const Text(
        "Your Risk Status",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}
