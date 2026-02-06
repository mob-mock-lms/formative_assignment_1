import 'package:assignments/utils/constants.dart';
import 'package:assignments/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import '../models/assignment.dart';
import 'add_edit_assignment_screen.dart';
import 'package:intl/intl.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  // this a sample assignments list - this will store all assignments

  final List<Assignment> _assignments = assignments;

  // to Add new assignment to the list

  void _addAssignment(Assignment assignment) {
    setState(() {
      _assignments.add(assignment);
      _sortAssignments();
    });
  }

  // to Update existing assignment

  void _updateAssignment(Assignment updatedAssignment) {
    setState(() {
      int index = _assignments.indexWhere((a) => a.id == updatedAssignment.id);
      if (index != -1) {
        _assignments[index] = updatedAssignment;
        _sortAssignments();
      }
    });
  }

  // Delete assignment

  void _deleteAssignment(String id) {
    setState(() {
      _assignments.removeWhere((a) => a.id == id);
    });
  }

  // Toggle assignment completion status

  void _toggleComplete(String id) {
    setState(() {
      int index = _assignments.indexWhere((a) => a.id == id);
      if (index != -1) {
        _assignments[index].isCompleted = !_assignments[index].isCompleted;
      }
    });
  }

  // Sort assignments by due date

  void _sortAssignments() {
    _assignments.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  // Navigate to add/edit screen

  void _navigateToAddEdit({Assignment? assignment}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditAssignmentScreen(assignment: assignment),
      ),
    );

    if (result != null && result is Assignment) {
      if (assignment == null) {
        _addAssignment(result);
      } else {
        _updateAssignment(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppAppBar(title: "Assignments"),
      ),
      body: _assignments.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 80,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No assignments yet',
                    style: TextStyle(color: Colors.grey[400], fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create your first assignment',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _assignments.length,
              itemBuilder: (context, index) {
                final assignment = _assignments[index];
                return _buildAssignmentCard(assignment);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEdit(),
        backgroundColor: const Color(0xFFFFC107),
        child: const Icon(Icons.add, color: Color(0xFF0A1E3C)),
      ),
    );
  }

  Widget _buildAssignmentCard(Assignment assignment) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final daysUntil = assignment.daysUntilDue();
    final isOverdue = assignment.isOverdue();

    Color priorityColor;
    switch (assignment.priority) {
      case 'High':
        priorityColor = const Color(0xFFFF3B30);
        break;
      case 'Medium':
        priorityColor = const Color(0xFFFFC107);
        break;
      case 'Low':
        priorityColor = const Color(0xFF4CAF50);
      default:
        priorityColor = const Color(0xFFFFC107);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2F4F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: assignment.isCompleted
              ? Colors.grey.shade700
              : (isOverdue ? const Color(0xFFFF3B30) : Colors.transparent),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          value: assignment.isCompleted,
          onChanged: (value) => _toggleComplete(assignment.id),
          activeColor: const Color(0xFF4CAF50),
          side: const BorderSide(color: Colors.grey, width: 2),
        ),
        title: Text(
          assignment.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: assignment.isCompleted
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              assignment.course,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  dateFormat.format(assignment.dueDate),
                  style: TextStyle(
                    color: isOverdue
                        ? const Color(0xFFFF3B30)
                        : Colors.grey[400],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 8),
                if (!assignment.isCompleted && !isOverdue)
                  Text(
                    '($daysUntil ${daysUntil == 1 ? 'day' : 'days'} left)',
                    style: const TextStyle(
                      color: Color(0xFFFFC107),
                      fontSize: 12,
                    ),
                  ),
                if (isOverdue)
                  const Text(
                    '(Overdue)',
                    style: TextStyle(
                      color: Color(0xFFFF3B30),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: priorityColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: priorityColor, width: 1),
              ),
              child: Text(
                assignment.priority,
                style: TextStyle(
                  color: priorityColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onSelected: (value) {
            if (value == 'edit') {
              _navigateToAddEdit(assignment: assignment);
            } else if (value == 'delete') {
              _showDeleteConfirmation(assignment);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(Assignment assignment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2F4F),
        title: const Text(
          'Delete Assignment',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete "${assignment.title}"?',
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              _deleteAssignment(assignment.id);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFFFF3B30)),
            ),
          ),
        ],
      ),
    );
  }
}
