import 'package:assignments/models/assignment.dart';
import 'package:assignments/models/assignment_session.dart';
import 'package:assignments/models/user_profile.dart';
import 'package:assignments/theme/app_providers.dart';
import 'package:assignments/widgets/app_app_bar.dart';
import 'package:assignments/widgets/assignments_list.dart';
import 'package:assignments/widgets/dashboard_empty_list.dart';
import 'package:assignments/widgets/dashboard_section_header.dart';
import 'package:assignments/widgets/help_card.dart';
import 'package:assignments/widgets/profile_metrics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/date_time_extension.dart';
import '../widgets/sessions_list.dart';
import '../widgets/risk_banner.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _assignmentRepo = AppProviders.assignmentRepository;
  final _sessionRepo = AppProviders.sessionRepository;
  final _userRepo = AppProviders.userRepository;

  List<Assignment> _assignments = [];
  List<AcademicSession> _sessions = [];
  UserProfile? _userProfile;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final assignments = await _assignmentRepo.getAll();
    final sessions = await _sessionRepo.getAll();
    final profile = await _userRepo.load();

    setState(() {
      _assignments = assignments;
      _sessions = sessions;
      _userProfile = profile;
    });
  }

  // ...existing code...
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

    final bool isAtRisk = attendancePercent < 75;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppAppBar(title: "Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // greeting and date section
              Text(
                'Hello ${_userProfile?.email.split('@').first ?? 'User'},',
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

              // Attendance metrics + Get Help
              ProfileMetrics(),
              const SizedBox(height: 32),

              // risk warning banner
              if (isAtRisk) RiskBanner(),

              if (isAtRisk) const SizedBox(height: 20),

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
