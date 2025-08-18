import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Represents the current theme state of the application
class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final bool useMaterial3;

  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.useMaterial3 = true,
  });

  /// Creates a copy of the current state with optional parameter overrides
  ThemeState copyWith({
    ThemeMode? themeMode,
    bool? useMaterial3,
  }) =>
      ThemeState(
        themeMode: themeMode ?? this.themeMode,
        useMaterial3: useMaterial3 ?? this.useMaterial3,
      );

  /// Converts the state to a Map for persistence
  Map<String, dynamic> toMap() => {
        'themeMode': themeMode.index,
        'useMaterial3': useMaterial3,
      };

  /// Creates a ThemeState from a Map
  factory ThemeState.fromMap(Map<String, dynamic> map) => ThemeState(
        themeMode: ThemeMode.values[map['themeMode'] as int ?? 0],
        useMaterial3: map['useMaterial3'] as bool ?? true,
      );

  @override
  List<Object?> get props => [themeMode, useMaterial3];
}
