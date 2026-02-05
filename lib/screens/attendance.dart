import 'dart:math';

import 'package:assignments/widgets/app_app_bar.dart';
import 'package:assignments/widgets/attendance_entry.dart';
import 'package:flutter/material.dart';
import '../widgets/attendance_card.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppAppBar(title: "Your Risk Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello Alex, At Risk",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Risk cards row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                AttendanceCard(
                  percent: "75%",
                  label: "Attendance",
                  color: Colors.red,
                ),
                AttendanceCard(
                  percent: "60%",
                  label: "Assignment Submission",
                  color: Colors.orange,
                ),
                AttendanceCard(
                  percent: "63%",
                  label: "Average Exits",
                  color: Colors.redAccent,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Attendance history entries
            const Text(
              "Attendance History",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      // No attendance entries case
                      // modify condition to test list of attendance length
                      if (false)
                        const Center(
                          child: Text(
                            "No attendance records found.",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                        )
                      else
                        // Display all attendance entries
                        for (var i = 1; i <= 31; i++)
                          AttendanceEntry(
                            date: "2024-06-${i < 10 ? '0$i' : i}",
                            attended: Random().nextBool(),
                          ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Help Card
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Need Help?'),
                      content: const Text(
                        'Your attendance and assignment risk status is shown above. '
                        'If you have questions, please contact your instructor or advisor.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Get Help",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
