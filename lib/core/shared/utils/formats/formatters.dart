import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Formatters {
  // Phone Number Formatter
  static String formatPhoneNumber(String phone, {String countryCode = '+1'}) {
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');

    if (countryCode == '+1' && digitsOnly.length == 10) {
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    }

    return phone;
  }

  // Credit Card Formatter
  static String formatCreditCard(String cardNumber) {
    final digitsOnly = cardNumber.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digitsOnly[i]);
    }

    return buffer.toString();
  }

  // Currency Formatter
  static String formatCurrency(num amount, {
    String symbol = '\$',
    int decimalDigits = 2,
    String locale = 'en_US',
  }) {
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
      locale: locale,
    );
    return formatter.format(amount);
  }

  // File Size Formatter
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';

    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int digitGroups = (math.log(bytes) / math.log(1024)).floor();

    return '${(bytes / math.pow(1024, digitGroups)).toStringAsFixed(2)} ${units[digitGroups]}';
  }

  // Duration Formatter
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  // Name Formatter
  static String formatName(String firstName, String lastName, {
    bool lastNameFirst = false,
  }) {
    if (lastNameFirst) {
      return '$lastName, $firstName';
    }
    return '$firstName $lastName';
  }
}

// Text Input Formatters
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    final formatted = Formatters.formatPhoneNumber(digitsOnly);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length > 16) {
      return oldValue;
    }

    final formatted = Formatters.formatCreditCard(digitsOnly);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class CurrencyFormatter extends TextInputFormatter {
  final String symbol;
  final int decimalDigits;

  CurrencyFormatter({
    this.symbol = '\$',
    this.decimalDigits = 2,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = double.tryParse(newValue.text.replaceAll(RegExp(r'[^\d.]'), ''));
    if (value == null) {
      return oldValue;
    }

    final formatted = Formatters.formatCurrency(value, symbol: symbol, decimalDigits: decimalDigits);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}