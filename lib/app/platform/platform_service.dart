


import 'get_platform.dart';

abstract class PlatformService {
  PlatformType get platformType;
  bool get isWeb;
  bool get isMobile;
  bool get isDesktop;
  bool get isIOS;
  bool get isAndroid;
  bool get isMacOS;
  bool get isWindows;
  bool get isLinux;
}

class PlatformServiceImpl implements PlatformService {
  late final PlatformType _platformType;

  PlatformServiceImpl() {
    _platformType = PlatformInfo.getCurrentPlatformType();
  }

  @override
  PlatformType get platformType => _platformType;

  @override
  bool get isWeb => _platformType.isWeb;

  @override
  bool get isMobile => _platformType.isMobile;

  @override
  bool get isDesktop => _platformType.isDesktop;

  @override
  bool get isIOS => _platformType.isIOS;

  @override
  bool get isAndroid => _platformType.isAndroid;

  @override
  bool get isMacOS => _platformType.isMacOS;

  @override
  bool get isWindows => _platformType.isWindows;

  @override
  bool get isLinux => _platformType.isLinux;
}