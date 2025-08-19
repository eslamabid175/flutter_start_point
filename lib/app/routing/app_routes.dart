import 'package:flutter/material.dart';

import '../../../features/home/presntation/screens/home_screen.dart';
import '../../../features/intro/view/intro_screen.dart';
import '../../../features/layout/presentation/view/screen/layout_view.dart';
import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();
  String initial = NamedRoutes.i.intro;
  AppRoutes._internal();

  Map<String, Widget Function(BuildContext c)> appRoutes = {
    NamedRoutes.i.home: (c) => const HomeScreen(),
    NamedRoutes.i.intro: (c) => const IntroScreen(),
    NamedRoutes.i.layout: (c) => const LayoutView(),
  };
}
