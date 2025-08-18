import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<ToggleTheme>(_onToggleTheme);
    on<ChangeLanguage>(_onChangeLanguage);
    on<LoadSettings>(_onLoadSettings);
  }

  Future<void> _onLoadSettings(
      LoadSettings event, Emitter<SettingsState> emit) async {
    try {
      // Default to system settings initially
      emit(state.copyWith(themeMode: ThemeMode.system));
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  Future<void> _onToggleTheme(
      ToggleTheme event, Emitter<SettingsState> emit) async {
    final newThemeMode =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: newThemeMode));
  }

  Future<void> _onChangeLanguage(
      ChangeLanguage event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(locale: event.newLocale));
  }
}
