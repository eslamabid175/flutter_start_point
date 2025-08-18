import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ============= PRIMARY COLORS =============
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryVariant = Color(0xFF1565C0);

  // Primary Shades
  static const Color primary50 = Color(0xFFE3F2FD);
  static const Color primary100 = Color(0xFFBBDEFB);
  static const Color primary200 = Color(0xFF90CAF9);
  static const Color primary300 = Color(0xFF64B5F6);
  static const Color primary400 = Color(0xFF42A5F5);
  static const Color primary500 = Color(0xFF2196F3);
  static const Color primary600 = Color(0xFF1E88E5);
  static const Color primary700 = Color(0xFF1976D2);
  static const Color primary800 = Color(0xFF1565C0);
  static const Color primary900 = Color(0xFF0D47A1);

  // ============= SECONDARY COLORS =============
  static const Color secondary = Color(0xFFFF4081);
  static const Color secondaryLight = Color(0xFFFF79B0);
  static const Color secondaryDark = Color(0xFFC60055);
  static const Color secondaryVariant = Color(0xFFF50057);

  // Secondary Shades
  static const Color secondary50 = Color(0xFFFCE4EC);
  static const Color secondary100 = Color(0xFFF8BBD0);
  static const Color secondary200 = Color(0xFFF48FB1);
  static const Color secondary300 = Color(0xFFF06292);
  static const Color secondary400 = Color(0xFFEC407A);
  static const Color secondary500 = Color(0xFFE91E63);
  static const Color secondary600 = Color(0xFFD81B60);
  static const Color secondary700 = Color(0xFFC2185B);
  static const Color secondary800 = Color(0xFFAD1457);
  static const Color secondary900 = Color(0xFF880E4F);

  // ============= NEUTRAL COLORS =============
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Grays
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // ============= SEMANTIC COLORS =============
  // Success
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);
  static const Color successBackground = Color(0xFFE8F5E9);

  // Error
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFC62828);
  static const Color errorBackground = Color(0xFFFFEBEE);

  // Warning
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);
  static const Color warningBackground = Color(0xFFFFF3E0);

  // Info
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);
  static const Color infoBackground = Color(0xFFE3F2FD);

  // ============= BACKGROUND COLORS =============
  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color scaffold = Color(0xFFFAFAFA);
  static const Color scaffoldDark = Color(0xFF0A0A0A);

  // ============= TEXT COLORS =============
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);
  static const Color textOnError = Color(0xFFFFFFFF);

  // Dark mode text
  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFF9E9E9E);
  static const Color textTertiaryDark = Color(0xFF757575);
  static const Color textDisabledDark = Color(0xFF616161);

  // ============= BORDER COLORS =============
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF5F5F5);
  static const Color borderDark = Color(0xFFBDBDBD);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);

  // ============= SPECIAL COLORS =============
  static const Color overlay = Color(0x80000000); // 50% black
  static const Color overlayLight = Color(0x40000000); // 25% black
  static const Color overlayDark = Color(0xCC000000); // 80% black
  static const Color shadow = Color(0x1A000000); // 10% black
  static const Color shadowDark = Color(0x40000000); // 25% black

  // Social Media Colors
  static const Color facebook = Color(0xFF1877F2);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color google = Color(0xFFDB4437);
  static const Color apple = Color(0xFF000000);
  static const Color linkedin = Color(0xFF0A66C2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color whatsapp = Color(0xFF25D366);
  static const Color youtube = Color(0xFFFF0000);
  static const Color tiktok = Color(0xFF000000);
  static const Color snapchat = Color(0xFFFFFC00);

  // ============= GRADIENT COLORS =============
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, successDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [error, errorDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFFD93D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient oceanGradient = LinearGradient(
    colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============= MATERIAL COLORS =============
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF2196F3,
    <int, Color>{
      50: primary50,
      100: primary100,
      200: primary200,
      300: primary300,
      400: primary400,
      500: primary500,
      600: primary600,
      700: primary700,
      800: primary800,
      900: primary900,
    },
  );

  // ============= HELPER METHODS =============
  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  static Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  static Color getShade(Color color, {int shade = 100}) {
    final Map<int, double> shadeMapping = {
      50: 0.5,
      100: 0.4,
      200: 0.3,
      300: 0.2,
      400: 0.1,
      500: 0.0,
      600: -0.1,
      700: -0.2,
      800: -0.3,
      900: -0.4,
    };

    final amount = shadeMapping[shade] ?? 0.0;
    return amount >= 0 ? lighten(color, amount) : darken(color, -amount);
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}

// Theme-specific color extensions
extension ThemeColors on BuildContext {
  // Quick access to theme colors
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get accentColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).colorScheme.background;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get dividerColor => Theme.of(this).dividerColor;

  // Custom semantic colors based on theme
  Color get successColor => AppColors.success;
  Color get warningColor => AppColors.warning;
  Color get infoColor => AppColors.info;

  // Text colors based on theme
  Color get textPrimary => Theme.of(this).brightness == Brightness.light
      ? AppColors.textPrimary
      : AppColors.textPrimaryDark;

  Color get textSecondary => Theme.of(this).brightness == Brightness.light
      ? AppColors.textSecondary
      : AppColors.textSecondaryDark;
}