import 'package:assignments/widgets/app_app_bar.dart';
import 'package:assignments/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:assignments/models/user_profile.dart';

class SignUpScreen extends StatefulWidget {
  final void Function(UserProfile profile) onSubmit;

  const SignUpScreen({super.key, required this.onSubmit});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final Map<String, bool> _courses = {
    'Mobile Application Development': false,
    'Front End Web Development': false,
    'Introduction to Software Engineering': false,
  };

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final selected = _courses.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

      if (selected.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one course'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      final profile = UserProfile(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        courses: selected,
      );

      widget.onSubmit(profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppAppBar(title: "Student Sign-Up"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create your account',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'University Email',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.primary.withValues(alpha: 0.5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.border(0.2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.accent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.error),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.error, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: AppColors.primary.withValues(alpha: 0.5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.border(0.2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.accent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.error),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.error, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  'Select Your Courses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ..._courses.keys.map(
                  (course) => CheckboxListTile(
                    title: Text(
                      course,
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: _courses[course],
                    activeColor: AppColors.accent,
                    checkColor: Colors.white,
                    side: BorderSide(color: AppColors.border(0.3)),
                    onChanged: (v) {
                      setState(() => _courses[course] = v ?? false);
                    },
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
