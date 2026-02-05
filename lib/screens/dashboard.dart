import 'package:assignments/models/assignment.dart';
import 'package:assignments/models/assignment_session.dart';
import 'package:assignments/utils/constants.dart';
import 'package:assignments/widgets/assignments_list.dart';
import 'package:assignments/widgets/dashboard_empty_list.dart';
import 'package:assignments/widgets/dashboard_section_header.dart';
import 'package:assignments/widgets/help_card.dart';
import 'package:assignments/widgets/metrics_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/date_time_extension.dart';
import '../widgets/dashboard_quick_stat_card.dart';
import '../widgets/sessions_list.dart';
import '../widgets/risk_banner.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Sample data - your teammates can add their real data here
  final List<Assignment> _assignments = assignments;

  final List<AcademicSession> _sessions = sessions;

  // Getters for computed values
  List<AcademicSession> get todaysSessions {
    return _sessions.where((session) => session.isToday()).toList()
      ..sort((a, b) {
        final aMinutes = a.startTime.hour * 60 + a.startTime.minute;
        final bMinutes = b.startTime.hour * 60 + b.startTime.minute;
        return aMinutes.compareTo(bMinutes);
      });
  }

  List<Assignment> get upcomingAssignments {
    final now = DateTime.now();
    return _assignments.where((assignment) {
      if (assignment.isCompleted) return false;
      final daysUntilDue = assignment.dueDate.difference(now).inDays;
      return daysUntilDue >= 0 && daysUntilDue <= 7;
    }).toList()..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  int get pendingAssignmentsCount {
    return _assignments.where((a) => !a.isCompleted).length;
  }

  double get attendancePercentage {
    final sessionsWithAttendance = _sessions
        .where((s) => s.attended != null)
        .toList();
    if (sessionsWithAttendance.isEmpty) return 100.0;

    final presentCount = sessionsWithAttendance
        .where((s) => s.attended == true)
        .length;
    return (presentCount / sessionsWithAttendance.length) * 100;
  }

  double get assignmentAttainment {
    if (_assignments.isEmpty) return 100.0;
    final completed = _assignments.where((a) => a.isCompleted).length;
    return (completed / _assignments.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat('EEEE, MMM d, y').format(DateTime.now());
    final int weekOfYear = ((DateTime.now().dayOfYear + 6) ~/ 7);

    final attendancePercent = attendancePercentage;
    final assignmentAttainmentPercent = assignmentAttainment;
    final averageGrade = 63.0; // Placeholder - calculate from actual grades

    final bool isAtRisk = attendancePercent < 75;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF071A3A),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // greeting and date section
              Text(
                'Hello Alex 👋',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$today - Week $weekOfYear',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 24),

              // risk warning banner
              if (isAtRisk) RiskBanner(),

              if (isAtRisk) const SizedBox(height: 20),

              // metrics cards row
              Row(
                children: [
                  MetricsCard(
                    label: 'Attendance',
                    value: '${attendancePercent.toStringAsFixed(1)}%',
                    icon: Icons.calendar_today,
                    goodPerformance: attendancePercent >= 75,
                  ),
                  const SizedBox(width: 12),
                  MetricsCard(
                    label: 'Assignment',
                    value: '${assignmentAttainmentPercent.toStringAsFixed(1)}%',
                    icon: Icons.assignment,
                    goodPerformance: assignmentAttainmentPercent >= 75,
                  ),
                  const SizedBox(width: 12),
                  MetricsCard(
                    label: 'Avg Grade',
                    value: '${averageGrade.toStringAsFixed(0)}%',
                    icon: Icons.grade,
                    goodPerformance: averageGrade >= 75,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // today's schedule section
              DashboardSectionHeader(
                title: "Today's Schedule",
                count: todaysSessions.length,
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: todaysSessions.isEmpty
                    ? DashboardEmptyList(
                        message: "No sessions scheduled for today",
                      )
                    : SessionsList(
                        count: todaysSessions.length,
                        sessions: todaysSessions,
                      ),
              ),

              const SizedBox(height: 24),

              // upcoming assignments section
              DashboardSectionHeader(
                title: 'Assignments Due Soon',
                count: upcomingAssignments.length,
              ),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: upcomingAssignments.isEmpty
                    ? DashboardEmptyList(
                        message: "All caught up! 🎉",
                        icon: Icons.check_circle_outline,
                      )
                    : AssignmentsList(
                        count: upcomingAssignments.length,
                        assignments: upcomingAssignments,
                      ),
              ),

              const SizedBox(height: 24),

              /* ---------------- QUICK STATS ---------------- */
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DashboardQuickStatCard(
                      label: 'Pending',
                      value: pendingAssignmentsCount.toString(),
                      icon: Icons.pending_actions,
                    ),
                    DashboardQuickStatCard(
                      label: 'Completed',
                      value: _assignments
                          .where((a) => a.isCompleted)
                          .length
                          .toString(),
                      icon: Icons.check_circle,
                    ),
                    DashboardQuickStatCard(
                      label: 'Sessions',
                      value: _sessions.length.toString(),
                      icon: Icons.event,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // get help button for at-risk students
              if (isAtRisk) HelpCard(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
