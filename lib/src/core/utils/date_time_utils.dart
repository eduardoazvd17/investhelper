import 'package:flutter/material.dart';

abstract class DateTimeUtils {
  static DateTime getPastMonthFirstDay(DateTime date) {
    return date.month > 1
        ? DateTime(date.year, date.month - 1)
        : DateTime(date.year - 1, 12);
  }

  static DateTime removeTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime withLastDateFromMonth(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      DateUtils.getDaysInMonth(date.year, date.month),
      23,
      59,
      59,
    );
  }

  static DateTime withLastSecondOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  static DateTime get currentMonthFirstDay {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  static isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static isSameMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }
}
