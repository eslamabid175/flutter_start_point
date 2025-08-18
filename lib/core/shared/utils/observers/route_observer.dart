import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


// Global Route Observer Instance

import '../debug_utils.dart';final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

// Custom Route Observer with Analytics
class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  // Track screen views for analytics
  void _sendScreenView(PageRoute<dynamic> route) {
    final screenName = route.settings.name ?? 'Unknown';
    Console.printInfo('📱 Screen View: $screenName');

    // Send to analytics
    // FirebaseAnalytics.instance.setCurrentScreen(screenName: screenName);
    // MixpanelAnalytics.track('screen_view', {'screen': screenName});
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
      Console.printColored(
        '➡️ PUSH: ${previousRoute?.settings.name ?? 'None'} → ${route.settings.name}',
        color: ConsoleColor.green,
      );

      // Log navigation event
      _logNavigationEvent('push', route, previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
      Console.printColored(
        '⬅️ POP: ${route.settings.name} → ${previousRoute.settings.name ?? 'None'}',
        color: ConsoleColor.yellow,
      );

      // Log navigation event
      _logNavigationEvent('pop', route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
      Console.printColored(
        '🔄 REPLACE: ${oldRoute?.settings.name} → ${newRoute.settings.name}',
        color: ConsoleColor.blue,
      );

      // Log navigation event
      _logNavigationEvent('replace', newRoute, oldRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    Console.printColored(
      '🗑️ REMOVE: ${route.settings.name}',
      color: ConsoleColor.red,
    );

    // Log navigation event
    _logNavigationEvent('remove', route, previousRoute);
  }

  void _logNavigationEvent(
      String action,
      Route<dynamic>? route,
      Route<dynamic>? previousRoute,
      ) {
    final event = {
      'action': action,
      'route': route?.settings.name,
      'previous_route': previousRoute?.settings.name,
      'arguments': route?.settings.arguments?.toString(),
      'timestamp': DateTime.now().toIso8601String(),
    };

    // Log to your analytics service
    AppLogger.debug('Navigation Event: $event');
  }
}

// Route-aware mixin for StatefulWidgets
mixin RouteAwareMixin<T extends StatefulWidget> on State<T> implements RouteAware {
  RouteObserver<ModalRoute<void>>? _routeObserver;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver?.unsubscribe(this);
    _routeObserver = routeObserver;
    _routeObserver?.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Called when the current route has been pushed
    Console.printDebug('${widget.runtimeType} - didPush');
    onRouteDidPush();
  }

  @override
  void didPopNext() {
    // Called when the top route has been popped off, and the current route shows up
    Console.printDebug('${widget.runtimeType} - didPopNext');
    onRouteDidPopNext();
  }

  @override
  void didPop() {
    // Called when the current route has been popped off
    Console.printDebug('${widget.runtimeType} - didPop');
    onRouteDidPop();
  }

  @override
  void didPushNext() {
    // Called when a new route has been pushed, and the current route is no longer visible
    Console.printDebug('${widget.runtimeType} - didPushNext');
    onRouteDidPushNext();
  }

  // Override these in your widgets
  void onRouteDidPush() {}
  void onRouteDidPopNext() {}
  void onRouteDidPop() {}
  void onRouteDidPushNext() {}
}

// Navigation Logger for debugging
class NavigationLogger {
  static final List<NavigationEvent> _history = [];
  static const int _maxHistorySize = 50;

  static List<NavigationEvent> get history => List.unmodifiable(_history);

  static void log(NavigationEvent event) {
    _history.add(event);
    if (_history.length > _maxHistorySize) {
      _history.removeAt(0);
    }

    if (kDebugMode) {
      Console.printDebug('Navigation: ${event.toString()}');
    }
  }

  static void clear() {
    _history.clear();
  }

  static void printHistory() {
    Console.printInfo('=== Navigation History ===');
    for (var i = 0; i < _history.length; i++) {
      Console.printInfo('${i + 1}. ${_history[i]}');
    }
    Console.printInfo('========================');
  }

  static NavigationEvent? get lastEvent => _history.isEmpty ? null : _history.last;

  static String? get currentRoute => lastEvent?.to;

  static List<String> get routeStack {
    final stack = <String>[];
    for (final event in _history) {
      if (event.action == NavigationAction.push && event.to != null) {
        stack.add(event.to!);
      } else if (event.action == NavigationAction.pop && stack.isNotEmpty) {
        stack.removeLast();
      }
    }
    return stack;
  }
}

// Navigation Event Model
class NavigationEvent {
  final NavigationAction action;
  final String? from;
  final String? to;
  final Object? arguments;
  final DateTime timestamp;

  NavigationEvent({
    required this.action,
    this.from,
    this.to,
    this.arguments,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() {
    return '${action.name.toUpperCase()}: ${from ?? 'null'} → ${to ?? 'null'} at ${timestamp.toIso8601String()}';
  }
}

enum NavigationAction { push, pop, replace, remove }