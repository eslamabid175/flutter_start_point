import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';



class PlatformInfo {
  static PlatformType getCurrentPlatformType() {
    if (kIsWeb) {
      return PlatformType.web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
        return PlatformType.macOS;
      case TargetPlatform.fuchsia:
        return PlatformType.fuchsia;
      case TargetPlatform.linux:
        return PlatformType.linux;
      case TargetPlatform.windows:
        return PlatformType.windows;
      case TargetPlatform.iOS:
        return PlatformType.iOS;
      case TargetPlatform.android:
        return PlatformType.android;
    }
  }
}

// Renamed from PT to PlatformType for better clarity
enum PlatformType {
  web,
  iOS,
  android,
  macOS,
  fuchsia,
  linux,
  windows,
}

extension PlatformTypeExtension on PlatformType {
  String get name {
    switch (this) {
      case PlatformType.web:
        return 'Web';
      case PlatformType.iOS:
        return 'iOS';
      case PlatformType.android:
        return 'Android';
      case PlatformType.macOS:
        return 'macOS';
      case PlatformType.fuchsia:
        return 'Fuchsia';
      case PlatformType.linux:
        return 'Linux';
      case PlatformType.windows:
        return 'Windows';
    }
  }

  bool get isWeb => this == PlatformType.web;
  bool get isIOS => this == PlatformType.iOS;
  bool get isAndroid => this == PlatformType.android;
  bool get isMacOS => this == PlatformType.macOS;
  bool get isFuchsia => this == PlatformType.fuchsia;
  bool get isLinux => this == PlatformType.linux;
  bool get isWindows => this == PlatformType.windows;

  bool get isMobile => isIOS || isAndroid;
  bool get isDesktop => isMacOS || isLinux || isWindows || isFuchsia;

  bool get isNotWeb => !isWeb;
  bool get isNotMobile => !isMobile;
  bool get isNotDesktop => !isDesktop;
}

// For backward compatibility during migration (optional)
typedef PT = PlatformType;