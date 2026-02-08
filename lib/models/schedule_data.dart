import 'package:flutter/material.dart';

// this class represents one academic session
class AcademicSession {
  String title;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String location;
  String type;
  bool isPresent;

  AcademicSession({
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.type,
    this.location = '',
    this.isPresent = true,
  });
}
