import 'package:flutter/material.dart';

import '../../../../core/shared/theme/theme_extensions.dart';
import '../../../../core/shared/utils/extensions/extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Access theme and custom extensions
    final theme = Theme.of(context);
    final extensions = context.themeExtensions;

    return Scaffold(
      body:Text("Eslam Aped",style: theme.textTheme.headlineMedium,).center,


    );
  }
}
