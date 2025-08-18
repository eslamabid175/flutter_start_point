import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  // Platform Detection
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;
  static bool get isWindows => !kIsWeb && Platform.isWindows;
  static bool get isLinux => !kIsWeb && Platform.isLinux;
  static bool get isFuchsia => !kIsWeb && Platform.isFuchsia;
  static bool get isWeb => kIsWeb;
  static bool get isMobile => isIOS || isAndroid;
  static bool get isDesktop => isMacOS || isWindows || isLinux;

  // Device Info
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final Map<String, dynamic> deviceData = {};

    try {
      if (isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        deviceData.addAll({
          'brand': androidInfo.brand,
          'device': androidInfo.device,
          'model': androidInfo.model,
          'androidId': androidInfo.id,
          'androidVersion': androidInfo.version.release,
          'sdkInt': androidInfo.version.sdkInt,
          'isPhysicalDevice': androidInfo.isPhysicalDevice,
        });
      } else if (isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        deviceData.addAll({
          'name': iosInfo.name,
          'model': iosInfo.model,
          'systemName': iosInfo.systemName,
          'systemVersion': iosInfo.systemVersion,
          'identifierForVendor': iosInfo.identifierForVendor,
          'isPhysicalDevice': iosInfo.isPhysicalDevice,
        });
      } else if (isWeb) {
        final webInfo = await _deviceInfo.webBrowserInfo;
        deviceData.addAll({
          'browserName': webInfo.browserName?.name,
          'appCodeName': webInfo.appCodeName,
          'appName': webInfo.appName,
          'appVersion': webInfo.appVersion,
          'platform': webInfo.platform,
          'userAgent': webInfo.userAgent,
        });
      }
    } catch (e) {
      deviceData['error'] = e.toString();
    }

    return deviceData;
  }

  // App Info
  static Future<Map<String, String>> getAppInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return {
      'appName': packageInfo.appName,
      'packageName': packageInfo.packageName,
      'version': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
    };
  }

  // Screen Utils
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double statusBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double bottomBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = math.sqrt(
      math.pow(size.width, 2) + math.pow(size.height, 2),
    );
    return diagonal > 1100.0;
  }

  // Orientation
  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static void setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  static void setPortraitOnly() {
    setOrientation([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void setLandscapeOnly() {
    setOrientation([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static void setAllOrientations() {
    setOrientation(DeviceOrientation.values);
  }
}