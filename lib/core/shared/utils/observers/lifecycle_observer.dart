import 'package:flutter/material.dart';

import '../depugging/debug_utils.dart';

// App Lifecycle Observer
class AppLifecycleObserver extends WidgetsBindingObserver {
  static final AppLifecycleObserver _instance = AppLifecycleObserver._internal();

  factory AppLifecycleObserver() => _instance;

  AppLifecycleObserver._internal();

  final List<VoidCallback> _resumeCallbacks = [];
  final List<VoidCallback> _pauseCallbacks = [];
  final List<VoidCallback> _detachCallbacks = [];
  final List<VoidCallback> _inactiveCallbacks = [];

  AppLifecycleState? _lastLifecycleState;
  DateTime? _pausedAt;
  DateTime? _resumedAt;

  AppLifecycleState? get currentState => _lastLifecycleState;
  Duration? get pauseDuration =>
      _pausedAt != null && _resumedAt != null
          ? _resumedAt!.difference(_pausedAt!)
          : null;

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    Console.printSuccess('✅ Lifecycle Observer Initialized');
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _resumeCallbacks.clear();
    _pauseCallbacks.clear();
    _detachCallbacks.clear();
    _inactiveCallbacks.clear();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lastLifecycleState = state;

    switch (state) {
      case AppLifecycleState.resumed:
        _onResumed();
        break;
      case AppLifecycleState.paused:
        _onPaused();
        break;
      case AppLifecycleState.inactive:
        _onInactive();
        break;
      case AppLifecycleState.detached:
        _onDetached();
        break;
      case AppLifecycleState.hidden:
        _onHidden();
        break;
    }
  }

  void _onResumed() {
    _resumedAt = DateTime.now();
    Console.printColored('🟢 App Resumed', color: ConsoleColor.green);

    if (_pausedAt != null) {
      final duration = _resumedAt!.difference(_pausedAt!);
      Console.printInfo('App was paused for: ${duration.inSeconds} seconds');
    }

    // Execute callbacks
    for (final callback in _resumeCallbacks) {
      callback();
    }

    // Resume services
    _resumeServices();

    // Log analytics
    _logLifecycleEvent('app_resumed');
  }

  void _onPaused() {
    _pausedAt = DateTime.now();
    Console.printColored('🟠 App Paused', color: ConsoleColor.yellow);

    // Execute callbacks
    for (final callback in _pauseCallbacks) {
      callback();
    }

    // Pause services
    _pauseServices();

    // Save app state
    _saveAppState();

    // Log analytics
    _logLifecycleEvent('app_paused');
  }

  void _onInactive() {
    Console.printColored('⚪ App Inactive', color: ConsoleColor.white);

    // Execute callbacks
    for (final callback in _inactiveCallbacks) {
      callback();
    }

    // Log analytics
    _logLifecycleEvent('app_inactive');
  }

  void _onDetached() {
    Console.printColored('🔴 App Detached', color: ConsoleColor.red);

    // Execute callbacks
    for (final callback in _detachCallbacks) {
      callback();
    }

    // Cleanup resources
    _cleanupResources();

    // Log analytics
    _logLifecycleEvent('app_detached');
  }

  void _onHidden() {
    Console.printColored('⚫ App Hidden', color: ConsoleColor.magenta);

    // Log analytics
    _logLifecycleEvent('app_hidden');
  }

  // Service Management
  void _resumeServices() {
    // Resume location updates
    // LocationService.instance.resume();

    // Resume background tasks
    // BackgroundTaskManager.instance.resume();

    // Reconnect websockets
    // WebSocketManager.instance.reconnect();

    // Refresh tokens if needed
    // AuthService.instance.refreshTokenIfNeeded();
  }

  void _pauseServices() {
    // Pause location updates
    // LocationService.instance.pause();

    // Pause background tasks
    // BackgroundTaskManager.instance.pause();

    // Close non-critical connections
    // NetworkManager.instance.closeNonCriticalConnections();
  }

  void _cleanupResources() {
    // Clear image cache
    // imageCache.clear();

    // Close database connections
    // DatabaseManager.instance.close();

    // Cancel timers
    // TimerManager.instance.cancelAll();
  }

  void _saveAppState() {
    // Save current state to storage
    // AppStateManager.instance.save();
  }

  void _logLifecycleEvent(String event) {
    // FirebaseAnalytics.instance.logEvent(name: event);
    AppLogger.info('Lifecycle Event: $event');
  }

  // Callback Registration
  void addResumeCallback(VoidCallback callback) {
    _resumeCallbacks.add(callback);
  }

  void removeResumeCallback(VoidCallback callback) {
    _resumeCallbacks.remove(callback);
  }

  void addPauseCallback(VoidCallback callback) {
    _pauseCallbacks.add(callback);
  }

  void removePauseCallback(VoidCallback callback) {
    _pauseCallbacks.remove(callback);
  }

  void addInactiveCallback(VoidCallback callback) {
    _inactiveCallbacks.add(callback);
  }

  void removeInactiveCallback(VoidCallback callback) {
    _inactiveCallbacks.remove(callback);
  }

  void addDetachCallback(VoidCallback callback) {
    _detachCallbacks.add(callback);
  }

  void removeDetachCallback(VoidCallback callback) {
    _detachCallbacks.remove(callback);
  }

  // Additional observers
  @override
  void didChangeAccessibilityFeatures() {
    Console.printInfo('♿ Accessibility features changed');
  }

  @override
  void didHaveMemoryPressure() {
    Console.printWarning('⚠️ Memory pressure detected!');
    _handleMemoryPressure();
  }

  void _handleMemoryPressure() {
    // Clear caches
    imageCache.clear();
    imageCache.clearLiveImages();

    // Trigger garbage collection hint
    // System.gc(); // Platform specific

    // Notify app about memory pressure
    // MemoryManager.instance.handleMemoryPressure();

    AppLogger.warning('Memory pressure handled - caches cleared');
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    Console.printInfo('🌍 Locales changed: $locales');
  }

  @override
  void didChangeTextScaleFactor() {
    Console.printInfo('📝 Text scale factor changed');
  }

  @override
  void didChangePlatformBrightness() {
    Console.printInfo('🌓 Platform brightness changed');
  }

  @override
  void didChangeMetrics() {
    Console.printDebug('📐 Metrics changed (keyboard, rotation, etc.)');
  }
}

// Lifecycle-aware mixin for StatefulWidgets
mixin LifecycleAwareMixin<T extends StatefulWidget> on State<T> {
  AppLifecycleState? _lifecycleState;

  @override
  void initState() {
    super.initState();
    _lifecycleState = AppLifecycleObserver().currentState;
    AppLifecycleObserver().addResumeCallback(_onAppResumed);
    AppLifecycleObserver().addPauseCallback(_onAppPaused);
  }

  @override
  void dispose() {
    AppLifecycleObserver().removeResumeCallback(_onAppResumed);
    AppLifecycleObserver().removePauseCallback(_onAppPaused);
    super.dispose();
  }

  void _onAppResumed() {
    if (mounted) {
      setState(() {
        _lifecycleState = AppLifecycleState.resumed;
      });
      onAppResumed();
    }
  }

  void _onAppPaused() {
    if (mounted) {
      setState(() {
        _lifecycleState = AppLifecycleState.paused;
      });
      onAppPaused();
    }
  }

  // Override these in your widgets
  void onAppResumed() {}
  void onAppPaused() {}

  AppLifecycleState? get lifecycleState => _lifecycleState;
  bool get isAppInForeground => _lifecycleState == AppLifecycleState.resumed;
  bool get isAppInBackground => _lifecycleState == AppLifecycleState.paused;
}