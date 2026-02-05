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
}
