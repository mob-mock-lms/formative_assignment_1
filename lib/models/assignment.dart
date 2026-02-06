class Assignment {
  final String id;
  final String title;
  final String description;
  final String course;
  final DateTime dueDate;
  final String priority;
  final DateTime? reminderAt;
  bool isCompleted;

  Assignment({
    required this.id,
    required this.title,
    required this.course,
    required this.dueDate,
    this.description = '',
    this.priority = 'Medium',
    this.reminderAt,
    this.isCompleted = false,
  });

  // this is a helper method to get priority color
  String getPriorityColor() {
    switch (priority) {
      case 'High':
        return 'red';
      case 'Medium':
        return 'orange';
      case 'Low':
        return 'green';
      default:
        return 'orange';
    }
  }

  // this is a helper method to check if assignment is overdue
  bool isOverdue() {
    return !isCompleted && DateTime.now().isAfter(dueDate);
  }

  // this is a helper method to get days until due
  int daysUntilDue() {
    return dueDate.difference(DateTime.now()).inDays;
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'course': course,
    'dueDate': dueDate.toIso8601String(),
    'priority': priority,
    'reminderAt': reminderAt?.toIso8601String(),
    'isCompleted': isCompleted,
  };

  factory Assignment.fromMap(Map<String, dynamic> map) => Assignment(
    id: map['id'] as String,
    title: map['title'] as String,
    description: (map['description'] ?? '') as String,
    course: map['course'] as String,
    dueDate: DateTime.parse(map['dueDate'] as String),
    priority: (map['priority'] ?? 'Medium') as String,
    reminderAt: map['reminderAt'] != null
        ? DateTime.parse(map['reminderAt'] as String)
        : null,
    isCompleted: (map['isCompleted'] ?? false) as bool,
  );
}
