import 'package:assignments/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';

class ElearningScreen extends StatelessWidget {
  const ElearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppAppBar(title: "Your Risk Status"),
      ),
      body: Placeholder(),
    );
  }
}
