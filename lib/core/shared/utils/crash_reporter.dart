// crash_reporter.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class CrashReport {
  final String error;
  final String stack;
  final Map<String, dynamic> device;
  final Map<String, dynamic> app;
  final List<Map<String, dynamic>> breadcrumbs;
  CrashReport({
    required this.error,
    required this.stack,
    required this.device,
    required this.app,
    required this.breadcrumbs,
  });
  Map<String, dynamic> toJson() => {
    'error': error,
    'stack': stack,
    'device': device,
    'app': app,
    'breadcrumbs': breadcrumbs,
  };
}

class CrashReporter {
  static final List<Map<String, dynamic>> _breadcrumbs = [];

  static void addBreadcrumb(String msg, [Map<String, dynamic>? data]) {
    _breadcrumbs.add({'time': DateTime.now().toIso8601String(), 'msg': msg, 'data': data});
    if (_breadcrumbs.length > 200) _breadcrumbs.removeAt(0);
  }

  static Future<void> initialize(FutureOr<void> Function() appStart) async {
    FlutterError.onError = (details) async {
      FlutterError.presentError(details);
      await _report(details.exceptionAsString(), details.stack.toString());
    };

    runZonedGuarded<Future<void>>(() async {
      await appStart();
    }, (error, stack) async {
      await _report(error.toString(), stack.toString());
    });

    // Platform errors
    // ignore: prefer_function_declarations_over_variables
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      _report(error.toString(), stack.toString());
      return true;
    };
  }

  static Future<void> _report(String error, String stack) async {
    final device = await _collectDeviceInfo();
    final app = await _collectAppInfo();
    final report = CrashReport(
      error: error,
      stack: stack,
      device: device,
      app: app,
      breadcrumbs: List.of(_breadcrumbs),
    );

    // send to server or persistence
    final ok = await _sendReportToServer(report);
    if (!ok) await _storeReportLocally(report);
  }

  static Future<Map<String, dynamic>> _collectDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        return {'model': info.model, 'sdkInt': info.version.sdkInt, 'isPhysical': info.isPhysicalDevice};
      } else if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        return {'model': info.utsname.machine, 'systemVersion': info.systemVersion};
      }
    } catch (e) {}
    return {};
  }

  static Future<Map<String, dynamic>> _collectAppInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return {'appName': info.appName, 'version': info.version, 'buildNumber': info.buildNumber};
    } catch (e) {
      return {};
    }
  }

  static Future<bool> _sendReportToServer(CrashReport report) async {
    // Implement HTTP upload to your backend or use Sentry/Firebase SDK calls
    return false;
  }

  static Future<void> _storeReportLocally(CrashReport report) async {
    final dir = await getApplicationDocumentsDirectory();
    final f = File('${dir.path}/crash_${DateTime.now().millisecondsSinceEpoch}.json');
    await f.writeAsString(jsonEncode(report.toJson()));
  }
}
