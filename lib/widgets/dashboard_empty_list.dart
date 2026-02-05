import 'package:flutter/material.dart';

class DashboardEmptyList extends StatelessWidget {
  final String message;
  final IconData? icon;

  const DashboardEmptyList({super.key, required this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            if (icon != null)
              Icon(icon, color: Colors.white.withValues(alpha: 0.3), size: 48),
            if (icon != null) const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
