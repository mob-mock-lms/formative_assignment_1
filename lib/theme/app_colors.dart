import 'package:flutter/material.dart';

class AppColors {
  static Color infoLight(double alpha) => info.withValues(alpha: alpha);
  static Color warningLight(double alpha) => warning.withValues(alpha: alpha);
  static Color errorLight(double alpha) => error.withValues(alpha: alpha);
  static Color successLight(double alpha) => success.withValues(alpha: alpha);
  static Color accentLight(double alpha) => accent.withValues(alpha: alpha);
  // Gradient backgrounds (plain with alpha)

  static Color border(double alpha) => Colors.white.withValues(alpha: alpha);
  static Color surface(double alpha) => Colors.white.withValues(alpha: alpha);
  // Semantic Colors (with transparency)

  static const Color background = Color(0xFF0A1E3C);
  static const Color white = Colors.white;
  // Neutral Colors

  static const Color info = Color(0xFF64B5F6);
  static const Color warning = Color(0xFFFFB74D);
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF66BB6A);
  // Status Colors

  static const Color accent = Color(0xFFC41C3B); // red900
  static const Color primary = Color(0xFF071A3A);
  // Brand Colors
}
