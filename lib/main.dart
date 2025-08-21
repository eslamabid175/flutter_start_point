// main.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'app/app.dart';
import 'app/app_errors_crashes/crash_reporter.dart';
import 'app/app_errors_crashes/error_widgets.dart';
import 'app/app_initializer.dart';
import 'core/shared/utils/depugging/debug_utils.dart';

void main() async {
  // Initialize crash reporter
  await CrashReporter.initialize(() async {
    try {
      await AppInitializer.initialize();
      runApp(DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) {
          return MyApp();
        }
      ));
    } catch (error, stackTrace) {
      if (kDebugMode) {
        Console.printError('Failed to initialize app: $error');
        Console.printError('Stack trace: $stackTrace');
      }
      runApp(InitializationErrorApp(error: error));
    }
  });
}