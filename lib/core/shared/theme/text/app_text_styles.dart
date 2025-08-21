import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // Font family
  static String? _fontFamily = GoogleFonts.cairo().fontFamily;

  // Base text style
  static TextStyle _baseTextStyle = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.5,
  );

  // Display styles (largest text)
  static TextStyle displayLarge = _baseTextStyle.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static TextStyle displayMedium = _baseTextStyle.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 1.16,
  );

  static TextStyle displaySmall = _baseTextStyle.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.22,
  );

  // Headline styles
  static TextStyle headlineLarge = _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 1.25,
  );

  static TextStyle headlineMedium = _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.29,
  );

  static TextStyle headlineSmall = _baseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.33,
  );

  // Title styles
  static TextStyle titleLarge = _baseTextStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.27,
  );

  static TextStyle titleMedium = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static TextStyle titleSmall = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  // Body styles
  static TextStyle bodyLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static TextStyle bodyMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static TextStyle bodySmall = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // Label styles
  static TextStyle labelLarge = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static TextStyle labelMedium = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.33,
  );

  static TextStyle labelSmall = _baseTextStyle.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.45,
  );

  // Custom styles for specific use cases
  static TextStyle button = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    height: 1.43,
  );

  static TextStyle caption = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
    color: Colors.grey[600],
  );

  static TextStyle overline = _baseTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    height: 1.6,
  );

  // Helper methods for common modifications
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle bold(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w700);
  }

  static TextStyle medium(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w500);
  }

  static TextStyle regular(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w400);
  }

  static TextStyle light(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w300);
  }

  static TextStyle italic(TextStyle style) {
    return style.copyWith(fontStyle: FontStyle.italic);
  }

  static TextStyle underline(TextStyle style) {
    return style.copyWith(decoration: TextDecoration.underline);
  }

  static TextStyle lineThrough(TextStyle style) {
    return style.copyWith(decoration: TextDecoration.lineThrough);
  }
}