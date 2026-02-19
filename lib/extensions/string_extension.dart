import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isNumericOnly() => hasMatch(r'^\d+$');

  /// (No Whitespace)
  bool isAlphabetOnly() => hasMatch(r'^[a-zA-Z]+$');

  bool hasMatch(String pattern) {
    return RegExp(pattern).hasMatch(this);
  }

  String capitalizeWords({String excludeString = '_'}) {
    if (isEmpty) return this;

    return split('_') // Split the string by underscores
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : ' ')
        .join('_')
        .replaceAll(excludeString, ' '); // Join the words back with underscores
  }

  /// check if the string is valid URL
  bool get isValidUrl {
    final urlRegex = RegExp(
        r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$');
    return urlRegex.hasMatch(this);
  }

  /// delete base url
  String deleteBaseUrl() {
    if (isValidUrl) {
      final uri = Uri.parse(this);
      final path = uri.path;
      return path;
    }
    return this;
  }

  String toTimeAgo(Map<String, String> translations) {
    try {
      final now = DateTime.now();
      final date = DateTime.parse(this);
      final difference = now.difference(date);

      if (difference.inDays >= 365) {
        final years = (difference.inDays / 365).floor();
        return '$years ${years > 1 ? translations['years'] : translations['year']} ${translations['ago']}';
      } else if (difference.inDays >= 30) {
        final months = (difference.inDays / 30).floor();
        return '$months ${months > 1 ? translations['months'] : translations['month']} ${translations['ago']}';
      } else if (difference.inDays >= 7) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks ${weeks > 1 ? translations['weeks'] : translations['week']} ${translations['ago']}';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays > 1 ? translations['days'] : translations['day']} ${translations['ago']}';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours > 1 ? translations['hours'] : translations['hour']} ${translations['ago']}';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes > 1 ? translations['minutes'] : translations['minute']} ${translations['ago']}';
      } else {
        return translations['just_now']!;
      }
    } on FormatException {
      return '';
    }
  }

  /// delete the first char is slash
  String deleteFirstCharIfSlash() {
    if (isNotEmpty && this[0] == '/') {
      return substring(1);
    }
    return this;
  }

  bool toBoolean() => toLowerCase() == 'true';
}

extension OptionalStringExt on String? {
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;

  String get capitalizeWords {
    if (this == null) return '';

    return this!
        .split('_') // Split the string by underscores
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join('_'); // Join the words back with underscores
  }

  bool toBoolean() => this?.isNotEmpty == true && this == 'true';

  DateTime? parseDDMMMYYYYtoDateTime() {
    if (!isNotNullAndNotEmpty) return null;

    DateFormat format = DateFormat('dd MMM yyyy');
    DateTime dateTime = format.parse(this!);

    return dateTime;
  }
}
