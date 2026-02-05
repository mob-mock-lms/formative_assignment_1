class UserProfile {
  final String email;
  final String password;
  final List<String> courses;

  const UserProfile({
    required this.email,
    required this.password,
    required this.courses,
  });
}
