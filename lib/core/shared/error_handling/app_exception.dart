class AppException implements Exception {
  final String errorMessage;
  final String? errorMessageKey;
  final Object? errorStack;

  AppException({
    required this.errorMessage,
    this.errorMessageKey,
    this.errorStack,
  });

  @override
  String toString() => errorMessage;
}
