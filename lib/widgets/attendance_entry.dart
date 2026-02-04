import 'package:flutter/material.dart';

class AttendanceEntry extends StatelessWidget {
  final String date;
  final bool attended;

  const AttendanceEntry({
    super.key,
    required this.date,
    required this.attended,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              date,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: const SizedBox(width: 6)),
            Icon(
              Icons.check_circle,
              color: attended ? Colors.green : Colors.red,
              size: 24,
            ),
          ],
        ),
      );
  }
}
