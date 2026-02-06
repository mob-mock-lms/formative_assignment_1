class UserProfile {
  final String email;
  final String password;
  final List<String> courses;

  const UserProfile({
    required this.email,
    required this.password,
    required this.courses,
  });

  Map<String, dynamic> toMap() => {
    'email': email,
    'password': password,
    'courses': courses,
  };

  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
    email: map['email'] as String,
    password: map['password'] as String,
    courses: (map['courses'] as List<dynamic>).cast<String>(),
  );
}
