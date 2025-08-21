import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../app_theme.dart';

enum AppThemeMode { light, dark, colorBlind }

class ThemeState extends Equatable {
  final AppThemeMode themeMode;

  const ThemeState({
    this.themeMode = AppThemeMode.light,
  });

  // Add this getter
  ThemeMode get materialThemeMode {
    switch (themeMode) {
      case AppThemeMode.light:
      case AppThemeMode.colorBlind:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  // Add this getter to check if colorblind mode is active
  bool get isColorBlindMode => themeMode == AppThemeMode.colorBlind;

  ThemeData get lightTheme {
    return themeMode == AppThemeMode.colorBlind
        ? AppTheme.colorblindTheme()
        : AppTheme.lightTheme();
  }

  ThemeData get darkTheme => AppTheme.darkTheme();

  ThemeState copyWith({
    AppThemeMode? themeMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [themeMode];
}