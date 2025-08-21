import 'package:flutter/material.dart';
import 'app_colors.dart';

class DarkColors implements AppColors {
  @override
  Color get primary => const Color(0xFF90CAF9);
  @override
  Color get primaryLight => const Color(0xFFBBDEFB);
  @override
  Color get primaryDark => const Color(0xFF42A5F5);
  @override
  Color get onPrimary => const Color(0xFF000000);

  @override
  Color get secondary => const Color(0xFFCE93D8);
  @override
  Color get secondaryLight => const Color(0xFFF3E5F5);
  @override
  Color get secondaryDark => const Color(0xFFAB47BC);
  @override
  Color get onSecondary => const Color(0xFF000000);

  @override
  Color get background => const Color(0xFF121212);
  @override
  Color get surface => const Color(0xFF1E1E1E);
  @override
  Color get surfaceVariant => const Color(0xFF2C2C2C);
  @override
  Color get onBackground => const Color(0xFFE0E0E0);
  @override
  Color get onSurface => const Color(0xFFE0E0E0);

  @override
  Color get error => const Color(0xFFEF5350);
  @override
  Color get onError => const Color(0xFF000000);
  @override
  Color get success => const Color(0xFF66BB6A);
  @override
  Color get onSuccess => const Color(0xFF000000);
  @override
  Color get warning => const Color(0xFFFFB74D);
  @override
  Color get onWarning => const Color(0xFF000000);
  @override
  Color get info => const Color(0xFF4FC3F7);
  @override
  Color get onInfo => const Color(0xFF000000);

  @override
  Color get textPrimary => const Color(0xFFE0E0E0);
  @override
  Color get textSecondary => const Color(0xFFB0B0B0);
  @override
  Color get textDisabled => const Color(0xFF616161);
  @override
  Color get divider => const Color(0xFF424242);
  @override
  Color get shadow => Colors.black.withOpacity(0.3);

  @override
  Color get cardBackground => const Color(0xFF2C2C2C);
  @override
  Color get inputBackground => const Color(0xFF2C2C2C);
  @override
  Color get buttonDisabled => const Color(0xFF424242);
  @override
  Color get iconPrimary => const Color(0xFFE0E0E0);
  @override
  Color get iconSecondary => const Color(0xFFB0B0B0);
}