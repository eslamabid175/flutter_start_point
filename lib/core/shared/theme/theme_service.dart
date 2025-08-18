import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Service class for theme-related utilities
class ThemeService {
  /// Updates system UI overlay style based on theme
  static void updateSystemUIOverlay(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: theme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  /// Gets the appropriate color based on theme
  static Color getAdaptiveColor(
    BuildContext context, {
    required Color lightColor,
    required Color darkColor,
  }) =>
      Theme.of(context).brightness == Brightness.light ? lightColor : darkColor;

  /// Gets the appropriate icon based on theme
  static IconData getAdaptiveIcon(
    BuildContext context, {
    required IconData lightIcon,
    required IconData darkIcon,
  }) =>
      Theme.of(context).brightness == Brightness.light ? lightIcon : darkIcon;

  /// Checks if current theme is dark
  static bool isDarkTheme(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// Gets contrast color for a given color
  static Color getContrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
