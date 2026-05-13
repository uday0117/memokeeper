/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'Memo Keeper – Simple Notes';
  static const String appVersion = '1.0.0';

  // Hive Box Names
  static const String notesBox = 'notes_box';
  static const String settingsBox = 'settings_box';

  // Storage Keys
  static const String isDarkModeKey = 'is_dark_mode';
  static const String isFirstLaunchKey = 'is_first_launch';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 16.0;
  static const double fabSize = 56.0;

  // Notification Channel
  static const String notificationChannelId = 'memo_keeper_channel';
  static const String notificationChannelName = 'Memo Keeper Notifications';
  static const String notificationChannelDescription =
      'Notifications for memo reminders';
}
