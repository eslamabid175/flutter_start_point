part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;

  const SettingsState({
    this.themeMode = ThemeMode.system, // Default to system theme
    this.locale = const Locale('en'), // Default to English
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) =>
      SettingsState(
        themeMode: themeMode ?? this.themeMode,
        locale: locale ?? this.locale,
      );

  @override
  List<Object> get props => [themeMode, locale];
}
