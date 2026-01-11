import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors (Golden Orange / Marigold)
  static const Color primary = Color(0xFFFF8C00); // Deep golden yellow / marigold orange
  static const Color primaryDark = Color(0xFFCC7000); // Darker shade
  static const Color primaryLight = Color(0xFFFFB84D); // Lighter shade

  // Secondary Colors
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryDark = Color(0xFF018786);
  static const Color secondaryLight = Color(0xFF66FFF9);

  // Background Colors (Material Design 3 - Clean white)
  static const Color background = Color(0xFFFFFFFF); // Pure white background
  static const Color surface = Color(0xFFFFFFFF); // White cards
  static const Color surfaceVariant = Color(0xFFF5F5F5); // Light gray for subtle backgrounds
  static const Color surfaceDark = Color(0xFF121212);

  // Text Colors (Material Design 3)
  static const Color textPrimary = Color(0xFF000000); // Black for primary text
  static const Color textSecondary = Color(0xFF757575); // Gray for secondary text
  static const Color textTertiary = Color(0xFF9E9E9E); // Lighter gray for tertiary text
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFF000000);

  // Accent Colors (for links, actions)
  static const Color accent = Color(0xFFFF8C00); // Orange for links and actions
  static const Color accentLight = Color(0xFFFFB84D);

  // Error & Status Colors (Material Design 3)
  static const Color error = Color(0xFFB00020);
  static const Color errorLight = Color(0xFFCF6679);
  static const Color success = Color(0xFF4CAF50); // Green for success states
  static const Color successLight = Color(0xFF66BB6A);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Border & Divider Colors (Material Design 3 - Subtle)
  static const Color border = Color(0xFFE0E0E0); // Light gray borders
  static const Color divider = Color(0xFFE0E0E0); // Same as border for consistency

  // Shadow Colors (Material Design 3 - Layered shadows)
  static const Color shadow = Color(0x1A000000); // Default shadow
  static const Color shadowLight = Color(0x0D000000); // Light shadow for subtle elevation
  static const Color shadowMedium = Color(0x26000000); // Medium shadow for cards
  static const Color shadowDark = Color(0x40000000); // Dark shadow for elevated elements

  // Interactive Colors
  static const Color interactive = Color(0xFFFF8C00); // Orange for interactive elements
  static const Color interactiveHover = Color(0xFFCC7000);
  static const Color interactivePressed = Color(0xFFB36200);

  // Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardHover = Color(0xFFFAFAFA);
}
