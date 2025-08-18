import 'package:flutter/cupertino.dart';

mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;
  String _loadingMessage = '';

  bool get isLoading => _isLoading;
  String get loadingMessage => _loadingMessage;

  void startLoading({String message = 'Loading...'}) {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _loadingMessage = message;
      });
    }
  }

  void stopLoading() {
    if (mounted) {
      setState(() {
        _isLoading = false;
        _loadingMessage = '';
      });
    }
  }

  Future<T> withLoading<T>(
      Future<T> Function() operation, {
        String message = 'Loading...',
      }) async {
    startLoading(message: message);
    try {
      return await operation();
    } finally {
      stopLoading();
    }
  }
}