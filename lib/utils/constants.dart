import 'package:assignments/models/assignment.dart';
import 'package:assignments/models/assignment_session.dart';
import 'package:flutter/material.dart';

final List<Assignment> assignments = [
  Assignment(
    id: '1',
    title: 'Math Homework',
    course: 'Calculus',
    dueDate: DateTime.now().add(const Duration(days: 2)),
    priority: 'High',
  ),
  Assignment(
    id: '2',
    title: 'Physics Lab Report',
    course: 'Physics',
    dueDate: DateTime.now().add(const Duration(days: 5)),
    priority: 'Medium',
  ),
  Assignment(
    id: '3',
    title: 'Economics Essay',
    course: 'Economics',
    dueDate: DateTime.now().add(const Duration(days: 1)),
    priority: 'High',
  ),
  Assignment(
    id: '4',
    title: 'Programming Project',
    course: 'Computer Science',
    dueDate: DateTime.now().add(const Duration(days: 10)),
    priority: 'Low',
    isCompleted: true,
  ),
];

final List<AcademicSession> sessions = [
  AcademicSession(
    id: '1',
    title: 'Calculus',
    date: DateTime.now(),
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 10, minute: 30),
    location: 'Room 301',
    sessionType: 'Class',
    attended: true,
  ),
  AcademicSession(
    id: '2',
    title: 'English Literature',
    date: DateTime.now(),
    startTime: const TimeOfDay(hour: 11, minute: 0),
    endTime: const TimeOfDay(hour: 12, minute: 30),
    location: 'Room 205',
    sessionType: 'Class',
    attended: true,
  ),
  AcademicSession(
    id: '3',
    title: 'Computer Science',
    date: DateTime.now(),
    startTime: const TimeOfDay(hour: 14, minute: 0),
    endTime: const TimeOfDay(hour: 15, minute: 30),
    location: 'Lab 4',
    sessionType: 'Class',
  ),
  AcademicSession(
    id: '4',
    title: 'Physics',
    date: DateTime.now().subtract(const Duration(days: 1)),
    startTime: const TimeOfDay(hour: 10, minute: 0),
    endTime: const TimeOfDay(hour: 11, minute: 30),
    location: 'Lab 2',
    sessionType: 'Class',
    attended: false,
  ),
  AcademicSession(
    id: '5',
    title: 'Study Group',
    date: DateTime.now().subtract(const Duration(days: 2)),
    startTime: const TimeOfDay(hour: 15, minute: 0),
    endTime: const TimeOfDay(hour: 16, minute: 30),
    location: 'Library',
    sessionType: 'Study Group',
    attended: true,
  ),
];