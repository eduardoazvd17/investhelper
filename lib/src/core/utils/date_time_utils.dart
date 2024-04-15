abstract class DateTimeUtils {
  static DateTime get currentMonthFirstDay {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  static isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
