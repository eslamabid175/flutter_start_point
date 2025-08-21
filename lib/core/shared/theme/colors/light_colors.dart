import 'package:flutter/material.dart';
import 'app_colors.dart';

class LightColors implements AppColors {
  @override
  Color get primary => const Color(0xFF1976D2);
  @override
  Color get primaryLight => const Color(0xFF42A5F5);
  @override
  Color get primaryDark => const Color(0xFF0D47A1);
  @override
  Color get onPrimary => Colors.white;

  @override
  Color get secondary => const Color(0xFF7B1FA2);
  @override
  Color get secondaryLight => const Color(0xFFAB47BC);
  @override
  Color get secondaryDark => const Color(0xFF4A148C);
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
  Color get error => const Color(0xFFD32F2F);
  @override
  Color get onError => Colors.white;
  @override
  Color get success => const Color(0xFF388E3C);
  @override
  Color get onSuccess => Colors.white;
  @override
  Color get warning => const Color(0xFFFF6F00);
  @override
  Color get onWarning => Colors.white;
  @override
  Color get info => const Color(0xFF0288D1);
  @override
  Color get onInfo => Colors.white;

  @override
  Color get textPrimary => const Color(0xFF212121);
  @override
  Color get textSecondary => const Color(0xFF757575);
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