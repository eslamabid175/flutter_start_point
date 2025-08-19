import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/config/phoneix.dart';
import '../core/config/unfucs.dart';
import '../core/shared/theme/app_theme.dart';
import '../core/shared/theme/cubit/theme_cubit.dart';
import '../core/shared/theme/cubit/theme_state.dart';
import '../core/shared/utils/debug_utils.dart';
import '../core/shared/utils/observers/route_observer.dart';
import 'app_errors_crashes/error_widgets.dart';
import 'routing/app_routes.dart';
import 'routing/app_routes_fun.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return ScreenUtilInit(
          designSize: MediaQuery.sizeOf(context),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => _MaterialApp(themeState: themeState),
        );
      },
    );
  }
}

class _MaterialApp extends StatelessWidget {
  final ThemeState themeState;

  const _MaterialApp({required this.themeState});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aman',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeState.themeMode,
      navigatorObservers: [
        AppRouteObserver(),
        routeObserver,
      ],
      initialRoute: AppRoutes.init.initial,
      routes: AppRoutes.init.appRoutes,
      navigatorKey: navigatorKey,
      scrollBehavior: _AppScrollBehavior(),
      builder: (context, child) => _AppWrapper(child: child),
    );
  }
}

class _AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.unknown,
  };
}

class _AppWrapper extends StatefulWidget {
  final Widget? child;

  const _AppWrapper({this.child});

  @override
  State<_AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<_AppWrapper> {
  @override
  void initState() {
    super.initState();
    _setupErrorWidget();
  }

  void _setupErrorWidget() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      if (kDebugMode) {
        Console.printError('Error caught by ErrorWidget.builder:');
        Console.printError(details.exception);
        Console.printError('stack trace : ${details.stack}');
      }
      return ErrorScreen(details: details);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: MediaQuery(
        data: _getMediaQueryData(context),
        child: Unfocus(
          child: widget.child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }

  MediaQueryData _getMediaQueryData(BuildContext context) {
    return MediaQuery.of(context).copyWith(
      textScaler: TextScaler.linear(1.sp > 1.2 ? 1.2 : 1.sp),
    );
  }
}