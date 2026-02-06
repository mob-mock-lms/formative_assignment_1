import 'package:flutter/material.dart';
import 'package:assignments/theme/app_colors.dart';
import 'package:assignments/theme/app_providers.dart';
import 'package:assignments/widgets/attendance_card.dart';

class ProfileMetrics extends StatefulWidget {
  const ProfileMetrics({super.key});

  @override
  State<ProfileMetrics> createState() => _ProfileMetricsState();
}

class _ProfileMetricsState extends State<ProfileMetrics> {
  final _assignmentRepo = AppProviders.assignmentRepository;
  final _sessionRepo = AppProviders.sessionRepository;

  double _attendancePercent = 100.0;
  double _assignmentSubmission = 100.0;
  double _exitsPercent = 0.0;

  @override
  void initState() {
    super.initState();
    _loadMetrics();
  }

  Future<void> _loadMetrics() async {
    final assignments = await _assignmentRepo.getAll();
    final sessions = await _sessionRepo.getAll();

    // Compute attendance from sessions
    final withAttendance = sessions.where((s) => s.attended != null).toList();
    double attendancePercent = 100.0;
    double exitsPercent = 0.0;
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

    setState(() {
      _attendancePercent = attendancePercent;
      _assignmentSubmission = assignmentSubmission;
      _exitsPercent = exitsPercent;
    });
  }

  Color colorFor(double v) {
    if (v >= 75) return AppColors.success;
    if (v >= 50) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AttendanceCard(
              percent: '${_attendancePercent.toStringAsFixed(0)}%',
              label: 'Attendance',
              color: colorFor(_attendancePercent),
            ),
            const SizedBox(width: 10),
            AttendanceCard(
              percent: '${_assignmentSubmission.toStringAsFixed(0)}%',
              label: 'Assignment Submission',
              color: colorFor(_assignmentSubmission),
            ),
            const SizedBox(width: 10),
            AttendanceCard(
              percent: '${_exitsPercent.toStringAsFixed(0)}%',
              label: 'Average Exits',
              color: colorFor(100 - _exitsPercent).withValues(alpha: 0.9),
            ),
          ],
        ),
      ],
    );
  }
}
