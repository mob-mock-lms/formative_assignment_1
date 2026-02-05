import 'package:assignments/models/assignment_session.dart';
import 'package:flutter/material.dart';

class SessionsList<T extends List> extends StatelessWidget {
  final int count;
  final List<AcademicSession> sessions;
  
  const SessionsList({super.key, required this.count, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sessions.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.white.withValues(alpha: 0.1),
          height: 1,
        ),
        itemBuilder: (context, index) {
          final session = sessions[index];
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
                color: const Color(
                  0xFF64B5F6,
                ).withValues(alpha: 0.2),
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
      );
  }
}
