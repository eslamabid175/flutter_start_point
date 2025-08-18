import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'theme_state.dart';

/// Manages the theme state of the application
class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  /// Changes the theme mode to light
  void setLightTheme() {
    emit(state.copyWith(themeMode: ThemeMode.light));
  }

  /// Changes the theme mode to dark
  void setDarkTheme() {
    emit(state.copyWith(themeMode: ThemeMode.dark));
  }

  /// Changes the theme mode to system
  void setSystemTheme() {
    emit(state.copyWith(themeMode: ThemeMode.system));
  }

  /// Toggles between light and dark theme
  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      setDarkTheme();
    } else if (state.themeMode == ThemeMode.dark) {
      setLightTheme();
    } else {
      // If system theme, default to light when toggling
      setLightTheme();
    }
  }

  /// Updates the theme mode
  void updateThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  /// Toggles Material 3 design
  void toggleMaterial3() {
    emit(state.copyWith(useMaterial3: !state.useMaterial3));
  }

  /// Checks if the current theme is dark
  bool get isDarkMode => state.themeMode == ThemeMode.dark;

  /// Persists the theme state
  @override
  ThemeState? fromJson(Map<String, dynamic> json) => ThemeState.fromMap(json);

  /// Converts the theme state to JSON for persistence
  @override
  Map<String, dynamic>? toJson(ThemeState state) => state.toMap();
}
