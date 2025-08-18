import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

// Professional Logger Setup
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
  );

  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.d(message, error: error, stackTrace: stackTrace);
    }
  }

  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.i(message, error: error, stackTrace: stackTrace);
    }
  }

  static void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.w(message, error: error, stackTrace: stackTrace);
    }
  }

  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
    // In production, send to crash analytics
    if (!kDebugMode) {
      // FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }

  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}

// Colored Console Prints
class Console {
  static const String _reset = '\x1B[0m';
  static const String _black = '\x1B[30m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';
  static const String _white = '\x1B[37m';

  static void printColored(Object obj, {ConsoleColor color = ConsoleColor.white}) {
    if (kDebugMode) {
      print('${_getColorCode(color)}$obj$_reset');
    }
  }

  static void printWarning(Object obj) => printColored('⚠️ $obj', color: ConsoleColor.yellow);
  static void printError(Object obj) => printColored('❌ $obj', color: ConsoleColor.red);
  static void printInfo(Object obj) => printColored('ℹ️ $obj', color: ConsoleColor.blue);
  static void printSuccess(Object obj) => printColored('✅ $obj', color: ConsoleColor.green);
  static void printDebug(Object obj) => printColored('🔍 $obj', color: ConsoleColor.magenta);

  static String _getColorCode(ConsoleColor color) {
    switch (color) {
      case ConsoleColor.black: return _black;
      case ConsoleColor.red: return _red;
      case ConsoleColor.green: return _green;
      case ConsoleColor.yellow: return _yellow;
      case ConsoleColor.blue: return _blue;
      case ConsoleColor.magenta: return _magenta;
      case ConsoleColor.cyan: return _cyan;
      case ConsoleColor.white: return _white;
    }
  }
}

enum ConsoleColor { black, red, green, yellow, blue, magenta, cyan, white }

// Performance Measurement
class Performance {
  static final Map<String, Stopwatch> _stopwatches = {};

  static void startMeasure(String tag) {
    if (!kDebugMode) return;
    _stopwatches[tag] = Stopwatch()..start();
    Console.printInfo('⏱️ Started measuring: $tag');
  }

  static void endMeasure(String tag) {
    if (!kDebugMode) return;
    final stopwatch = _stopwatches[tag];
    if (stopwatch != null) {
      stopwatch.stop();
      Console.printSuccess('⏱️ $tag took: ${stopwatch.elapsedMilliseconds}ms');
      _stopwatches.remove(tag);
    }
  }

  static T measure<T>(String tag, T Function() operation) {
    startMeasure(tag);
    final result = operation();
    endMeasure(tag);
    return result;
  }

  static Future<T> measureAsync<T>(String tag, Future<T> Function() operation) async {
    startMeasure(tag);
    final result = await operation();
    endMeasure(tag);
    return result;
  }
}

// Memory Usage Monitor
class MemoryMonitor {
  static void printMemoryUsage() {
    if (!kDebugMode) return;
    developer.postEvent('memory', <String, dynamic>{
      'usage': DateTime.now().millisecondsSinceEpoch,
    });
    Console.printInfo('Memory usage logged to DevTools');
  }
}

// Pretty Print for JSON
extension PrettyJson on Map<String, dynamic> {
  void prettyPrint() {
    if (kDebugMode) {
      const encoder = JsonEncoder.withIndent('  ');
      final prettyString = encoder.convert(this);
      Console.printDebug(prettyString);
    }
  }
}