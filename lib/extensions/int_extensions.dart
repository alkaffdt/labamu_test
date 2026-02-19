import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

extension IntExtensions on int {
  Widget toHeightGap() {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget toWidthGap() {
    return SizedBox(
      width: toDouble(),
    );
  }

  String toTimeDescription() {
    final years = this ~/ 12;
    final months = this % 12;

    final yearString = years > 0 ? '$years year${years > 1 ? 's' : ''}' : '';
    final monthString = months > 0 ? '$months mo${months > 1 ? 's' : ''}' : '';

    if (years > 0 && months > 0) {
      return '$yearString $monthString';
    } else if (years > 0) {
      return yearString;
    } else if (months > 0) {
      return monthString;
    } else {
      return 'Less than a month';
    }
  }

  DateTime? unixToDateTime() {
    try {
      return DateTime.fromMillisecondsSinceEpoch(this * 1000);
    } catch (error) {
      return null;
    }
  }

  String unixToLocalizedDateTimeString({required String languageCode}) {
    const pattern = 'dd MMM yyyy';

    final date = unixToDateTime();

    if (this == 0) return '';

    if (date == null) return '';

    final intlLocaleCode = numberFormatSymbols.keys.firstWhere(
      (element) => element.toLowerCase().startsWith(languageCode.toLowerCase()),
      orElse: () => 'en_US',
    );

    final dateFormat = DateFormat(pattern, intlLocaleCode);
    return dateFormat.format(date);
  }

  String toPostedAgo(Map<String, String> translations) {
    final now = DateTime.now();
    final postedDate = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    final difference = now.difference(postedDate);

    final agoStr = translations['ago']!;

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years > 1 ? translations['years'] : translations['year']} $agoStr';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months > 1 ? translations['months'] : translations['month']} $agoStr';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks > 1 ? translations['weeks'] : translations['week']} $agoStr';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays > 1 ? translations['days'] : translations['day']} $agoStr';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours > 1 ? translations['hours'] : translations['hour']} $agoStr';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes > 1 ? translations['minutes'] : translations['minute']} $agoStr';
    } else {
      return translations['just_now']!;
    }
  }

  String toFormattedNumber() {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  String toAgeStr() {
    final now = DateTime.now();
    final birthDate = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    final age = now.year - birthDate.year;
    return age.toString();
  }

  String toPriceFormat({String separator = ','}) {
    String numberString = toString();
    String formattedNumber = numberString.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m.group(1)}$separator',
    );
    return formattedNumber;
  }
}
