import 'package:assignments/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppAppBar(title: "Quizzes"),
      ),
      body: Placeholder(),
    );
  }
}
