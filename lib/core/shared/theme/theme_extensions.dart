import 'package:flutter/material.dart';

/// Custom theme extensions for additional properties
@immutable
class CustomThemeExtensions extends ThemeExtension<CustomThemeExtensions> {
  final double? borderRadius;
  final double? buttonHeight;
  final double? inputFieldHeight;
  final EdgeInsets? screenPadding;
  final Duration? animationDuration;
  final double? iconSize;

  const CustomThemeExtensions({
    this.borderRadius,
    this.buttonHeight,
    this.inputFieldHeight,
    this.screenPadding,
    this.animationDuration,
    this.iconSize,
  });

  /// Default light theme extensions
  static const light = CustomThemeExtensions(
    borderRadius: 8.0,
    buttonHeight: 48.0,
    inputFieldHeight: 56.0,
    screenPadding: EdgeInsets.all(16.0),
    animationDuration: Duration(milliseconds: 300),
    iconSize: 24.0,
  );

  /// Default dark theme extensions
  static const dark = CustomThemeExtensions(
    borderRadius: 8.0,
    buttonHeight: 48.0,
    inputFieldHeight: 56.0,
    screenPadding: EdgeInsets.all(16.0),
    animationDuration: Duration(milliseconds: 300),
    iconSize: 24.0,
  );

  @override
  CustomThemeExtensions copyWith({
    double? borderRadius,
    double? buttonHeight,
    double? inputFieldHeight,
    EdgeInsets? screenPadding,
    Duration? animationDuration,
    double? iconSize,
  }) =>
      CustomThemeExtensions(
        borderRadius: borderRadius ?? this.borderRadius,
        buttonHeight: buttonHeight ?? this.buttonHeight,
        inputFieldHeight: inputFieldHeight ?? this.inputFieldHeight,
        screenPadding: screenPadding ?? this.screenPadding,
        animationDuration: animationDuration ?? this.animationDuration,
        iconSize: iconSize ?? this.iconSize,
      );

  @override
  CustomThemeExtensions lerp(
      ThemeExtension<CustomThemeExtensions>? other, double t) {
    if (other is! CustomThemeExtensions) {
      return this;
    }
    return CustomThemeExtensions(
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      buttonHeight: lerpDouble(buttonHeight, other.buttonHeight, t),
      inputFieldHeight: lerpDouble(inputFieldHeight, other.inputFieldHeight, t),
      screenPadding: EdgeInsets.lerp(screenPadding, other.screenPadding, t),
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      iconSize: lerpDouble(iconSize, other.iconSize, t),
    );
  }

  /// Helper method to lerp double values
  double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }
}

/// Extension to easily access custom theme extensions
extension ThemeExtensionsX on BuildContext {
  CustomThemeExtensions get themeExtensions =>
      Theme.of(this).extension<CustomThemeExtensions>() ??
      CustomThemeExtensions.light;
}

/// usage example in a widget
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'path/to/your/theme_extensions.dart';
///   /// Example widget using custom theme extensions
///   class ExampleWidget extends StatelessWidget {
///   const ExampleWidget({Key? key}) : super(key: key);
///     @override
///     Widget build(BuildContext context) {
///     final theme = context.themeExtensions;
///     return Container(
///     padding: theme.screenPadding,
///       decoration: BoxDecoration(
///       borderRadius: BorderRadius.circular(theme.borderRadius ?? 8.0),
///       color: Colors.white,
///       ),
///       child: Column(
///       children: [
///       ElevatedButton(
///       onPressed: () {},
///       style: ElevatedButton.styleFrom(
///       height: theme.buttonHeight,
///       shape: RoundedRectangleBorder(
///
