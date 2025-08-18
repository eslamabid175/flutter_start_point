import 'package:flutter/material.dart';

/// Defines all text styles used throughout the app
class AppTextStyles {
  static const String fontFamily = 'Roboto';

  /// Returns a complete TextTheme for the app
  static TextTheme getTextTheme({required bool isDarkMode}) {
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;
    final Color secondaryTextColor =
        isDarkMode ? Colors.white70 : Colors.black54;

    return TextTheme(
      /// Display styles - largest text
      displayLarge: TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: textColor,
      ),

      /// Headline styles - for section headers
      headlineLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: textColor,
      ),

      /// Title styles - for app bars and dialogs
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: textColor,
      ),

      /// Body styles - for main content
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: secondaryTextColor,
      ),

      /// Label styles - for buttons and chips
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: textColor,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: textColor,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        color: secondaryTextColor,
      ),
    );
  }
}

/// Usage Example
/// // In your widget, you can use these styles like this:
/// Text(
///  'Hello, World!',
///  style: AppTextStyles.getTextTheme(isDarkMode: false).bodyLarge,
