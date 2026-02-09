import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/assignment.dart';
import '../models/assignment_session.dart';
import '../models/user_profile.dart';
import 'constants.dart';

class StorageService {
  static const String _assignmentsKey = 'assignments';
  static const String _sessionsKey = 'sessions';
  static const String _userProfileKey = 'user_profile';
  static const String _firstRunKey = 'first_run';

  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Check if this is the first run
    final isFirstRun = _prefs?.getBool(_firstRunKey) ?? true;
    
    if (isFirstRun) {
      // Initialize with mock data on first run
      await saveAssignments(assignments);
      await saveSessions(sessions);
      await _prefs?.setBool(_firstRunKey, false);
    }
  }

  // Assignment Methods
  static Future<List<Assignment>> getAssignments() async {
    try {
      final String? assignmentsJson = _prefs?.getString(_assignmentsKey);
      
      if (assignmentsJson == null || assignmentsJson.isEmpty) {
        // Return mock data if no stored data exists
        return assignments;
      }
      
      final List<dynamic> decoded = jsonDecode(assignmentsJson);
      return decoded.map((json) => Assignment.fromJson(json)).toList();
    } catch (e) {
      // If error occurs, return mock data
      return assignments;
    }
  }

  static Future<void> saveAssignments(List<Assignment> assignmentsList) async {
    try {
      final List<Map<String, dynamic>> jsonList = 
          assignmentsList.map((assignment) => assignment.toJson()).toList();
      final String assignmentsJson = jsonEncode(jsonList);
      await _prefs?.setString(_assignmentsKey, assignmentsJson);
    } catch (e) {
      print('Error saving assignments: $e');
    }
  }

  // Session Methods
  static Future<List<AcademicSession>> getSessions() async {
    try {
      final String? sessionsJson = _prefs?.getString(_sessionsKey);
      
      if (sessionsJson == null || sessionsJson.isEmpty) {
        // Return mock data if no stored data exists
        return sessions;
      }
      
      final List<dynamic> decoded = jsonDecode(sessionsJson);
      return decoded.map((json) => AcademicSession.fromJson(json)).toList();
    } catch (e) {
      // If error occurs, return mock data
      return sessions;
    }
  }

  static Future<void> saveSessions(List<AcademicSession> sessionsList) async {
    try {
      final List<Map<String, dynamic>> jsonList = 
          sessionsList.map((session) => session.toJson()).toList();
      final String sessionsJson = jsonEncode(jsonList);
      await _prefs?.setString(_sessionsKey, sessionsJson);
    } catch (e) {
      print('Error saving sessions: $e');
    }
  }

  // User Profile Methods
  static Future<UserProfile?> getUserProfile() async {
    try {
      final String? profileJson = _prefs?.getString(_userProfileKey);
      
      if (profileJson == null || profileJson.isEmpty) {
        return null;
      }
      
      final Map<String, dynamic> decoded = jsonDecode(profileJson);
      return UserProfile.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }

  static Future<void> saveUserProfile(UserProfile profile) async {
    try {
      final String profileJson = jsonEncode(profile.toJson());
      await _prefs?.setString(_userProfileKey, profileJson);
    } catch (e) {
      print('Error saving user profile: $e');
    }
  }

  static Future<void> clearUserProfile() async {
    await _prefs?.remove(_userProfileKey);
  }

  // Reset to default data
  static Future<void> resetToDefaults() async {
    await saveAssignments(assignments);
    await saveSessions(sessions);
    await clearUserProfile();
    print('Data reset to defaults');
  }

  // Clear all data
  static Future<void> clearAll() async {
    await _prefs?.clear();
    await _prefs?.setBool(_firstRunKey, true);
    print('All data cleared');
  }
}
