import 'package:assignments/repositories/assignment_repository.dart';
import 'package:assignments/repositories/session_repository.dart';
import 'package:assignments/repositories/user_repository.dart';

class AppProviders {
  // Singleton instances of repositories
  static final AssignmentRepository assignmentRepository =
      AssignmentRepository();
  static final SessionRepository sessionRepository = SessionRepository();
  static final UserRepository userRepository = UserRepository();
}
