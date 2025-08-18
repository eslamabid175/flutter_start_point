import 'package:easy_localization/easy_localization.dart';

class Validators {
  // Email Validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  // Password Validation
  static String? password(String? value, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireDigit = true,
    bool requireSpecialChar = true,
  }) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (requireDigit && !value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    if (requireSpecialChar && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  // Confirm Password
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Phone Number
  static String? phoneNumber(String? value, {String? countryCode}) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    // Check length based on country code
    if (countryCode == '+1' && digitsOnly.length != 10) {
      return 'Please enter a valid 10-digit phone number';
    }

    if (digitsOnly.length < 7 || digitsOnly.length > 15) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  // Name Validation
  static String? name(String? value, {
    int minLength = 2,
    int maxLength = 50,
    String fieldName = 'Name',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return '$fieldName can only contain letters and spaces';
    }

    return null;
  }

  // Username Validation
  static String? username(String? value, {
    int minLength = 3,
    int maxLength = 20,
  }) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < minLength) {
      return 'Username must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return 'Username must not exceed $maxLength characters';
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    if (value.startsWith('_') || value.endsWith('_')) {
      return 'Username cannot start or end with underscore';
    }

    return null;
  }

  // URL Validation
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }

    final uri = Uri.tryParse(value);
    if (uri == null || !uri.isAbsolute) {
      return 'Please enter a valid URL';
    }

    if (!['http', 'https'].contains(uri.scheme)) {
      return 'URL must start with http:// or https://';
    }

    return null;
  }

  // Credit Card
  static String? creditCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Credit card number is required';
    }

    // Remove spaces and dashes
    final cardNumber = value.replaceAll(RegExp(r'[\s-]'), '');

    if (!RegExp(r'^\d{13,19}$').hasMatch(cardNumber)) {
      return 'Please enter a valid credit card number';
    }

    // Luhn algorithm validation
    if (!_isValidLuhn(cardNumber)) {
      return 'Invalid credit card number';
    }

    return null;
  }

  static bool _isValidLuhn(String cardNumber) {
    int sum = 0;
    bool alternate = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  // Date Validation
  static String? date(String? value, {
    DateTime? minDate,
    DateTime? maxDate,
    String format = 'yyyy-MM-dd',
  }) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }

    DateTime? date;
    try {
      date = DateFormat(format).parseStrict(value);
    } catch (e) {
      return 'Please enter a valid date in format $format';
    }

    if (minDate != null && date.isBefore(minDate)) {
      return 'Date must be after ${DateFormat(format).format(minDate)}';
    }

    if (maxDate != null && date.isAfter(maxDate)) {
      return 'Date must be before ${DateFormat(format).format(maxDate)}';
    }

    return null;
  }

  // Age Validation
  static String? age(String? value, {
    int minAge = 0,
    int maxAge = 120,
  }) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }

    final age = int.tryParse(value);
    if (age == null) {
      return 'Please enter a valid age';
    }

    if (age < minAge) {
      return 'Age must be at least $minAge';
    }

    if (age > maxAge) {
      return 'Age must not exceed $maxAge';
    }

    return null;
  }

  // Generic Required Field
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Min/Max Length
  static String? length(String? value, {
    int? min,
    int? max,
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (min != null && value.length < min) {
      return '$fieldName must be at least $min characters';
    }

    if (max != null && value.length > max) {
      return '$fieldName must not exceed $max characters';
    }

    return null;
  }

  // Numeric Range
  static String? numberRange(String? value, {
    num? min,
    num? max,
    String fieldName = 'Value',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    final number = num.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }

    if (min != null && number < min) {
      return '$fieldName must be at least $min';
    }

    if (max != null && number > max) {
      return '$fieldName must not exceed $max';
    }

    return null;
  }

  // Pattern Matching
  static String? pattern(String? value, {
    required RegExp pattern,
    String? message,
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (!pattern.hasMatch(value)) {
      return message ?? 'Invalid format for $fieldName';
    }

    return null;
  }

  // Combine Multiple Validators
  static String? Function(String?) combine(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }
}