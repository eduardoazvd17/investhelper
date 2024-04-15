import 'package:flutter/material.dart';

abstract class DateTimeUtils {
  static DateTime get currentMonthFirstDay {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  static DateTime get currentMonthLastDay {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      DateUtils.getDaysInMonth(now.year, now.month),
      23,
      59,
      59,
    );
  }
}
