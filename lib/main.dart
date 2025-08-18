import 'dart:ui';

import 'package:croppy/croppy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'app/routing/app_routes.dart';
import 'app/routing/app_routes_fun.dart';
import 'core/config/di/injection_container.dart' as di;

import 'core/config/get_platform.dart';
import 'core/config/phoneix.dart';

import 'core/config/unfucs.dart';
import 'core/shared/theme/app_theme.dart';
import 'core/shared/theme/cubit/theme_cubit.dart';
import 'core/shared/theme/cubit/theme_state.dart';
import 'core/shared/utils/bloc_observer.dart';
import 'core/shared/utils/observers/route_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// for theme to work properly
  // Get the application documents directory
  final storageDirectory = await getApplicationDocumentsDirectory();
  // Initialize HydratedStorage with HydratedStorageDirectory
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(storageDirectory.path),
  );
  Bloc.observer = SimpleBlocObserver();

  await ScreenUtil.ensureScreenSize();
  // Ensure the screen size is initialized before setting orientations
  // ///edge to edge mode allows the app to use the full screen
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  /// Set preferred orientations to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await di.init(); // Initialize GetIt
  /// Initialize the platform info
  /// This is important for platform-specific features
  ///
  pt = PlatformInfo.getCurrentPlatformType();
  if (pt.isNotWeb) {
    // Force use of Cassowary Dart implementation for non-web platforms
    // This is useful for platforms that require specific layout calculations
    // This is a workaround for Cassowary Dart not being used by default
    croppyForceUseCassowaryDartImpl = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ThemeCubit(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) => ScreenUtilInit(
            designSize: MediaQuery.sizeOf(context),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
              title: 'My Boilerplate',
              debugShowCheckedModeBanner: false,
            //  showPerformanceOverlay: true, // بيظهر عداد الفريمات (GPU & UI)
            //  checkerboardRasterCacheImages: true, // يحدد لك الصور اللي بتتعمل لها cache
            //  checkerboardOffscreenLayers: true,   // يحدد الطبقات المرسومة خارج الشاشة
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
              scrollBehavior:
                  const MaterialScrollBehavior().copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.stylus,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.unknown,
              }),
              builder: (context, child) {
                ErrorWidget.builder = (FlutterErrorDetails details) {
                  // Handle errors globally
                  return Scaffold(
                      appBar: AppBar(
                    title: const Text('Error Occurred'),
                    elevation: 0,
                    backgroundColor: Colors.white,
                  ));
                };
                return Phoenix(
                    child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.linear(1.sp > 1.2 ? 1.2 : 1.sp)),
                  child: Unfocus(child: child ?? const SizedBox.shrink()),
                ));
              },
            ),
          ),
        ),
      );
}
