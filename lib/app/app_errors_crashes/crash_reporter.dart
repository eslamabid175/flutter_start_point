// app/app_errors_crashes/crash_reporter.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/shared/utils/depugging/debug_utils.dart';


class CrashReport {
  final String error;
  final String stack;
  final Map<String, dynamic> device;
  final Map<String, dynamic> app;
  final List<Map<String, dynamic>> breadcrumbs;
  final DateTime timestamp;
  final String? userId;
  final Map<String, dynamic>? customData;

  CrashReport({
    required this.error,
    required this.stack,
    required this.device,
    required this.app,
    required this.breadcrumbs,
    DateTime? timestamp,
    this.userId,
    this.customData,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'error': error,
    'stack': stack,
    'device': device,
    'app': app,
    'breadcrumbs': breadcrumbs,
    'timestamp': timestamp.toIso8601String(),
    'userId': userId,
    'customData': customData,
  };
}

class CrashReporter {
  static final List<Map<String, dynamic>> _breadcrumbs = [];
  static const int _maxBreadcrumbs = 200;
  static bool _isInitialized = false;
  static String? _userId;
  static Map<String, dynamic>? _customData;

  /// Set user identifier for crash reports
  static void setUserId(String? userId) {
    _userId = userId;
    addBreadcrumb('User ID set', {'userId': userId});
  }

  /// Add custom data to be included in crash reports
  static void setCustomData(Map<String, dynamic>? data) {
    _customData = data;
  }

  /// Add a breadcrumb to track user actions
  static void addBreadcrumb(String message, [Map<String, dynamic>? data]) {
    if (!_isInitialized) return;

    _breadcrumbs.add({
      'timestamp': DateTime.now().toIso8601String(),
      'message': message,
      'data': data,
    });

    if (_breadcrumbs.length > _maxBreadcrumbs) {
      _breadcrumbs.removeAt(0);
    }

    if (kDebugMode) {
      Console.printDebug('🍞 Breadcrumb: $message ${data != null ? jsonEncode(data) : ''}');
    }
  }

  /// Initialize crash reporting
  static Future<void> initialize(FutureOr<void> Function() appStart) async {
    if (_isInitialized) return;
    _isInitialized = true;

    // Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (kDebugMode) {
        // In debug mode, show the error in console
        FlutterError.presentError(details);
        Console.printError('Flutter Error: ${details.exceptionAsString()}');
      }
      await _reportError(
        details.exceptionAsString(),
        details.stack.toString(),
        isFatal: details.silent,
      );
    };

    // Run app in guarded zone to catch async errors
    await runZonedGuarded<Future<void>>(
          () async {
        // Platform dispatcher errors
        PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
          _reportError(error.toString(), stack.toString());
          return true; // Prevents app from crashing
        };

        await appStart();
      },
          (error, stack) async {
        if (kDebugMode) {
          Console.printError('Zone Error: $error');
        }
        await _reportError(error.toString(), stack.toString());
      },
    );
  }

  /// Report an error manually
  static Future<void> reportError(
      dynamic error,
      StackTrace? stackTrace, {
        Map<String, dynamic>? additionalData,
        bool isFatal = false,
      }) async {
    await _reportError(
      error.toString(),
      stackTrace?.toString() ?? '',
      additionalData: additionalData,
      isFatal: isFatal,
    );
  }

  static Future<void> _reportError(
      String error,
      String stack, {
        Map<String, dynamic>? additionalData,
        bool isFatal = false,
      }) async {
    try {
      final device = await _collectDeviceInfo();
      final app = await _collectAppInfo();

      final report = CrashReport(
        error: error,
        stack: stack,
        device: device,
        app: app,
        breadcrumbs: List.of(_breadcrumbs),
        userId: _userId,
        customData: {
          ..._customData ?? {},
          ...additionalData ?? {},
          'isFatal': isFatal,
        },
      );

      // Try to send to server
      final sent = await _sendReportToServer(report);

      if (!sent) {
        // Store locally if sending failed
        await _storeReportLocally(report);
      }

      // Clear breadcrumbs after reporting
      _breadcrumbs.clear();

    } catch (e) {
      if (kDebugMode) {
        Console.printError('Failed to report crash: $e');
      }
    }
  }

  static Future<Map<String, dynamic>> _collectDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (kIsWeb) {
        final info = await deviceInfo.webBrowserInfo;
        return {
          'platform': 'web',
          'browser': info.browserName.name,
          'userAgent': info.userAgent,
        };
      } else if (Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        return {
          'platform': 'android',
          'model': info.model,
          'brand': info.brand,
          'sdkInt': info.version.sdkInt,
          'release': info.version.release,
          'isPhysicalDevice': info.isPhysicalDevice,
        };
      } else if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        return {
          'platform': 'ios',
          'model': info.utsname.machine,
          'systemVersion': info.systemVersion,
          'isPhysicalDevice': info.isPhysicalDevice,
        };
      }
    } catch (e) {
      if (kDebugMode) {
        Console.printError('Failed to collect device info: $e');
      }
    }
    return {'platform': 'unknown'};
  }

  static Future<Map<String, dynamic>> _collectAppInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return {
        'appName': info.appName,
        'packageName': info.packageName,
        'version': info.version,
        'buildNumber': info.buildNumber,
      };
    } catch (e) {
      if (kDebugMode) {
        Console.printError('Failed to collect app info: $e');
      }
      return {};
    }
  }

  static Future<bool> _sendReportToServer(CrashReport report) async {
    // TODO: Implement your server endpoint
    // Example:
    // try {
    //   final response = await http.post(
    //     Uri.parse('https://your-api.com/crash-reports'),
    //     headers: {'Content-Type': 'application/json'},
    //     body: jsonEncode(report.toJson()),
    //   );
    //   return response.statusCode == 200;
    // } catch (e) {
    //   return false;
    // }

    if (kDebugMode) {
      Console.printWarning('Crash report (not sent to server in debug mode):');
      Console.printDebug(jsonEncode(report.toJson()));
    }

    return false; // For now, always store locally
  }

  static Future<void> _storeReportLocally(CrashReport report) async {
    if (kIsWeb) {
      // For web, you might want to use localStorage or IndexedDB
      if (kDebugMode) {
        Console.printInfo('Crash report stored in console (web platform)');
      }
      return;
    }

    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/crashes/crash_${DateTime.now().millisecondsSinceEpoch}.json');

      // Create directory if it doesn't exist
      await file.parent.create(recursive: true);

      await file.writeAsString(jsonEncode(report.toJson()));

      if (kDebugMode) {
        Console.printInfo('Crash report saved locally: ${file.path}');
      }

      // Clean old crash reports (keep last 10)
      await _cleanOldReports(file.parent);
    } catch (e) {
      if (kDebugMode) {
        Console.printError('Failed to store crash report: $e');
      }
    }
  }

  static Future<void> _cleanOldReports(Directory crashDir) async {
    try {
      final files = crashDir.listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.json'))
          .toList()
        ..sort((a, b) => b.path.compareTo(a.path));

      if (files.length > 10) {
        for (var i = 10; i < files.length; i++) {
          await files[i].delete();
        }
      }
    } catch (e) {
      // Ignore cleanup errors
    }
  }

  /// Upload stored crash reports when network is available
  static Future<void> uploadPendingReports() async {
    if (kIsWeb) return;

    try {
      final dir = await getApplicationDocumentsDirectory();
      final crashDir = Directory('${dir.path}/crashes');

      if (!await crashDir.exists()) return;

      final files = crashDir.listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.json'))
          .toList();

      for (final file in files) {
        try {
          final content = await file.readAsString();
          final data = jsonDecode(content);
          final report = CrashReport(
            error: data['error'],
            stack: data['stack'],
            device: data['device'],
            app: data['app'],
            breadcrumbs: List<Map<String, dynamic>>.from(data['breadcrumbs']),
            userId: data['userId'],
            customData: data['customData'],
          );

          if (await _sendReportToServer(report)) {
            await file.delete();
          }
        } catch (e) {
          // Skip corrupted files
        }
      }
    } catch (e) {
      if (kDebugMode) {
        Console.printError('Failed to upload pending reports: $e');
      }
    }
  }
}
//usage example
//// Track navigation
// CrashReporter.addBreadcrumb('Navigation', {'route': '/home'});
//
// // Track user actions
// CrashReporter.addBreadcrumb('Button clicked', {'button': 'submit'});
//
// // Set user info after login
// CrashReporter.setUserId('user123');
//
// // Report handled errors
// try {
//   // Some risky operation
// } catch (e, stack) {
//   CrashReporter.reportError(e, stack, additionalData: {
//     'operation': 'data_fetch',
//     'endpoint': '/api/data'
//   });
// }
//
// // Upload pending reports when app starts or network is available
// CrashReporter.uploadPendingReports();