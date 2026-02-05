import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/* ============================================================
   DATA MODELS (All in one file)
   ============================================================ */

class Assignment {
  final String id;
  final String title;
  final String course;
  final DateTime dueDate;
  final String priority;
  bool isCompleted;

  Assignment({
    required this.id,
    required this.title,
    required this.course,
    required this.dueDate,
    this.priority = 'Medium',
    this.isCompleted = false,
  });
}

class AcademicSession {
  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String location;
  final String sessionType;
  bool? attended;

  AcademicSession({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.location = '',
    required this.sessionType,
    this.attended,
  });

  bool isToday() {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }
}

/* ============================================================
   DASHBOARD SCREEN (Stateful for managing data)
   ============================================================ */

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Sample data - your teammates can add their real data here
  final List<Assignment> _assignments = [
    Assignment(
      id: '1',
      title: 'Math Homework',
      course: 'Calculus',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      priority: 'High',
    ),
    Assignment(
      id: '2',
      title: 'Physics Lab Report',
      course: 'Physics',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      priority: 'Medium',
    ),
    Assignment(
      id: '3',
      title: 'Economics Essay',
      course: 'Economics',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      priority: 'High',
    ),
    Assignment(
      id: '4',
      title: 'Programming Project',
      course: 'Computer Science',
      dueDate: DateTime.now().add(const Duration(days: 10)),
      priority: 'Low',
      isCompleted: true,
    ),
  ];

  final List<AcademicSession> _sessions = [
    AcademicSession(
      id: '1',
      title: 'Calculus',
      date: DateTime.now(),
      startTime: const TimeOfDay(hour: 9, minute: 0),
      endTime: const TimeOfDay(hour: 10, minute: 30),
      location: 'Room 301',
      sessionType: 'Class',
      attended: true,
    ),
    AcademicSession(
      id: '2',
      title: 'English Literature',
      date: DateTime.now(),
      startTime: const TimeOfDay(hour: 11, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 30),
      location: 'Room 205',
      sessionType: 'Class',
      attended: true,
    ),
    AcademicSession(
      id: '3',
      title: 'Computer Science',
      date: DateTime.now(),
      startTime: const TimeOfDay(hour: 14, minute: 0),
      endTime: const TimeOfDay(hour: 15, minute: 30),
      location: 'Lab 4',
      sessionType: 'Class',
    ),
    AcademicSession(
      id: '4',
      title: 'Physics',
      date: DateTime.now().subtract(const Duration(days: 1)),
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 11, minute: 30),
      location: 'Lab 2',
      sessionType: 'Class',
      attended: false,
    ),
    AcademicSession(
      id: '5',
      title: 'Study Group',
      date: DateTime.now().subtract(const Duration(days: 2)),
      startTime: const TimeOfDay(hour: 15, minute: 0),
      endTime: const TimeOfDay(hour: 16, minute: 30),
      location: 'Library',
      sessionType: 'Study Group',
      attended: true,
    ),
  ];

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
    }).toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  int get pendingAssignmentsCount {
    return _assignments.where((a) => !a.isCompleted).length;
  }

  double get attendancePercentage {
    final sessionsWithAttendance = _sessions.where((s) => s.attended != null).toList();
    if (sessionsWithAttendance.isEmpty) return 100.0;

    final presentCount = sessionsWithAttendance.where((s) => s.attended == true).length;
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
    final now = DateTime.now();

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
              /* ---------------- GREETING SECTION ---------------- */

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
                '$today • Week $weekOfYear',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 24),

              /* ---------------- AT RISK WARNING ---------------- */

              if (isAtRisk)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE57373),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'AT RISK WARNING',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Your attendance is below 75%',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              if (isAtRisk) const SizedBox(height: 20),

              /* ---------------- METRICS ROW ---------------- */

              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      'Attendance',
                      '${attendancePercent.toStringAsFixed(1)}%',
                      Icons.calendar_today,
                      attendancePercent >= 75
                          ? const Color(0xFF66BB6A)
                          : const Color(0xFFE57373),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      'Assignments',
                      '${assignmentAttainmentPercent.toStringAsFixed(0)}%',
                      Icons.assignment,
                      assignmentAttainmentPercent >= 75
                          ? const Color(0xFF66BB6A)
                          : const Color(0xFFFFB74D),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      'Avg Grade',
                      '${averageGrade.toStringAsFixed(0)}%',
                      Icons.grade,
                      averageGrade >= 75
                          ? const Color(0xFF66BB6A)
                          : const Color(0xFFE57373),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /* ---------------- TODAY'S SCHEDULE ---------------- */

              _buildSectionHeader('Today\'s Schedule', todaysSessions.length),
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
                    ? Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: Text(
                            'No sessions scheduled for today',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: todaysSessions.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.white.withValues(alpha: 0.1),
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final session = todaysSessions[index];
                          final startTime = session.startTime.format(context);

                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFF64B5F6).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.school,
                                color: Color(0xFF64B5F6),
                              ),
                            ),
                            title: Text(
                              session.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              '$startTime${session.location.isNotEmpty ? ' • ${session.location}' : ''}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 13,
                              ),
                            ),
                            trailing: session.attended != null
                                ? Icon(
                                    session.attended!
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: session.attended!
                                        ? const Color(0xFF66BB6A)
                                        : const Color(0xFFE57373),
                                  )
                                : null,
                          );
                        },
                      ),
              ),

              const SizedBox(height: 24),

              /* ---------------- UPCOMING ASSIGNMENTS ---------------- */

              _buildSectionHeader(
                'Assignments Due Soon',
                upcomingAssignments.length,
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
                    ? Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.white.withValues(alpha: 0.3),
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'All caught up! 🎉',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: upcomingAssignments.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.white.withValues(alpha: 0.1),
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final assignment = upcomingAssignments[index];
                          final daysLeft = assignment.dueDate.difference(now).inDays;
                          final isUrgent = daysLeft <= 2;

                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isUrgent
                                    ? const Color(0xFFE57373).withValues(alpha: 0.2)
                                    : const Color(0xFFFFB74D).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.assignment,
                                color: isUrgent
                                    ? const Color(0xFFE57373)
                                    : const Color(0xFFFFB74D),
                              ),
                            ),
                            title: Text(
                              assignment.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              '${assignment.course} • Due ${DateFormat('MMM d').format(assignment.dueDate)}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 13,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isUrgent
                                    ? const Color(0xFFE57373)
                                    : Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                daysLeft == 0
                                    ? 'Today'
                                    : daysLeft == 1
                                        ? 'Tomorrow'
                                        : '$daysLeft days',
                                style: TextStyle(
                                  color: isUrgent
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
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
                    _buildQuickStat(
                      'Pending',
                      pendingAssignmentsCount.toString(),
                      Icons.pending_actions,
                    ),
                    _buildQuickStat(
                      'Completed',
                      _assignments.where((a) => a.isCompleted).length.toString(),
                      Icons.check_circle,
                    ),
                    _buildQuickStat(
                      'Sessions',
                      _sessions.length.toString(),
                      Icons.event,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /* ---------------- GET HELP BUTTON ---------------- */

              if (isAtRisk)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to help/support
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Help feature coming soon!'),
                          backgroundColor: Color(0xFFFFC107),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      foregroundColor: const Color(0xFF071A3A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Get Help',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /* ============================================================
     WIDGET BUILDERS
     ============================================================ */

  Widget _buildMetricCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
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
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (count > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.6),
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

/* ============================================================
   EXTENSION
   ============================================================ */

extension DateTimeExtension on DateTime {
  int get dayOfYear {
    int dayCount = 0;
    for (int i = 1; i < month; i++) {
      dayCount += DateTime(year, i + 1, 0).day;
    }
    return dayCount + day;
  }
}