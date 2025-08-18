import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  // Formatting
  String format([String pattern = 'yyyy-MM-dd']) => DateFormat(pattern).format(this);

  String get formattedDate => DateFormat.yMMMd().format(this);
  String get formattedTime => DateFormat.jm().format(this);
  String get formattedDateTime => DateFormat.yMMMd().add_jm().format(this);

  String get dayName => DateFormat.EEEE().format(this);
  String get monthName => DateFormat.MMMM().format(this);
  String get shortDayName => DateFormat.E().format(this);
  String get shortMonthName => DateFormat.MMM().format(this);

  // Relative Time
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  String get timeUntil {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return 'in $years ${years == 1 ? 'year' : 'years'}';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return 'in $months ${months == 1 ? 'month' : 'months'}';
    } else if (difference.inDays > 7) {
      final weeks = (difference.inDays / 7).floor();
      return 'in $weeks ${weeks == 1 ? 'week' : 'weeks'}';
    } else if (difference.inDays > 0) {
      return 'in ${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'}';
    } else if (difference.inHours > 0) {
      return 'in ${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'}';
    } else if (difference.inMinutes > 0) {
      return 'in ${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'}';
    } else {
      return 'Now';
    }
  }

  // Comparisons
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
  bool get isWeekday => !isWeekend;

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool isSameMonth(DateTime other) =>
      year == other.year && month == other.month;

  bool isSameYear(DateTime other) => year == other.year;

  // Manipulation
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  DateTime get startOfWeek {
    final daysToSubtract = weekday - 1;
    return subtract(Duration(days: daysToSubtract)).startOfDay;
  }

  DateTime get endOfWeek {
    final daysToAdd = 7 - weekday;
    return add(Duration(days: daysToAdd)).endOfDay;
  }

  DateTime get startOfMonth => DateTime(year, month, 1);
  DateTime get endOfMonth => DateTime(year, month + 1, 0).endOfDay;

  DateTime get startOfYear => DateTime(year, 1, 1);
  DateTime get endOfYear => DateTime(year, 12, 31).endOfDay;

  DateTime addDays(int days) => add(Duration(days: days));
  DateTime addHours(int hours) => add(Duration(hours: hours));
  DateTime addMinutes(int minutes) => add(Duration(minutes: minutes));

  DateTime subtractDays(int days) => subtract(Duration(days: days));
  DateTime subtractHours(int hours) => subtract(Duration(hours: hours));
  DateTime subtractMinutes(int minutes) => subtract(Duration(minutes: minutes));

  // Age Calculation
  int get age {
    final now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  // Working Days
  int workingDaysUntil(DateTime other) {
    int days = 0;
    DateTime current = this;

    while (current.isBefore(other)) {
      if (current.isWeekday) days++;
      current = current.addDays(1);
    }

    return days;
  }

  // Unix Timestamp
  int get unixTimestamp => millisecondsSinceEpoch ~/ 1000;

  static DateTime fromUnixTimestamp(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}