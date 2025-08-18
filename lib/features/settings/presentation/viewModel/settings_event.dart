part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends SettingsEvent {}

class ChangeLanguage extends SettingsEvent {
  final Locale newLocale;

  const ChangeLanguage(this.newLocale);

  @override
  List<Object> get props => [newLocale];
}

// Event to load initial settings (optional, could be done in constructor)
class LoadSettings extends SettingsEvent {}
