import 'package:flutter/material.dart';

/// Vibrant colorful palette for notes
class NoteColors {
  // Vibrant gradient color schemes
  static const List<NoteColorScheme> colorSchemes = [
    NoteColorScheme(
      name: 'Default',
      primaryColor: Color(0xFF2196F3),
      secondaryColor: Color(0xFF64B5F6),
      gradientColors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
    ),
    NoteColorScheme(
      name: 'Sunset',
      primaryColor: Color(0xFFFF6B6B),
      secondaryColor: Color(0xFFFFD93D),
      gradientColors: [Color(0xFFFF6B6B), Color(0xFFFF8E53), Color(0xFFFFD93D)],
    ),
    NoteColorScheme(
      name: 'Ocean',
      primaryColor: Color(0xFF667EEA),
      secondaryColor: Color(0xFF764BA2),
      gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    ),
    NoteColorScheme(
      name: 'Forest',
      primaryColor: Color(0xFF11998E),
      secondaryColor: Color(0xFF38EF7D),
      gradientColors: [Color(0xFF11998E), Color(0xFF38EF7D)],
    ),
    NoteColorScheme(
      name: 'Sunrise',
      primaryColor: Color(0xFFF093FB),
      secondaryColor: Color(0xFFF5576C),
      gradientColors: [Color(0xFFF093FB), Color(0xFFF5576C)],
    ),
    NoteColorScheme(
      name: 'Purple Dream',
      primaryColor: Color(0xFF8E2DE2),
      secondaryColor: Color(0xFF4A00E0),
      gradientColors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
    ),
    NoteColorScheme(
      name: 'Mint',
      primaryColor: Color(0xFF00F5A0),
      secondaryColor: Color(0xFF00D9F5),
      gradientColors: [Color(0xFF00F5A0), Color(0xFF00D9F5)],
    ),
    NoteColorScheme(
      name: 'Peach',
      primaryColor: Color(0xFFFFAFBD),
      secondaryColor: Color(0xFFFFC3A0),
      gradientColors: [Color(0xFFFFAFBD), Color(0xFFFFC3A0)],
    ),
    NoteColorScheme(
      name: 'Candy',
      primaryColor: Color(0xFFFA709A),
      secondaryColor: Color(0xFFFEE140),
      gradientColors: [Color(0xFFFA709A), Color(0xFFFEE140)],
    ),
    NoteColorScheme(
      name: 'Space',
      primaryColor: Color(0xFF000428),
      secondaryColor: Color(0xFF004E92),
      gradientColors: [Color(0xFF000428), Color(0xFF004E92)],
    ),
  ];

  /// Get color scheme by index
  static NoteColorScheme getSchemeByIndex(int index) {
    if (index >= 0 && index < colorSchemes.length) {
      return colorSchemes[index];
    }
    return colorSchemes[0]; // Default
  }

  /// Get color scheme by color code
  static NoteColorScheme? getSchemeByColorCode(int? colorCode) {
    if (colorCode == null) return null;

    return colorSchemes.firstWhere(
      (scheme) => scheme.primaryColor.value == colorCode,
      orElse: () => colorSchemes[0],
    );
  }

  /// Get gradient for a color code
  static LinearGradient getGradient(int? colorCode, {bool isDark = false}) {
    if (colorCode == null) {
      return LinearGradient(
        colors: [
          isDark ? const Color(0xFF1E1E1E) : Colors.white,
          isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF8F9FA),
        ],
      );
    }

    final scheme = getSchemeByColorCode(colorCode);
    if (scheme == null) {
      return LinearGradient(
        colors: [
          isDark ? const Color(0xFF1E1E1E) : Colors.white,
          isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF8F9FA),
        ],
      );
    }

    return LinearGradient(
      colors: scheme.gradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

/// Color scheme model for notes
class NoteColorScheme {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final List<Color> gradientColors;

  const NoteColorScheme({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.gradientColors,
  });
}

/// Predefined categories with colors
class NoteCategories {
  static const List<NoteCategoryData> categories = [
    NoteCategoryData(
      name: 'Personal',
      icon: Icons.person,
      colorCode: 0xFF2196F3,
    ),
    NoteCategoryData(name: 'Work', icon: Icons.work, colorCode: 0xFF667EEA),
    NoteCategoryData(
      name: 'Ideas',
      icon: Icons.lightbulb,
      colorCode: 0xFFFFC107,
    ),
    NoteCategoryData(
      name: 'Shopping',
      icon: Icons.shopping_cart,
      colorCode: 0xFF11998E,
    ),
    NoteCategoryData(
      name: 'Health',
      icon: Icons.favorite,
      colorCode: 0xFFFF6B6B,
    ),
    NoteCategoryData(name: 'Travel', icon: Icons.flight, colorCode: 0xFF00F5A0),
    NoteCategoryData(
      name: 'Finance',
      icon: Icons.attach_money,
      colorCode: 0xFF38EF7D,
    ),
    NoteCategoryData(name: 'Study', icon: Icons.school, colorCode: 0xFF8E2DE2),
  ];

  static NoteCategoryData? getCategoryByName(String? name) {
    if (name == null) return null;

    try {
      return categories.firstWhere((cat) => cat.name == name);
    } catch (e) {
      return null;
    }
  }
}

/// Category data model
class NoteCategoryData {
  final String name;
  final IconData icon;
  final int colorCode;

  const NoteCategoryData({
    required this.name,
    required this.icon,
    required this.colorCode,
  });
}
