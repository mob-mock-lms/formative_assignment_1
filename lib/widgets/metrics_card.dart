import 'package:flutter/material.dart';

class MetricsCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool goodPerformance;

  const MetricsCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.goodPerformance,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = goodPerformance
        ? const Color(0xFF66BB6A)
        : const Color(0xFFFFB74D);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
