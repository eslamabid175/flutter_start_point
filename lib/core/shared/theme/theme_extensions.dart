import 'package:flutter/material.dart';

import 'colors/app_colors.dart';


class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final AppColors colors;

  AppThemeExtension({
    required this.colors,
  });

  @override
  AppThemeExtension copyWith({AppColors? colors}) {
    return AppThemeExtension(
      colors: colors ?? this.colors,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      colors: colors,
    );
  }
}

extension ThemeExtensions on BuildContext {
  AppThemeExtension get appTheme {
    return Theme.of(this).extension<AppThemeExtension>()!;
  }

  AppColors get colors {
    return appTheme.colors;
  }
}