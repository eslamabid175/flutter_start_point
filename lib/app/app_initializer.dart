// app/app_initializer.dart
import 'package:bloc/bloc.dart';
import 'package:croppy/croppy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../core/shared/utils/depugging/debug_utils.dart';
import '../core/shared/utils/observers/bloc_observer.dart';
import 'di.dart' as di;
import 'platform/platform_service.dart';

/// Handles all app initialization logic
class AppInitializer {
  static const _initTimeout = Duration(seconds: 30);

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await Future.wait([
        //_initializeStorage(),
        _configureDependencies(),
      ]).timeout(_initTimeout);

      await _configureUI();
      await _configurePlatformSpecifics();

      _logInitializationSuccess();
    } catch (e) {
      _logInitializationError(e);
      rethrow;
    }
  }

  // static Future<void> _initializeStorage() async {
  //   try {
  //     final storageDirectory = await getApplicationDocumentsDirectory();
  //     HydratedBloc.storage = await HydratedStorage.build(
  //       storageDirectory: HydratedStorageDirectory(storageDirectory.path),
  //     );
  //   } catch (e) {
  //     throw InitializationException('Failed to initialize storage', e);
  //   }
  // }

  static Future<void> _configureDependencies() async {
    try {
      Bloc.observer = AppBlocObserver();
      await di.initGitIt();
    } catch (e) {
      throw InitializationException('Failed to configure dependencies', e);
    }
  }

  static Future<void> _configureUI() async {
    await ScreenUtil.ensureScreenSize();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Optional: Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  static Future<void> _configurePlatformSpecifics() async {
    final platformService = di.sl<PlatformService>();

    if (!platformService.isWeb) {
      croppyForceUseCassowaryDartImpl = true;
    }

    if (kDebugMode) {
      Console.printInfo('Platform: ${platformService.platformType.name}');
    }
  }

  static void _logInitializationSuccess() {
    if (kDebugMode) {
      Console.printSuccess('✅ App initialized successfully');
    }
  }

  static void _logInitializationError(Object error) {
    if (kDebugMode) {
      Console.printError('❌ App initialization failed: $error');
    }
  }
}

class InitializationException implements Exception {
  final String message;
  final Object? cause;

  InitializationException(this.message, [this.cause]);

  @override
  String toString() => cause != null ? '$message: $cause' : message;
}