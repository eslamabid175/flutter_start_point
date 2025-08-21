import 'package:flutter/material.dart';

import '../../../../core/shared/utils/extensions/extensions.dart';
import 'package:flutter/widget_previews.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Access theme and custom extensions
    final theme = Theme.of(context);

    return Scaffold(
      body:

      Text("Eslam Aped",style: theme.textTheme.headlineMedium,).center,


    );
  }
}
@Preview(name: 'Greeting Text', size: Size(200, 80), brightness: Brightness.dark)
Widget greeting() => const Text('Hello, Preview!');