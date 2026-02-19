import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  // Example output: "2022-01-01"
  String? get asYYYYmmdd {
    if (this == null) return null;

    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this!);
  }

  // Example output: "Mar 2024"
  String? get asMMMyyyy {
    if (this == null) return null;

    final formatter = DateFormat('MMM yyyy');
    return formatter.format(this!);
  }

  String toTimeAgo(Map<String, String> translations) {
    final now = DateTime.now();
    final difference = now.difference(this!);

    final suffixStr = translations['ago']!;

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years > 1 ? translations['years'] : translations['year']} $suffixStr';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months > 1 ? translations['months'] : translations['month']} $suffixStr';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks > 1 ? translations['weeks'] : translations['week']} $suffixStr';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${translations['days']} $suffixStr';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${translations['hours']} $suffixStr';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${translations['minutes']} $suffixStr';
    } else {
      return translations['just_now']!;
    }
  }
}
