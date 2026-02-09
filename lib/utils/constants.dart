import 'package:assignments/models/assignment.dart';
import 'package:assignments/models/assignment_session.dart';
import 'package:flutter/material.dart';

final List<Assignment> assignments = [
  Assignment(
    id: '1',
    title: 'Formative 2: Quiz',
    course: 'Web Development',
    dueDate: DateTime.now().add(const Duration(days: 2)),
    priority: 'High',
  ),
  Assignment(
    id: '2',
    title: 'Proposal and SRS Document',
    course: 'Introduction to Software Engineering',
    dueDate: DateTime.now().add(const Duration(days: 5)),
    priority: 'Medium',
  ),
  Assignment(
    id: '3',
    title: 'User Research and Design',
    course: 'Mobile App Development',
    dueDate: DateTime.now().add(const Duration(days: 1)),
    priority: 'High',
  ),
  Assignment(
    id: '4',
    title: 'Playing Around with APIs',
    course: 'Web Development',
    dueDate: DateTime.now().add(const Duration(days: 10)),
    priority: 'Low',
    isCompleted: true,
  ),
];

final List<AcademicSession> sessions = [
  AcademicSession(
    id: '1',
    title: 'Web Development',
    date: DateTime.now(),
    startTime: const TimeOfDay(hour: 9, minute: 0),
    endTime: const TimeOfDay(hour: 10, minute: 30),
    location: 'Kenya',
    sessionType: 'Class',
    attended: true,
  ),
  AcademicSession(
    id: '2',
    title: 'Mobile App Development',
    date: DateTime.now(),
    startTime: const TimeOfDay(hour: 11, minute: 0),
    endTime: const TimeOfDay(hour: 12, minute: 30),
    location: 'Egypt',
    sessionType: 'Class',
    attended: true,
  ),
  AcademicSession(
    id: '3',
    title: 'Introduction to Software Engineering',
    date: DateTime.now(),
    startTime: const TimeOfDay(hour: 14, minute: 0),
    endTime: const TimeOfDay(hour: 15, minute: 30),
    location: 'Burundi',
    sessionType: 'Class',
  ),
  AcademicSession(
    id: '4',
    title: 'Introduction to Software Engineering',
    date: DateTime.now().subtract(const Duration(days: 1)),
    startTime: const TimeOfDay(hour: 10, minute: 0),
    endTime: const TimeOfDay(hour: 11, minute: 30),
    location: 'Morocco',
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