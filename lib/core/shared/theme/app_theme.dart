import 'package:flutter/material.dart';
import 'package:project_boilerplate/core/shared/theme/spacing/app_dimensions.dart';
import 'colors/app_colors.dart';
import 'text/app_text_theme.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return _buildTheme(AppColorScheme.light, Brightness.light, false);
  }

  static ThemeData darkTheme() {
    return _buildTheme(AppColorScheme.dark, Brightness.dark, false);
  }

  static ThemeData colorblindTheme() {
    return _buildTheme(AppColorScheme.colorblind, Brightness.light, true);
  }

  static ThemeData _buildTheme(
      AppColorSchemeData colors,
      Brightness brightness,
      bool isColorBlind,
      ) {
    final baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,

      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        error: colors.error,
        onError: colors.onError,
        background: colors.background,
        onBackground: colors.onBackground,
        surface: colors.surface,
        onSurface: colors.onSurface,
      ),

      textTheme: AppTextTheme.getTextTheme(colors),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          borderSide: BorderSide(color: colors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          borderSide: BorderSide(color: colors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // cardTheme: CardTheme(
      //   color: colors.cardBackground,
      //   elevation: 2,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(AppRadius.md),
      //   ),
      // ),

      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        elevation: 0,
        centerTitle: true,
      ),

      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
      ),

      extensions: [

          AppThemeExtension(isColorBlindMode: isColorBlind),

      ],
    );
  }
}