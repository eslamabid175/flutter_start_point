import 'dart:convert';
import 'package:crypto/crypto.dart';

extension StringExtensions on String {
  // Validation
  bool get isEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isPhoneNumber => RegExp(r'^[+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$').hasMatch(this);

  bool get isUrl => Uri.tryParse(this) != null && Uri.parse(this).isAbsolute;

  bool get isStrongPassword =>
      length >= 8 &&
          contains(RegExp(r'[A-Z]')) &&
          contains(RegExp(r'[a-z]')) &&
          contains(RegExp(r'[0-9]')) &&
          contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  bool get isNumeric => double.tryParse(this) != null;

  bool get isAlphabetic => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  bool get isAlphaNumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  // Transformations
  String get capitalize => isEmpty ? '' : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  String get capitalizeWords => split(' ').map((word) => word.capitalize).join(' ');

  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  String get reversed => split('').reversed.join('');

  String get toBase64 => base64Encode(utf8.encode(this));

  String get fromBase64 => utf8.decode(base64Decode(this));

  String get toMD5 => md5.convert(utf8.encode(this)).toString();

  String get toSHA256 => sha256.convert(utf8.encode(this)).toString();

  // Truncation
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  String truncateWords(int maxWords) {
    final words = split(' ');
    if (words.length <= maxWords) return this;
    return '${words.take(maxWords).join(' ')}...';
  }

  // Parsing
  int? toIntOrNull() => int.tryParse(this);

  double? toDoubleOrNull() => double.tryParse(this);

  DateTime? toDateTimeOrNull() => DateTime.tryParse(this);

  bool toBool() => toLowerCase() == 'true' || this == '1';

  // Utilities
  String get initials {
    if (isEmpty) return '';
    final words = split(' ').where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '';
    if (words.length == 1) return words.first[0].toUpperCase();
    return '${words.first[0]}${words.last[0]}'.toUpperCase();
  }

  String maskEmail() {
    if (!isEmail) return this;
    final parts = split('@');
    final name = parts[0];
    final domain = parts[1];

    if (name.length <= 2) return '$name@$domain';

    final maskedName = '${name[0]}${'*' * (name.length - 2)}${name[name.length - 1]}';
    return '$maskedName@$domain';
  }

  String maskPhone() {
    if (length < 4) return this;
    final visible = substring(length - 4);
    final masked = '*' * (length - 4);
    return '$masked$visible';
  }

  // Arabic Support
  bool get isArabic => RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(this);

  bool get isEnglish => RegExp(r'^[a-zA-Z\s]+$').hasMatch(this);

  String get removeArabicDiacritics =>
      replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '');

  // File Extensions
  String get fileExtension => contains('.') ? split('.').last.toLowerCase() : '';

  bool get isImage => ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(fileExtension);

  bool get isVideo => ['mp4', 'avi', 'mov', 'wmv', 'flv', 'mkv'].contains(fileExtension);

  bool get isAudio => ['mp3', 'wav', 'flac', 'aac', 'ogg'].contains(fileExtension);

  bool get isPdf => fileExtension == 'pdf';
}

// Null Safety Extensions
extension StringNullExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  String orEmpty() => this ?? '';

  String or(String defaultValue) => this ?? defaultValue;
}