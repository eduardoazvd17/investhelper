abstract class DateTimeUtils {
  static DateTime get currentMonthFirstDay {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }
}
