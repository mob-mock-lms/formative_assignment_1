import 'package:flutter/material.dart';
import 'package:assignments/utils/constants.dart';
import 'package:assignments/widgets/attendance_card.dart';

class ProfileMetrics extends StatelessWidget {
  const ProfileMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    // Compute attendance and exits from sessions
    final withAttendance = sessions.where((s) => s.attended != null).toList();
    double attendancePercent = 100.0;
    double exitsPercent = 0.0; // Proxy: percentage of absences
    if (withAttendance.isNotEmpty) {
      final present = withAttendance.where((s) => s.attended == true).length;
      final absent = withAttendance.where((s) => s.attended == false).length;
      attendancePercent = (present / withAttendance.length) * 100.0;
      exitsPercent = (absent / withAttendance.length) * 100.0;
    }

    // Assignment submission percent from assignments list
    final total = assignments.length;
    final completed = assignments.where((a) => a.isCompleted).length;
    final assignmentSubmission = total == 0
        ? 100.0
        : (completed / total) * 100.0;

    Color colorFor(double v) {
      if (v >= 75) return Colors.green;
      if (v >= 50) return Colors.orange;
      return Colors.red;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AttendanceCard(
              percent: '${attendancePercent.toStringAsFixed(0)}%',
              label: 'Attendance',
              color: colorFor(attendancePercent),
            ),
            const SizedBox(width: 10),
            AttendanceCard(
              percent: '${assignmentSubmission.toStringAsFixed(0)}%',
              label: 'Assignment Submission',
              color: colorFor(assignmentSubmission),
            ),
            const SizedBox(width: 10),
            AttendanceCard(
              percent: '${exitsPercent.toStringAsFixed(0)}%',
              label: 'Average Exits',
              color: colorFor(100 - exitsPercent).withValues(alpha: 0.9),
            ),
          ],
        ),
      ],
    );
  }
}
