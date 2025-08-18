import 'dart:math' as math;

extension ListExtensions<T> on List<T> {
  // Safe Access
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;

  T? elementAtOrNull(int index) =>
      index >= 0 && index < length ? this[index] : null;

  // Chunking
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      final end = (i + size < length) ? i + size : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }

  // Grouping
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keyFunction(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }

  // Filtering
  List<T> whereNotNull() => where((e) => e != null).toList();

  List<T> distinct() => toSet().toList();

  List<T> distinctBy<K>(K Function(T) keyFunction) {
    final seen = <K>{};
    return where((e) => seen.add(keyFunction(e))).toList();
  }

  // Sorting
  List<T> sortedBy<K extends Comparable>(K Function(T) keyFunction) {
    final copy = [...this];
    copy.sort((a, b) => keyFunction(a).compareTo(keyFunction(b)));
    return copy;
  }

  List<T> sortedByDescending<K extends Comparable>(K Function(T) keyFunction) {
    final copy = [...this];
    copy.sort((a, b) => keyFunction(b).compareTo(keyFunction(a)));
    return copy;
  }

  // Random
  T get random => this[math.Random().nextInt(length)];

  List<T> randomSublist(int count) {
    if (count >= length) return [...this];
    final copy = [...this];
    copy.shuffle();
    return copy.take(count).toList();
  }

  List<T> shuffled() {
    final copy = [...this];
    copy.shuffle();
    return copy;
  }

  // Separation
  List<T> separated(T separator) {
    if (isEmpty) return [];
    final result = <T>[];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }

  // Mapping with Index
  List<R> mapIndexed<R>(R Function(T, int) mapper) {
    final result = <R>[];
    for (int i = 0; i < length; i++) {
      result.add(mapper(this[i], i));
    }
    return result;
  }

  void forEachIndexed(void Function(T, int) action) {
    for (int i = 0; i < length; i++) {
      action(this[i], i);
    }
  }

  // Partitioning
  Pair<List<T>, List<T>> partition(bool Function(T) predicate) {
    final trueList = <T>[];
    final falseList = <T>[];

    for (final element in this) {
      if (predicate(element)) {
        trueList.add(element);
      } else {
        falseList.add(element);
      }
    }

    return Pair(trueList, falseList);
  }

  // Finding
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  T? lastWhereOrNull(bool Function(T) test) {
    for (int i = length - 1; i >= 0; i--) {
      if (test(this[i])) return this[i];
    }
    return null;
  }

  // Statistics (for num lists)
  num? get sum => isEmpty ? null : fold<num>(0, (prev, element) => prev + (element as num));

  double? get average => isEmpty ? null : sum! / length;

  T? get max => isEmpty ? null : reduce((a, b) => (a as Comparable).compareTo(b as Comparable) > 0 ? a : b);

  T? get min => isEmpty ? null : reduce((a, b) => (a as Comparable).compareTo(b as Comparable) < 0 ? a : b);

  // Conversion
  String joinWith(String separator, {String? prefix, String? suffix}) {
    final buffer = StringBuffer();
    if (prefix != null) buffer.write(prefix);
    buffer.write(join(separator));
    if (suffix != null) buffer.write(suffix);
    return buffer.toString();
  }
}

// Helper class for partition
class Pair<T, U> {
  final T first;
  final U second;

  const Pair(this.first, this.second);
}