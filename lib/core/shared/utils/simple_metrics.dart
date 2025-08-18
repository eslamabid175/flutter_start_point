// simple_metrics.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:path_provider/path_provider.dart';

class PerformanceMetrics {
  final String name;
  final List<int> samplesMicros = [];
  int errors = 0;
  PerformanceMetrics(this.name);

  void record(Duration d) {
    samplesMicros.add(d.inMicroseconds);
    if (samplesMicros.length > 1000) samplesMicros.removeAt(0);
  }

  void recordError() => errors++;

  Duration average() {
    if (samplesMicros.isEmpty) return Duration.zero;
    final total = samplesMicros.fold<int>(0, (p, e) => p + e);
    return Duration(microseconds: total ~/ samplesMicros.length);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'count': samplesMicros.length,
    'avg_us': average().inMicroseconds,
    'errors': errors,
  };
}

class PerformanceMonitor {
  static final Map<String, PerformanceMetrics> _metrics = {};

  // Sync measurement
  static T measureSync<T>(String name, T Function() operation) {
    final sw = Stopwatch()..start();
    try {
      final result = operation();
      sw.stop();
      _recordMetric(name, sw.elapsed);
      return result;
    } catch (e, s) {
      _recordError(name, e, s);
      rethrow;
    }
  }

  // Async measurement
  static Future<T> measureAsync<T>(String name, Future<T> Function() operation) async {
    final sw = Stopwatch()..start();
    try {
      final result = await operation();
      sw.stop();
      _recordMetric(name, sw.elapsed);
      return result;
    } catch (e, s) {
      sw.stop();
      _recordError(name, e, s);
      rethrow;
    }
  }

  static void _recordMetric(String name, Duration duration) {
    _metrics[name] ??= PerformanceMetrics(name);
    _metrics[name]!.record(duration);

    developer.log('Perf:$name ${duration.inMilliseconds}ms', name: 'PerformanceMonitor');

    // example threshold reporting
    if (duration > Duration(milliseconds: 1000)) {
      _reportSlowOperation(name, duration);
    }
  }

  static void _recordError(String name, Object error, StackTrace? stack) {
    _metrics[name] ??= PerformanceMetrics(name);
    _metrics[name]!.recordError();
    developer.log('Error in $name: $error', name: 'PerformanceMonitor', stackTrace: stack);
  }

  static Future<void> _reportSlowOperation(String name, Duration d) async {
    // هنا تبعت للمونيتورينج سيرفس (HTTP, Sentry breadcrumb, etc.)
  }

  static Map<String, dynamic> snapshot() =>
      _metrics.map((k,v) => MapEntry(k, v.toJson()));

  // Example: persist local snapshot (for later upload)
  static Future<void> persistSnapshot() async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/perf_snapshot_${DateTime.now().millisecondsSinceEpoch}.json');
    await file.writeAsString(jsonEncode(snapshot()));
  }
}
