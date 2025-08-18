import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_cubit.dart';
import 'theme_state.dart';

/// A widget that rebuilds when theme changes
class ThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData theme, bool isDark)
      builder;

  const ThemeBuilder({
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final theme = Theme.of(context);
          final isDark = state.themeMode == ThemeMode.dark ||
              (state.themeMode == ThemeMode.system &&
                  MediaQuery.of(context).platformBrightness == Brightness.dark);

          return builder(context, theme, isDark);
        },
      );
}

/// Example usage:
/// ThemeBuilder(
///   builder: (context, theme, isDark) {
///     return Container(
///       color: isDark ? Colors.grey[900] : Colors.grey[100],
///       child: Text(
///         'Adaptive content',
///         style: TextStyle(
///           color: isDark ? Colors.white : Colors.black,
///           fontSize: 20,
///           fontWeight: FontWeight.bold,
///           ),
///           );
///           ///     );
///           ///   },
///           /// );
///           /// This widget will rebuild whenever the theme changes, allowing you to adapt your UI accordingly.
