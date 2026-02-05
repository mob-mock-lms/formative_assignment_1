import 'package:assignments/models/assignment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignmentsList extends StatelessWidget {
  final int count;
  final List<Assignment> assignments;

  const AssignmentsList({
    super.key,
    required this.count,
    required this.assignments,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: assignments.length,
      separatorBuilder: (context, index) =>
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 1),
      itemBuilder: (context, index) {
        final assignment = assignments[index];
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
    );
  }
}
