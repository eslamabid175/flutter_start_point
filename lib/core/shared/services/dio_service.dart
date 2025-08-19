import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../commonWidgets/custtoms/loading_widget.dart';
import '../costants/app_strings.dart';
import '../utils/depugging/debug_utils.dart';
import '../utils/extensions/context_extensions.dart';
import 'storage_service.dart';

class DioService {
  // Singleton pattern
  DioService._internal() {
    _initialize();
  }
  static final DioService _instance = DioService._internal();
  static DioService get instance => _instance;
  factory DioService() => _instance;

  // Core instances
  late final Dio _dio;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  // State management
  final StreamController<NetworkStatus> _networkStatusController =
  StreamController<NetworkStatus>.broadcast();
  final StreamController<ApiCallStatus> _apiCallController =
  StreamController<ApiCallStatus>.broadcast();

  NetworkStatus _currentNetworkStatus = NetworkStatus.unknown;
  final Map<String, CancelToken> _cancelTokens = {};

  // Configuration
  static const String baseUrl = 'https://api.example.com';
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Getters
  Stream<NetworkStatus> get networkStatusStream => _networkStatusController.stream;
  Stream<ApiCallStatus> get apiCallStream => _apiCallController.stream;
  NetworkStatus get currentNetworkStatus => _currentNetworkStatus;
  bool get isConnected => _currentNetworkStatus != NetworkStatus.disconnected;

  // Initialize service
  void _initialize() {
    Console.printInfo('🌐 Initializing DIO Service...');

    _setupDio();
    _setupConnectivityMonitoring();

    Console.printSuccess('✅ DIO Service initialized');
  }

  // Setup Dio
  void _setupDio() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Configure adapter
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (cert, host, port) => true; // For dev only
      return client;
    };

    // Add interceptors
    _dio.interceptors.addAll([
      _AuthInterceptor(),
      _LoggingInterceptor(),
      _ErrorInterceptor(),
      _RetryInterceptor(),
      _CacheInterceptor(),
    ]);
  }

  // Setup connectivity monitoring
  void _setupConnectivityMonitoring() {
    // Check initial connectivity
    _checkConnectivity();

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
          (List<ConnectivityResult> results) {
        _handleConnectivityChange(results);
      },
    );
  }

  // Check connectivity
  Future<void> _checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _handleConnectivityChange(result);
    } catch (e) {
      Console.printError('Connectivity check failed: $e');
      _updateNetworkStatus(NetworkStatus.disconnected);
    }
  }

  // Handle connectivity change
  void _handleConnectivityChange(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none)) {
      _updateNetworkStatus(NetworkStatus.disconnected);
    } else if (results.contains(ConnectivityResult.mobile)) {
      _updateNetworkStatus(NetworkStatus.mobile);
    } else if (results.contains(ConnectivityResult.wifi)) {
      _updateNetworkStatus(NetworkStatus.wifi);
    } else {
      _updateNetworkStatus(NetworkStatus.connected);
    }
  }

  // Update network status
  void _updateNetworkStatus(NetworkStatus status) {
    _currentNetworkStatus = status;
    _networkStatusController.add(status);

    Console.printInfo('Network status: $status');

    if (status == NetworkStatus.disconnected) {
      _showNoInternetDialog();
    }
  }

  // Show no internet dialog
  void _showNoInternetDialog() {
    final context = navigatorKey.currentContext;
    if (context != null && context.mounted) {
      context.showCustomDialog(
        barrierDismissible: false,
        child: AlertDialog(
          title: const Text(AppStrings.noInternetConnection),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wifi_off,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(AppStrings.networkError),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                context.pop();
                await _checkConnectivity();
                if (!isConnected) {
                  _showNoInternetDialog();
                }
              },
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
    }
  }

  // ============= REQUEST METHODS =============

  // GET request
  Future<ApiResponse<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool showLoading = true,
    bool requireAuth = true,
    bool cache = false,
    Duration? cacheDuration,
    String? cancelToken,
  }) async {
    return _performRequest<T>(
      request: () => _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: {
            'requireAuth': requireAuth,
            'cache': cache,
            'cacheDuration': cacheDuration,
          },
        ),
        cancelToken: _getCancelToken(cancelToken),
      ),
      method: 'GET',
      path: path,
      showLoading: showLoading,
    );
  }

  // POST request
  Future<ApiResponse<T>> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool showLoading = true,
    bool requireAuth = true,
    String? cancelToken,
    void Function(int, int)? onSendProgress,
  }) async {
    return _performRequest<T>(
      request: () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: {'requireAuth': requireAuth},
        ),
        cancelToken: _getCancelToken(cancelToken),
        onSendProgress: onSendProgress,
      ),
      method: 'POST',
      path: path,
      showLoading: showLoading,
    );
  }

  // PUT request
  Future<ApiResponse<T>> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool showLoading = true,
    bool requireAuth = true,
    String? cancelToken,
  }) async {
    return _performRequest<T>(
      request: () => _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: {'requireAuth': requireAuth},
        ),
        cancelToken: _getCancelToken(cancelToken),
      ),
      method: 'PUT',
      path: path,
      showLoading: showLoading,
    );
  }

  // DELETE request
  Future<ApiResponse<T>> delete<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool showLoading = true,
    bool requireAuth = true,
    String? cancelToken,
  }) async {
    return _performRequest<T>(
      request: () => _dio.delete(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: {'requireAuth': requireAuth},
        ),
        cancelToken: _getCancelToken(cancelToken),
      ),
      method: 'DELETE',
      path: path,
      showLoading: showLoading,
    );
  }

  // PATCH request
  Future<ApiResponse<T>> patch<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool showLoading = true,
    bool requireAuth = true,
    String? cancelToken,
  }) async {
    return _performRequest<T>(
      request: () => _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: {'requireAuth': requireAuth},
        ),
        cancelToken: _getCancelToken(cancelToken),
      ),
      method: 'PATCH',
      path: path,
      showLoading: showLoading,
    );
  }

  // Upload file
  Future<ApiResponse<T>> uploadFile<T>({
    required String path,
    required File file,
    Map<String, dynamic>? data,
    String fileKey = 'file',
    bool showLoading = true,
    bool requireAuth = true,
    void Function(int, int)? onSendProgress,
    String? cancelToken,
  }) async {
    final formData = FormData.fromMap({
      ...?data,
      fileKey: await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    return post<T>(
      path: path,
      data: formData,
      showLoading: showLoading,
      requireAuth: requireAuth,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }

  // Download file
  Future<ApiResponse<File>> downloadFile({
    required String path,
    required String savePath,
    Map<String, dynamic>? queryParameters,
    bool showLoading = true,
    bool requireAuth = true,
    void Function(int, int)? onReceiveProgress,
    String? cancelToken,
  }) async {
    return _performRequest<File>(
      request: () async {
        await _dio.download(
          path,
          savePath,
          queryParameters: queryParameters,
          options: Options(
            extra: {'requireAuth': requireAuth},
          ),
          onReceiveProgress: onReceiveProgress,
          cancelToken: _getCancelToken(cancelToken),
        );
        return Response(
          requestOptions: RequestOptions(path: path),
          data: File(savePath),
        );
      },
      method: 'DOWNLOAD',
      path: path,
      showLoading: showLoading,
    );
  }

  // ============= PRIVATE METHODS =============

  // Perform request with loading and error handling
  Future<ApiResponse<T>> _performRequest<T>({
    required Future<Response> Function() request,
    required String method,
    required String path,
    bool showLoading = true,
  }) async {
    // Check connectivity
    if (!isConnected) {
      return ApiResponse<T>.noInternet();
    }

    // Show loading
    if (showLoading) {
      _showLoadingDialog();
    }

    // Update API call status
    _apiCallController.add(ApiCallStatus.loading);

    try {
      final response = await request();

      // Hide loading
      if (showLoading) {
        _hideLoadingDialog();
      }

      // Update API call status
      _apiCallController.add(ApiCallStatus.success);

      return _processResponse<T>(response);
    } on DioException catch (e) {
      // Hide loading
      if (showLoading) {
        _hideLoadingDialog();
      }

      // Update API call status
      _apiCallController.add(ApiCallStatus.error);

      return _handleDioError<T>(e);
    } catch (e) {
      // Hide loading
      if (showLoading) {
        _hideLoadingDialog();
      }

      // Update API call status
      _apiCallController.add(ApiCallStatus.error);

      Console.printError('Unexpected error: $e');
      return ApiResponse<T>.error(
        message: AppStrings.somethingWentWrong,
        error: e,
      );
    }
  }

  // Process response (Fixed: safe type casting)
  ApiResponse<T> _processResponse<T>(Response response) {
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        String? message;

        if (responseData is Map<String, dynamic>) {
          message = responseData['message'] as String?;
        }

        return ApiResponse<T>.success(
          data: response.data as T?,
          message: message ?? AppStrings.success,
        );
      } else {
        String? errorMessage;
        if (response.data is Map<String, dynamic>) {
          errorMessage = response.data['message'] as String?;
        }

        return ApiResponse<T>.error(
          statusCode: response.statusCode,
          message: errorMessage ?? AppStrings.error,
          error: response.data,
        );
      }
    } catch (e) {
      Console.printError('Response processing error: $e');
      return ApiResponse<T>.error(
        message: AppStrings.somethingWentWrong,
        error: e,
      );
    }
  }

  // Handle Dio error
  ApiResponse<T> _handleDioError<T>(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiResponse<T>.timeout();

      case DioExceptionType.badResponse:
        return _handleBadResponse<T>(error.response);

      case DioExceptionType.cancel:
        return ApiResponse<T>.cancelled();

      case DioExceptionType.connectionError:
        return ApiResponse<T>.noInternet();

      default:
        return ApiResponse<T>.error(
          message: error.message ?? AppStrings.unknownError,
          error: error,
        );
    }
  }

  // Handle bad response (Fixed: safe type casting)
  ApiResponse<T> _handleBadResponse<T>(Response? response) {
    if (response == null) {
      return ApiResponse<T>.error(message: AppStrings.noData);
    }

    String? errorMessage;
    if (response.data is Map<String, dynamic>) {
      errorMessage = response.data['message'] as String?;
    }

    switch (response.statusCode) {
      case 400:
        return ApiResponse<T>.badRequest(
          message: errorMessage ?? AppStrings.invalidInput,
        );
      case 401:
        _handleUnauthorized();
        return ApiResponse<T>.unauthorized();
      case 403:
        return ApiResponse<T>.forbidden();
      case 404:
        return ApiResponse<T>.notFound();
      case 500:
      case 502:
      case 503:
        return ApiResponse<T>.serverError();
      default:
        return ApiResponse<T>.error(
          statusCode: response.statusCode,
          message: errorMessage ?? AppStrings.unknownError,
        );
    }
  }

  // Handle unauthorized (Fixed: navigate to login screen properly)
  void _handleUnauthorized() {
    // Clear user data
    StorageService.instance.clearUserData();

    // Navigate to login
    final context = navigatorKey.currentContext;
    if (context != null && context.mounted) {
      // Navigate to login route
      context.pushNamedAndRemoveUntil('/login');
    }
  }

  // Show loading dialog (Fixed: using proper widget)
  void _showLoadingDialog() {
    final context = navigatorKey.currentContext;
    if (context != null && context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: Center(
            child: LoadingWidget(),
          ),
        ),
      );
    }
  }

  // Hide loading dialog
  void _hideLoadingDialog() {
    final context = navigatorKey.currentContext;
    if (context != null && context.mounted && Navigator.canPop(context)) {
      context.pop();
    }
  }

  // Get cancel token
  CancelToken _getCancelToken(String? key) {
    if (key != null) {
      _cancelTokens[key] ??= CancelToken();
      return _cancelTokens[key]!;
    }
    return CancelToken();
  }

  // Cancel request
  void cancelRequest(String key) {
    _cancelTokens[key]?.cancel('Request cancelled');
    _cancelTokens.remove(key);
  }

  // Cancel all requests
  void cancelAllRequests() {
    for (final token in _cancelTokens.values) {
      token.cancel('All requests cancelled');
    }
    _cancelTokens.clear();
  }

  // Dispose
  void dispose() {
    _connectivitySubscription?.cancel();
    _networkStatusController.close();
    _apiCallController.close();
    cancelAllRequests();
  }
}

// ============= INTERCEPTORS =============

// Auth Interceptor (Fixed: proper type checking)
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final requireAuth = (options.extra['requireAuth'] as bool?) ?? true;

    if (requireAuth) {
      final token = await StorageService.instance.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    super.onRequest(options, handler);
  }
}

// Logging Interceptor
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Console.printInfo('🌐 ${options.method} ${options.uri}');
    Console.printDebug('Headers: ${options.headers}');
    Console.printDebug('Data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Console.printSuccess('✅ [${response.statusCode}] ${response.requestOptions.uri}');
    Console.printDebug('Response: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Console.printError('❌ [${err.response?.statusCode}] ${err.requestOptions.uri}');
    Console.printError('Error: ${err.message}');
    super.onError(err, handler);
  }
}

// Error Interceptor
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log error to crash reporting
    AppLogger.error('API Error', err, err.stackTrace);
    super.onError(err, handler);
  }
}

// Retry Interceptor (Fixed: type casting)
class _RetryInterceptor extends Interceptor {
  final int maxRetries = 3;
  final Duration retryDelay = const Duration(seconds: 1);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = (err.requestOptions.extra['retryCount'] as int?) ?? 0;

    if (_shouldRetry(err) && retryCount < maxRetries) {
      err.requestOptions.extra['retryCount'] = retryCount + 1;

      Console.printWarning('Retrying request (${retryCount + 1}/$maxRetries)');

      await Future.delayed(retryDelay * (retryCount + 1));

      try {
        final response = await DioService.instance._dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } catch (e) {
        handler.next(err);
        return;
      }
    }

    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        (err.response?.statusCode ?? 0) >= 500;
  }
}

// Cache Interceptor (Fixed: async operations and type casting)
class _CacheInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final cache = (options.extra['cache'] as bool?) ?? false;

    if (cache && options.method == 'GET') {
      final cacheKey = _getCacheKey(options);
      final cachedData = await StorageService.instance.getFromCache(cacheKey);

      if (cachedData != null) {
        Console.printInfo('📦 Using cached response for ${options.uri}');
        handler.resolve(
          Response(
            requestOptions: options,
            data: cachedData,
            statusCode: 200,
          ),
        );
        return;
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final cache = (response.requestOptions.extra['cache'] as bool?) ?? false;
    final cacheDuration = response.requestOptions.extra['cacheDuration'] as Duration?;

    if (cache && response.requestOptions.method == 'GET' && response.statusCode == 200) {
      final cacheKey = _getCacheKey(response.requestOptions);
      await StorageService.instance.saveToCache(
        key: cacheKey,
        value: response.data,
        expiry: cacheDuration ?? const Duration(minutes: 5),
      );
      Console.printInfo('📦 Cached response for ${response.requestOptions.uri}');
    }

    super.onResponse(response, handler);
  }

  String _getCacheKey(RequestOptions options) {
    final uri = options.uri.toString();
    final params = jsonEncode(options.queryParameters);
    return '$uri$params';
  }
}

// ============= MODELS (unchanged) =============

enum NetworkStatus {
  connected,
  disconnected,
  wifi,
  mobile,
  unknown,
}

enum ApiCallStatus {
  idle,
  loading,
  success,
  error,
}

class ApiResponse<T> {
  final bool success;
  final int? statusCode;
  final String? message;
  final T? data;
  final dynamic error;

  ApiResponse({
    required this.success,
    this.statusCode,
    this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.success({
    T? data,
    String? message,
  }) {
    return ApiResponse<T>(
      success: true,
      statusCode: 200,
      message: message,
      data: data,
    );
  }

  factory ApiResponse.error({
    int? statusCode,
    String? message,
    dynamic error,
  }) {
    return ApiResponse<T>(
      success: false,
      statusCode: statusCode,
      message: message,
      error: error,
    );
  }

  factory ApiResponse.noInternet() {
    return ApiResponse<T>(
      success: false,
      statusCode: 503,
      message: AppStrings.noInternetConnection,
    );
  }

  factory ApiResponse.timeout() {
    return ApiResponse<T>(
      success: false,
      statusCode: 408,
      message: AppStrings.timeoutError,
    );
  }

  factory ApiResponse.cancelled() {
    return ApiResponse<T>(
      success: false,
      statusCode: 499,
      message: 'Request cancelled',
    );
  }

  factory ApiResponse.unauthorized() {
    return ApiResponse<T>(
      success: false,
      statusCode: 401,
      message: AppStrings.sessionExpired,
    );
  }

  factory ApiResponse.forbidden() {
    return ApiResponse<T>(
      success: false,
      statusCode: 403,
      message: AppStrings.accessDenied,
    );
  }

  factory ApiResponse.notFound() {
    return ApiResponse<T>(
      success: false,
      statusCode: 404,
      message: AppStrings.dataNotFound,
    );
  }

  factory ApiResponse.badRequest({String? message}) {
    return ApiResponse<T>(
      success: false,
      statusCode: 400,
      message: message ?? AppStrings.invalidInput,
    );
  }

  factory ApiResponse.serverError() {
    return ApiResponse<T>(
      success: false,
      statusCode: 500,
      message: AppStrings.serverError,
    );
  }

  bool get hasData => data != null;
  bool get hasError => !success;

  ApiResponse<R> map<R>(R Function(T?) mapper) {
    return ApiResponse<R>(
      success: success,
      statusCode: statusCode,
      message: message,
      data: mapper(data),
      error: error,
    );
  }

  R when<R>({
    required R Function(T? data) success,
    required R Function(String? message, dynamic error) error,
  }) {
    if (this.success) {
      return success(data);
    } else {
      return error(message, this.error);
    }
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();