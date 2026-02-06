import 'package:flutter/material.dart';

class AcademicSession {
  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String location;
  final String sessionType;
  bool? attended;

  AcademicSession({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.location = '',
    required this.sessionType,
    this.attended,
  });

  bool isToday() {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'date': date.toIso8601String(),
    'startTime': '${startTime.hour}:${startTime.minute}',
    'endTime': '${endTime.hour}:${endTime.minute}',
    'location': location,
    'sessionType': sessionType,
    'attended': attended,
  };

  factory AcademicSession.fromMap(Map<String, dynamic> map) {
    final startParts = (map['startTime'] as String).split(':');
    final endParts = (map['endTime'] as String).split(':');
    return AcademicSession(
      id: map['id'] as String,
      title: map['title'] as String,
      date: DateTime.parse(map['date'] as String),
      startTime: TimeOfDay(
        hour: int.parse(startParts[0]),
        minute: int.parse(startParts[1]),
      ),
      endTime: TimeOfDay(
        hour: int.parse(endParts[0]),
        minute: int.parse(endParts[1]),
      ),
      location: map['location'] as String? ?? '',
      sessionType: map['sessionType'] as String,
      attended: map['attended'] as bool?,
    );
  }
}
