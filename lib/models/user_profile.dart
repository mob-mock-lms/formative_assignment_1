class UserProfile {
  final String email;
  final String password;
  final List<String> courses;

  const UserProfile({
    required this.email,
    required this.password,
    required this.courses,
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'courses': courses,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json['email'] as String,
      password: json['password'] as String,
      courses: List<String>.from(json['courses'] as List),
    );
  }
}
