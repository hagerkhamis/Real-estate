import 'package:flutter/material.dart';

class AppColors {
  // Dark Theme Palette
  static const Color background = Color(0xFF0D121F);
  static const Color surface = Color(0xFF1A1F2C);
  static const Color primary = Color(0xFFC9A227); // Gold/Mustard accent from the logo
  static const Color secondary = Color(0xFF2196F3); // Blue accent
  
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textGrey = Color(0xFFB0B0B0);
  
  static const Color cardBg = Color(0xFF1E2433);
  static const Color divider = Color(0xFF2C3444);
  
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB300);
  
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFFC9A227), Color(0xFFE6C15C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0D121F), Color(0xFF1A1F2C)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
