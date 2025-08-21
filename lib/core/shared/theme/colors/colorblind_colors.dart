import 'package:flutter/material.dart';
import 'app_colors.dart';

class ColorblindColors implements AppColors {
  @override
  Color get primary => const Color(0xFF0173B2);
  @override
  Color get primaryLight => const Color(0xFF56B4E9);
  @override
  Color get primaryDark => const Color(0xFF004C6D);
  @override
  Color get onPrimary => Colors.white;

  @override
  Color get secondary => const Color(0xFFCC79A7);
  @override
  Color get secondaryLight => const Color(0xFFE6B3CC);
  @override
  Color get secondaryDark => const Color(0xFF994D75);
  @override
  Color get onSecondary => Colors.white;

  @override
  Color get background => const Color(0xFFF5F5F5);
  @override
  Color get surface => Colors.white;
  @override
  Color get surfaceVariant => const Color(0xFFFAFAFA);
  @override
  Color get onBackground => const Color(0xFF212121);
  @override
  Color get onSurface => const Color(0xFF212121);

  @override
  Color get error => const Color(0xFFD55E00);
  @override
  Color get onError => Colors.white;
  @override
  Color get success => const Color(0xFF009E73);
  @override
  Color get onSuccess => Colors.white;
  @override
  Color get warning => const Color(0xFFF0E442);
  @override
  Color get onWarning => const Color(0xFF212121);
  @override
  Color get info => const Color(0xFF0173B2);
  @override
  Color get onInfo => Colors.white;

  @override
  Color get textPrimary => const Color(0xFF212121);
  @override
  Color get textSecondary => const Color(0xFF666666);
  @override
  Color get textDisabled => const Color(0xFFBDBDBD);
  @override
  Color get divider => const Color(0xFFE0E0E0);
  @override
  Color get shadow => Colors.black.withOpacity(0.1);

  @override
  Color get cardBackground => Colors.white;
  @override
  Color get inputBackground => const Color(0xFFF5F5F5);
  @override
  Color get buttonDisabled => const Color(0xFFE0E0E0);
  @override
  Color get iconPrimary => const Color(0xFF424242);
  @override
  Color get iconSecondary => const Color(0xFF757575);
}