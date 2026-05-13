import 'package:intl/intl.dart';

/// Utility class for date formatting
class DateFormatter {
  /// Format date to readable string (e.g., "Jan 15, 2024")
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Format date with time (e.g., "Jan 15, 2024 at 3:30 PM")
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy \'at\' h:mm a').format(date);
  }

  /// Format time only (e.g., "3:30 PM")
  static String formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  /// Get relative time (e.g., "2 days ago")
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    }
  }
}
