import 'dart:math' as math;

import 'package:intl/intl.dart';

extension NumExtensions on num {
  // Formatting
  String get formatted => NumberFormat('#,##0').format(this);

  String get currency => NumberFormat.currency(symbol: '\$').format(this);

  String currencyWith(String symbol) =>
      NumberFormat.currency(symbol: symbol).format(this);

  String get compact => NumberFormat.compact().format(this);

  String get percentage => NumberFormat.percentPattern().format(this / 100);

  String toFixed(int fractionDigits) =>
      toStringAsFixed(fractionDigits).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');

  // Time Durations
  Duration get days => Duration(days: toInt());
  Duration get hours => Duration(hours: toInt());
  Duration get minutes => Duration(minutes: toInt());
  Duration get seconds => Duration(seconds: toInt());
  Duration get milliseconds => Duration(milliseconds: toInt());
  Duration get microseconds => Duration(microseconds: toInt());

  // Delay Helper
  Future<void> get delay => Future.delayed(Duration(seconds: toInt()));
  Future<void> get delayMs => Future.delayed(Duration(milliseconds: toInt()));

  // Validation
  bool get isPositive => this > 0;
  bool get isNegative => this < 0;
  bool get isZero => this == 0;
  bool get isInteger => this % 1 == 0;
  bool get isDecimal => this % 1 != 0;

  // Range
  bool isBetween(num min, num max) => this >= min && this <= max;

  num clamp(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  // Mathematical Operations
  num get squared => this * this;
  num get cubed => this * this * this;
  num get half => this / 2;
  num get doubled => this * 2;
  num get negated => -this;

  // num percentage(num percent) => this * (percent / 100);
  //
  // num increaseBy(num percent) => this + percentage(percent);
  //
  // num decreaseBy(num percent) => this - percentage(percent);

  // File Size Formatting
  String get fileSize {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int unitIndex = 0;
    double size = toDouble();

    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }

    return '${size.toStringAsFixed(2)} ${units[unitIndex]}';
  }

  // Iteration
  void times(void Function(int) action) {
    for (int i = 0; i < this; i++) {
      action(i);
    }
  }

  List<T> map<T>(T Function(int) mapper) {
    final list = <T>[];
    for (int i = 0; i < this; i++) {
      list.add(mapper(i));
    }
    return list;
  }

  // Roman Numerals (for fun!)
  String get toRoman {
    if (this <= 0 || this > 3999) return toString();

    final values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    final symbols = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I'];

    final buffer = StringBuffer();
    var remaining = toInt();

    for (int i = 0; i < values.length; i++) {
      while (remaining >= values[i]) {
        buffer.write(symbols[i]);
        remaining -= values[i];
      }
    }

    return buffer.toString();
  }
}

extension IntExtensions on int {
  // Ordinal
  String get ordinal {
    if (this % 100 >= 11 && this % 100 <= 13) {
      return '${this}th';
    }

    switch (this % 10) {
      case 1: return '${this}st';
      case 2: return '${this}nd';
      case 3: return '${this}rd';
      default: return '${this}th';
    }
  }

  // Binary Operations
  bool get isEven => this % 2 == 0;
  bool get isOdd => this % 2 != 0;

  String get toBinary => toRadixString(2);
  String get toHex => toRadixString(16);
  String get toOctal => toRadixString(8);
}

extension DoubleExtensions on double {
  // Rounding
  double roundTo(int decimals) {
    final factor = math.pow(10, decimals);
    return (this * factor).round() / factor;
  }

  double get roundToHalf => (this * 2).round() / 2;

  double get roundToQuarter => (this * 4).round() / 4;
}