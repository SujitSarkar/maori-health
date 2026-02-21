import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class DateConverter {
  static final _defaultFormat = DateFormat('dd-MM-yyyy');

  static String format(DateTime date, {DateFormat? formatter}) {
    return (formatter ?? _defaultFormat).format(date);
  }

  static DateTime? parse(String date, {DateFormat? formatter}) {
    try {
      return (formatter ?? _defaultFormat).parseStrict(date);
    } catch (_) {
      return null;
    }
  }

  static String toDisplay(DateTime date) => DateFormat('dd-MM-yyyy').format(date);

  static String toIso(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  static String toFullDisplay(DateTime date) => DateFormat('dd MMM yyyy, EEEE').format(date);

  static String toWeekdayDate(DateTime date) => DateFormat('EEEE, dd MMM').format(date);

  static ({int day, int hour, int minute}) minutesToDhm(int totalMinutes) {
    return (day: totalMinutes ~/ 1440, hour: (totalMinutes % 1440) ~/ 60, minute: totalMinutes % 60);
  }

  static String formatTime(String time) {
    try {
      final parsed = DateFormat('HH:mm:ss').parseStrict(time);
      return DateFormat('hh:mm a').format(parsed);
    } catch (_) {
      try {
        final parsed = DateFormat('HH:mm').parseStrict(time);
        return DateFormat('hh:mm a').format(parsed);
      } catch (_) {
        return time;
      }
    }
  }

  static String toDisplayTime(TimeOfDay time, {required String locale}) {
    return DateFormat('hh:mm a', locale).format(DateTime(0, 0, 0, time.hour, time.minute));
  }

  static String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String formatIso(String? isoDate, {String pattern = 'dd-MM-yyyy | h:mm a'}) {
    if (isoDate == null || isoDate.isEmpty) return '-';
    try {
      final dt = DateTime.parse(isoDate);
      return DateFormat(pattern).format(dt);
    } catch (_) {
      return isoDate;
    }
  }
}
