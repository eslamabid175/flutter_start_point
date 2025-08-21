import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ============= PRIMARY COLORS =============
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF0D47A1);
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
  static const Color secondary = Color(0xFF7B1FA2);
  static const Color secondaryLight = Color(0xFFAB47BC);
  static const Color secondaryDark = Color(0xFF4A148C);
  static const Color secondaryVariant = Color(0xFF6A1B9A);

  // Secondary Shades
  static const Color secondary50 = Color(0xFFF3E5F5);
  static const Color secondary100 = Color(0xFFE1BEE7);
  static const Color secondary200 = Color(0xFFCE93D8);
  static const Color secondary300 = Color(0xFFBA68C8);
  static const Color secondary400 = Color(0xFFAB47BC);
  static const Color secondary500 = Color(0xFF9C27B0);
  static const Color secondary600 = Color(0xFF8E24AA);
  static const Color secondary700 = Color(0xFF7B1FA2);
  static const Color secondary800 = Color(0xFF6A1B9A);
  static const Color secondary900 = Color(0xFF4A148C);

  // ============= TERTIARY COLORS =============
  static const Color tertiary = Color(0xFF00BCD4);
  static const Color tertiaryLight = Color(0xFF4DD0E1);
  static const Color tertiaryDark = Color(0xFF0097A7);

  // ============= NEUTRAL COLORS =============
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

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
  static const Color gray950 = Color(0xFF121212);

  // ============= SEMANTIC COLORS =============
  // Success
  static const Color success = Color(0xFF388E3C);
  static const Color successLight = Color(0xFF66BB6A);
  static const Color successDark = Color(0xFF1B5E20);
  static const Color successBackground = Color(0xFFE8F5E9);
  static const Color onSuccess = white;

  // Error
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFC62828);
  static const Color errorBackground = Color(0xFFFFEBEE);
  static const Color onError = white;

  // Warning
  static const Color warning = Color(0xFFFF6F00);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFE65100);
  static const Color warningBackground = Color(0xFFFFF3E0);
  static const Color onWarning = white;

  // Info
  static const Color info = Color(0xFF0288D1);
  static const Color infoLight = Color(0xFF4FC3F7);
  static const Color infoDark = Color(0xFF01579B);
  static const Color infoBackground = Color(0xFFE1F5FE);
  static const Color onInfo = white;

  // ============= BACKGROUND COLORS =============
  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surface = white;
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color surfaceVariant = Color(0xFFFAFAFA);
  static const Color surfaceVariantDark = Color(0xFF2C2C2C);

  // ============= TEXT COLORS =============
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textHint = Color(0xFF9E9E9E);

  // Dark mode text
  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textTertiaryDark = Color(0xFF808080);
  static const Color textDisabledDark = Color(0xFF616161);

  // ============= SPECIAL COLORS =============
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF424242);
  static const Color shadow = Color(0x1A000000);
  static const Color shadowDark = Color(0x40000000);
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);
  static const Color overlayDark = Color(0xCC000000);

  // Component specific
  static const Color cardBackground = white;
  static const Color cardBackgroundDark = Color(0xFF2C2C2C);
  static const Color inputBackground = gray100;
  static const Color inputBackgroundDark = Color(0xFF2C2C2C);
  static const Color buttonDisabled = gray300;
  static const Color buttonDisabledDark = gray800;

  // ============= COLORBLIND SAFE COLORS =============
  // Using Okabe-Ito palette for deuteranopia
  static const Color colorblindPrimary = Color(0xFF0173B2);
  static const Color colorblindPrimaryLight = Color(0xFF56B4E9);
  static const Color colorblindPrimaryDark = Color(0xFF004C6D);
  static const Color colorblindSecondary = Color(0xFFCC79A7);
  static const Color colorblindSecondaryLight = Color(0xFFE6B3CC);
  static const Color colorblindSecondaryDark = Color(0xFF994D75);
  static const Color colorblindError = Color(0xFFD55E00);
  static const Color colorblindSuccess = Color(0xFF009E73);
  static const Color colorblindWarning = Color(0xFFF0E442);
  static const Color colorblindInfo = Color(0xFF0173B2);

  // ============= SOCIAL MEDIA COLORS =============
  static const Color facebook = Color(0xFF1877F2);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color google = Color(0xFFDB4437);
  static const Color apple = black;
  static const Color linkedin = Color(0xFF0A66C2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color whatsapp = Color(0xFF25D366);
  static const Color youtube = Color(0xFFFF0000);
  static const Color github = Color(0xFF181717);
  static const Color discord = Color(0xFF5865F2);

  // ============= GRADIENTS =============
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

  static const LinearGradient darkGradient = LinearGradient(
    colors: [gray900, black],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ============= MATERIAL COLOR SWATCH =============
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF1976D2,
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

  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}

// Theme-specific color schemes
class AppColorScheme {
  // Light theme colors
  static const AppColorSchemeData light = AppColorSchemeData(
    primary: AppColors.primary,
    primaryLight: AppColors.primaryLight,
    primaryDark: AppColors.primaryDark,
    onPrimary: AppColors.white,
    secondary: AppColors.secondary,
    secondaryLight: AppColors.secondaryLight,
    secondaryDark: AppColors.secondaryDark,
    onSecondary: AppColors.white,
    tertiary: AppColors.tertiary,
    tertiaryLight: AppColors.tertiaryLight,
    tertiaryDark: AppColors.tertiaryDark,
    onTertiary: AppColors.white,
    background: AppColors.background,
    onBackground: AppColors.textPrimary,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    surfaceVariant: AppColors.surfaceVariant,
    error: AppColors.error,
    onError: AppColors.onError,
    success: AppColors.success,
    onSuccess: AppColors.onSuccess,
    warning: AppColors.warning,
    onWarning: AppColors.onWarning,
    info: AppColors.info,
    onInfo: AppColors.onInfo,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    textTertiary: AppColors.textTertiary,
    textDisabled: AppColors.textDisabled,
    divider: AppColors.divider,
    border: AppColors.border,
    shadow: AppColors.shadow,
    cardBackground: AppColors.cardBackground,
    inputBackground: AppColors.inputBackground,
    buttonDisabled: AppColors.buttonDisabled,
  );

  // Dark theme colors
  static const AppColorSchemeData dark = AppColorSchemeData(
    primary: AppColors.primary200,
    primaryLight: AppColors.primary100,
    primaryDark: AppColors.primary400,
    onPrimary: AppColors.black,
    secondary: AppColors.secondary200,
    secondaryLight: AppColors.secondary100,
    secondaryDark: AppColors.secondary400,
    onSecondary: AppColors.black,
    tertiary: AppColors.tertiaryLight,
    tertiaryLight: Color(0xFF80DEEA),
    tertiaryDark: AppColors.tertiary,
    onTertiary: AppColors.black,
    background: AppColors.backgroundDark,
    onBackground: AppColors.textPrimaryDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    surfaceVariant: AppColors.surfaceVariantDark,
    error: AppColors.errorLight,
    onError: AppColors.black,
    success: AppColors.successLight,
    onSuccess: AppColors.black,
    warning: AppColors.warningLight,
    onWarning: AppColors.black,
    info: AppColors.infoLight,
    onInfo: AppColors.black,
    textPrimary: AppColors.textPrimaryDark,
    textSecondary: AppColors.textSecondaryDark,
    textTertiary: AppColors.textTertiaryDark,
    textDisabled: AppColors.textDisabledDark,
    divider: AppColors.dividerDark,
    border: AppColors.borderDark,
    shadow: AppColors.shadowDark,
    cardBackground: AppColors.cardBackgroundDark,
    inputBackground: AppColors.inputBackgroundDark,
    buttonDisabled: AppColors.buttonDisabledDark,
  );

  // Colorblind theme colors
  static const AppColorSchemeData colorblind = AppColorSchemeData(
    primary: AppColors.colorblindPrimary,
    primaryLight: AppColors.colorblindPrimaryLight,
    primaryDark: AppColors.colorblindPrimaryDark,
    onPrimary: AppColors.white,
    secondary: AppColors.colorblindSecondary,
    secondaryLight: AppColors.colorblindSecondaryLight,
    secondaryDark: AppColors.colorblindSecondaryDark,
    onSecondary: AppColors.white,
    tertiary: Color(0xFF56B4E9),
    tertiaryLight: Color(0xFF87CEEB),
    tertiaryDark: Color(0xFF0173B2),
    onTertiary: AppColors.white,
    background: AppColors.background,
    onBackground: AppColors.textPrimary,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    surfaceVariant: AppColors.surfaceVariant,
    error: AppColors.colorblindError,
    onError: AppColors.white,
    success: AppColors.colorblindSuccess,
    onSuccess: AppColors.white,
    warning: AppColors.colorblindWarning,
    onWarning: AppColors.gray900,
    info: AppColors.colorblindInfo,
    onInfo: AppColors.white,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.gray700,
    textTertiary: AppColors.gray600,
    textDisabled: AppColors.textDisabled,
    divider: AppColors.divider,
    border: AppColors.border,
    shadow: AppColors.shadow,
    cardBackground: AppColors.cardBackground,
    inputBackground: AppColors.inputBackground,
    buttonDisabled: AppColors.buttonDisabled,
  );
}

// Color scheme data class
class AppColorSchemeData {
  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color onPrimary;
  final Color secondary;
  final Color secondaryLight;
  final Color secondaryDark;
  final Color onSecondary;
  final Color tertiary;
  final Color tertiaryLight;
  final Color tertiaryDark;
  final Color onTertiary;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color error;
  final Color onError;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color info;
  final Color onInfo;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color divider;
  final Color border;
  final Color shadow;
  final Color cardBackground;
  final Color inputBackground;
  final Color buttonDisabled;

  const AppColorSchemeData({
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.onPrimary,
    required this.secondary,
    required this.secondaryLight,
    required this.secondaryDark,
    required this.onSecondary,
    required this.tertiary,
    required this.tertiaryLight,
    required this.tertiaryDark,
    required this.onTertiary,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.error,
    required this.onError,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.divider,
    required this.border,
    required this.shadow,
    required this.cardBackground,
    required this.inputBackground,
    required this.buttonDisabled,
  });
}

// Extension for easy access to theme colors
extension ThemeColors on BuildContext {
  AppColorSchemeData get colors {
    final brightness = Theme.of(this).brightness;
    final extension = Theme.of(this).extension<AppThemeExtension>();

    // Check if colorblind mode is active
    if (extension?.isColorBlindMode ?? false) {
      return AppColorScheme.colorblind;
    }

    return brightness == Brightness.light
        ? AppColorScheme.light
        : AppColorScheme.dark;
  }
}

// Theme extension to track colorblind mode
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final bool isColorBlindMode;

  AppThemeExtension({
    this.isColorBlindMode = false,
  });

  @override
  AppThemeExtension copyWith({bool? isColorBlindMode}) {
    return AppThemeExtension(
      isColorBlindMode: isColorBlindMode ?? this.isColorBlindMode,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      isColorBlindMode: isColorBlindMode,
    );
  }
}