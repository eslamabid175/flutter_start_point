// import 'dart:async';
// import 'dart:io';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:rxdart/subjects.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import '../utils/debug_utils.dart';
//
// // Background message handler (must be top-level function)
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   Console.printInfo('📬 Background message: ${message.messageId}');
//   // Handle background message
//   await NotificationService.instance.showNotificationFromRemoteMessage(message);
// }
//
// class NotificationService {
//   // Singleton pattern
//   NotificationService._internal();
//   static final NotificationService _instance = NotificationService._internal();
//   static NotificationService get instance => _instance;
//   factory NotificationService() => _instance;
//
//   // Notification plugin
//   final FlutterLocalNotificationsPlugin _localNotifications =
//   FlutterLocalNotificationsPlugin();
//
//   // Stream controllers
//   final BehaviorSubject<NotificationPayload?> _notificationClickSubject =
//   BehaviorSubject<NotificationPayload?>();
//   final StreamController<RemoteMessage> _fcmMessageController =
//   StreamController<RemoteMessage>.broadcast();
//
//   // Streams
//   Stream<NotificationPayload?> get notificationClickStream =>
//       _notificationClickSubject.stream;
//   Stream<RemoteMessage> get fcmMessageStream => _fcmMessageController.stream;
//
//   // Notification channels
//   static const String _defaultChannelId = 'default_channel';
//   static const String _defaultChannelName = 'Default Notifications';
//   static const String _defaultChannelDescription =
//       'Default notification channel';
//
//   static const String _highChannelId = 'high_importance_channel';
//   static const String _highChannelName = 'Important Notifications';
//   static const String _highChannelDescription = 'High priority notifications';
//
//   static const String _messageChannelId = 'message_channel';
//   static const String _messageChannelName = 'Messages';
//   static const String _messageChannelDescription = 'Message notifications';
//
//   // Notification IDs
//   int _notificationId = 0;
//   final Map<String, int> _notificationIds = {};
//
//   // Initialize notification service
//   Future<void> initialize() async {
//     try {
//       Console.printInfo('🔔 Initializing Notification Service...');
//
//       // Initialize timezone
//       tz.initializeTimeZones();
//
//       // Android initialization
//       const androidSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//
//       // iOS initialization (Fixed: removed deprecated parameter)
//       const iosSettings = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//       );
//
//       // Initialize plugin
//       const initSettings = InitializationSettings(
//         android: androidSettings,
//         iOS: iosSettings,
//       );
//
//       await _localNotifications.initialize(
//         initSettings,
//         onDidReceiveNotificationResponse: _onNotificationResponse,
//         onDidReceiveBackgroundNotificationResponse:
//         _onBackgroundNotificationResponse,
//       );
//
//       // Create notification channels
//       await _createNotificationChannels();
//
//       // Setup Firebase Messaging
//       await _setupFirebaseMessaging();
//
//       // Request permissions
//       await requestPermissions();
//
//       Console.printSuccess('✅ Notification Service initialized');
//     } catch (e) {
//       Console.printError('❌ Notification Service initialization failed: $e');
//     }
//   }
//
//   // Create notification channels (Android)
//   Future<void> _createNotificationChannels() async {
//     if (Platform.isAndroid) {
//       // Default channel
//       const defaultChannel = AndroidNotificationChannel(
//         _defaultChannelId,
//         _defaultChannelName,
//         description: _defaultChannelDescription,
//         importance: Importance.defaultImportance,
//         enableVibration: true,
//         playSound: true,
//       );
//
//       // High importance channel
//       const highChannel = AndroidNotificationChannel(
//         _highChannelId,
//         _highChannelName,
//         description: _highChannelDescription,
//         importance: Importance.high,
//         enableVibration: true,
//         playSound: true,
//         enableLights: true,
//       );
//
//       // Message channel
//       const messageChannel = AndroidNotificationChannel(
//         _messageChannelId,
//         _messageChannelName,
//         description: _messageChannelDescription,
//         importance: Importance.high,
//         enableVibration: true,
//         playSound: true,
//         enableLights: true,
//       );
//
//       await _localNotifications
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(defaultChannel);
//
//       await _localNotifications
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(highChannel);
//
//       await _localNotifications
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(messageChannel);
//     }
//   }
//
//   // Setup Firebase Messaging
//   Future<void> _setupFirebaseMessaging() async {
//     // Set background message handler
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       Console.printInfo('📬 Foreground message: ${message.messageId}');
//       _fcmMessageController.add(message);
//       showNotificationFromRemoteMessage(message);
//     });
//
//     // Handle notification opens
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       Console.printInfo('📬 Message opened app: ${message.messageId}');
//       _handleNotificationClick(NotificationPayload.fromRemoteMessage(message));
//     });
//
//     // Check for initial message
//     final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage != null) {
//       Console.printInfo('📬 Initial message: ${initialMessage.messageId}');
//       _handleNotificationClick(
//           NotificationPayload.fromRemoteMessage(initialMessage));
//     }
//   }
//
//   // Request permissions
//   Future<bool> requestPermissions() async {
//     if (Platform.isIOS) {
//       final result = await _localNotifications
//           .resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       return result ?? false;
//     } else if (Platform.isAndroid) {
//       final androidImplementation = _localNotifications
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>();
//
//       if (androidImplementation != null) {
//         final result =
//         await androidImplementation.requestNotificationsPermission();
//         return result ?? false;
//       }
//     }
//     return true;
//   }
//
//   // ============= SHOW NOTIFICATIONS =============
//
//   // Show simple notification
//   Future<void> showNotification({
//     String? title,
//     String? body,
//     String? payload,
//     String? channelId,
//     NotificationImportance importance = NotificationImportance.defaultImportance,
//   }) async {
//     final id = _getNextNotificationId();
//
//     final androidDetails = AndroidNotificationDetails(
//       channelId ?? _defaultChannelId,
//       channelId ?? _defaultChannelName,
//       channelDescription: _defaultChannelDescription,
//       importance: _mapImportance(importance),
//       priority: _mapPriority(importance),
//       ticker: title,
//       playSound: true,
//       enableVibration: true,
//       enableLights: true,
//     );
//
//     const iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     final details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _localNotifications.show(
//       id,
//       title,
//       body,
//       details,
//       payload: payload,
//     );
//   }
//
//   // Show notification with image
//   Future<void> showImageNotification({
//     String? title,
//     String? body,
//     required String imageUrl,
//     String? payload,
//     String? channelId,
//     NotificationImportance importance = NotificationImportance.defaultImportance,
//   }) async {
//     final id = _getNextNotificationId();
//
//     // Download and save image
//     final imagePath = await _downloadAndSaveImage(imageUrl, 'notification_$id');
//
//     final androidDetails = AndroidNotificationDetails(
//       channelId ?? _defaultChannelId,
//       channelId ?? _defaultChannelName,
//       channelDescription: _defaultChannelDescription,
//       importance: _mapImportance(importance),
//       priority: _mapPriority(importance),
//       ticker: title,
//       playSound: true,
//       enableVibration: true,
//       enableLights: true,
//       styleInformation: imagePath != null
//           ? BigPictureStyleInformation(
//         FilePathAndroidBitmap(imagePath),
//         contentTitle: title,
//         summaryText: body,
//         hideExpandedLargeIcon: false,
//       )
//           : null,
//     );
//
//     final iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//       attachments: imagePath != null
//           ? [DarwinNotificationAttachment(imagePath)]
//           : null,
//     );
//
//     final details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _localNotifications.show(
//       id,
//       title,
//       body,
//       details,
//       payload: payload,
//     );
//   }
//
//   // Show progress notification
//   Future<void> showProgressNotification({
//     required int id,
//     required String title,
//     required String body,
//     required int progress,
//     int maxProgress = 100,
//     bool indeterminate = false,
//     String? channelId,
//   }) async {
//     final androidDetails = AndroidNotificationDetails(
//       channelId ?? _defaultChannelId,
//       channelId ?? _defaultChannelName,
//       channelDescription: _defaultChannelDescription,
//       importance: Importance.low,
//       priority: Priority.low,
//       onlyAlertOnce: true,
//       showProgress: true,
//       maxProgress: maxProgress,
//       progress: progress,
//       indeterminate: indeterminate,
//     );
//
//     const iosDetails = DarwinNotificationDetails(
//       presentAlert: false,
//       presentBadge: false,
//       presentSound: false,
//     );
//
//     final details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _localNotifications.show(
//       id,
//       title,
//       body,
//       details,
//     );
//   }
//
//   // Show grouped notifications
//   Future<void> showGroupedNotification({
//     required String groupKey,
//     required String title,
//     required String body,
//     String? payload,
//     String? channelId,
//   }) async {
//     final id = _getGroupNotificationId(groupKey);
//
//     final androidDetails = AndroidNotificationDetails(
//       channelId ?? _defaultChannelId,
//       channelId ?? _defaultChannelName,
//       channelDescription: _defaultChannelDescription,
//       importance: Importance.high,
//       priority: Priority.high,
//       groupKey: groupKey,
//       setAsGroupSummary: false,
//     );
//
//     const iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//       threadIdentifier: 'grouped',
//     );
//
//     final details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _localNotifications.show(
//       id,
//       title,
//       body,
//       details,
//       payload: payload,
//     );
//
//     // Show group summary
//     await _showGroupSummary(groupKey, channelId);
//   }
//
//   // Show group summary
//   Future<void> _showGroupSummary(String groupKey, String? channelId) async {
//     final androidDetails = AndroidNotificationDetails(
//       channelId ?? _defaultChannelId,
//       channelId ?? _defaultChannelName,
//       channelDescription: _defaultChannelDescription,
//       importance: Importance.high,
//       priority: Priority.high,
//       groupKey: groupKey,
//       setAsGroupSummary: true,
//     );
//
//     const iosDetails = DarwinNotificationDetails(
//       presentAlert: false,
//       presentBadge: true,
//       presentSound: false,
//     );
//
//     final details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _localNotifications.show(
//       0, // Use 0 for summary
//       'Messages',
//       'You have new messages',
//       details,
//     );
//   }
//
//   // Show notification with actions
//   Future<void> showActionNotification({
//     String? title,
//     String? body,
//     required List<NotificationAction> actions,
//     String? payload,
//     String? channelId,
//   }) async {
//     final id = _getNextNotificationId();
//
//     final androidActions = actions.map((action) {
//       return AndroidNotificationAction(
//         action.id,
//         action.title,
//         showsUserInterface: action.showsUserInterface,
//         contextual: action.contextual,
//       );
//     }).toList();
//
//     final androidDetails = AndroidNotificationDetails(
//       channelId ?? _defaultChannelId,
//       channelId ?? _defaultChannelName,
//       channelDescription: _defaultChannelDescription,
//       importance: Importance.high,
//       priority: Priority.high,
//       actions: androidActions,
//     );
//
//     final iosActions = actions.map((action) {
//       return DarwinNotificationAction.plain(
//         action.id,
//         action.title,
//         options: action.destructive
//             ? {DarwinNotificationActionOption.destructive}
//             : {},
//       );
//     }).toList();
//
//     const iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//       categoryIdentifier: 'actionCategory',
//     );
//
//     // Register iOS category
//     if (Platform.isIOS) {
//       await _localNotifications
//           .resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin>()
//           ?.initialize(
//         DarwinInitializationSettings(
//           notificationCategories: [
//             DarwinNotificationCategory(
//               'actionCategory',
//               actions: iosActions,
//             ),
//           ],
//         ),
//       );
//     }
//
//     final details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _localNotifications.show(
//       id,
//       title,
//       body,
//       details,
//       payload: payload,
//     );
//   }
//
//   // ============= SCHEDULED NOTIFICATIONS =============
//
//   // Schedule notification (Fixed: removed deprecated parameter)
//   Future<void> scheduleNotification({
//     required DateTime scheduledDate,
//     String? title,
//     String? body,
//     String? payload,
//     String? channelId,
//   }) async {
//     final id = _getNextNotificationId();
//
//     final androidDetails = AndroidNotificationDetails(
//       channelId ?? _defaultChannelId,
//       channelId ?? _defaultChannelName,
//       channelDescription: _defaultChannelDescription,
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//
//     const iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     final details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _localNotifications.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledDate, tz.local),
//       details,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       payload: payload,
//     );
//   }
//
//   // Schedule repeating notification
//   Future<void> scheduleRepeatingNotification({
//     required RepeatInterval interval,
//     String? title,
//     String? body,
//     String? payload,
//     String? channelId,
//   }) async {
//     final id = _getNextNotificationId();
//
//     final androidDetails = AndroidNotificationDetails(
//       channelId ?? _defaultChannelId,
//       channelId ?? _defaultChannelName,
//       channelDescription: _defaultChannelDescription,
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//
//     const iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     final details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _localNotifications.periodicallyShow(
//       id,
//       title,
//       body,
//       interval,
//       details,
//       payload: payload,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );
//   }
//
//   // Schedule daily notification at specific time (Updated approach)
//   Future<void> scheduleDailyNotification({
//     required TimeOfDay time,
//     String? title,
//     String? body,
//     String? payload,
//     String? channelId,
//   }) async {
//     final now = DateTime.now();
//     var scheduledDate = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//
//     // If the time has passed today, schedule for tomorrow
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//
//     // Schedule the notification
//     await scheduleNotification(
//       scheduledDate: scheduledDate,
//       title: title,
//       body: body,
//       payload: payload,
//       channelId: channelId,
//     );
//   }
//
//   // Schedule weekly notification at specific day and time (Updated approach)
//   Future<void> scheduleWeeklyNotification({
//     required int weekday, // 1 = Monday, 7 = Sunday
//     required TimeOfDay time,
//     String? title,
//     String? body,
//     String? payload,
//     String? channelId,
//   }) async {
//     final now = DateTime.now();
//     var scheduledDate = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//
//     // Find the next occurrence of the specified weekday
//     while (scheduledDate.weekday != weekday) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//
//     // If the time has passed this week, schedule for next week
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 7));
//     }
//
//     // Schedule the notification
//     await scheduleNotification(
//       scheduledDate: scheduledDate,
//       title: title,
//       body: body,
//       payload: payload,
//       channelId: channelId,
//     );
//   }
//
//   // ============= FIREBASE MESSAGING =============
//
//   // Show notification from RemoteMessage (Fixed: proper type casting)
//   Future<void> showNotificationFromRemoteMessage(RemoteMessage message) async {
//     final notification = message.notification;
//     final data = message.data;
//
//     if (notification != null) {
//       String? imageUrl;
//
//       // Get image URL from notification or data
//       if (notification.android?.imageUrl != null) {
//         imageUrl = notification.android!.imageUrl;
//       } else if (notification.apple?.imageUrl != null) {
//         imageUrl = notification.apple!.imageUrl;
//       } else if (data['image'] != null) {
//         imageUrl = data['image'] as String;
//       }
//
//       // Fixed: proper type casting for channelId
//       final channelId = data['channel_id'] as String?;
//
//       if (imageUrl != null) {
//         await showImageNotification(
//           title: notification.title,
//           body: notification.body,
//           imageUrl: imageUrl,
//           payload: jsonEncode(data),
//           channelId: channelId,
//           importance: _getImportanceFromData(data),
//         );
//       } else {
//         await showNotification(
//           title: notification.title,
//           body: notification.body,
//           payload: jsonEncode(data),
//           channelId: channelId,
//           importance: _getImportanceFromData(data),
//         );
//       }
//     }
//   }
//
//   // ============= MANAGEMENT METHODS =============
//
//   // Cancel notification
//   Future<void> cancelNotification(int id) async {
//     await _localNotifications.cancel(id);
//   }
//
//   // Cancel all notifications
//   Future<void> cancelAllNotifications() async {
//     await _localNotifications.cancelAll();
//   }
//
//   // Get pending notifications
//   Future<List<PendingNotificationRequest>> getPendingNotifications() async {
//     return await _localNotifications.pendingNotificationRequests();
//   }
//
//   // Get active notifications (Android only)
//   Future<List<ActiveNotification>> getActiveNotifications() async {
//     if (Platform.isAndroid) {
//       final androidImplementation = _localNotifications
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>();
//
//       if (androidImplementation != null) {
//         return await androidImplementation.getActiveNotifications();
//       }
//     }
//     return [];
//   }
//
//   // Update badge count (iOS)
//   Future<void> updateBadgeCount(int count) async {
//     if (Platform.isIOS) {
//       await _localNotifications
//           .resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(badge: true);
//     }
//   }
//
//   // ============= PRIVATE METHODS =============
//
//   // Get next notification ID
//   int _getNextNotificationId() {
//     return ++_notificationId;
//   }
//
//   // Get group notification ID
//   int _getGroupNotificationId(String groupKey) {
//     if (!_notificationIds.containsKey(groupKey)) {
//       _notificationIds[groupKey] = _getNextNotificationId();
//     }
//     return _notificationIds[groupKey]!;
//   }
//
//   // Download and save image
//   Future<String?> _downloadAndSaveImage(String url, String fileName) async {
//     try {
//       final directory = await getTemporaryDirectory();
//       final filePath = '${directory.path}/$fileName.png';
//
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//         return filePath;
//       }
//     } catch (e) {
//       Console.printError('Failed to download image: $e');
//     }
//     return null;
//   }
//
//   // Map importance
//   Importance _mapImportance(NotificationImportance importance) {
//     switch (importance) {
//       case NotificationImportance.min:
//         return Importance.min;
//       case NotificationImportance.low:
//         return Importance.low;
//       case NotificationImportance.defaultImportance:
//         return Importance.defaultImportance;
//       case NotificationImportance.high:
//         return Importance.high;
//       case NotificationImportance.max:
//         return Importance.max;
//     }
//   }
//
//   // Map priority
//   Priority _mapPriority(NotificationImportance importance) {
//     switch (importance) {
//       case NotificationImportance.min:
//         return Priority.min;
//       case NotificationImportance.low:
//         return Priority.low;
//       case NotificationImportance.defaultImportance:
//         return Priority.defaultPriority;
//       case NotificationImportance.high:
//         return Priority.high;
//       case NotificationImportance.max:
//         return Priority.max;
//     }
//   }
//
//   // Get importance from data (Fixed: proper type casting)
//   NotificationImportance _getImportanceFromData(Map<String, dynamic> data) {
//     final priority = (data['priority'] ?? 'default') as String;
//     switch (priority) {
//       case 'min':
//         return NotificationImportance.min;
//       case 'low':
//         return NotificationImportance.low;
//       case 'high':
//         return NotificationImportance.high;
//       case 'max':
//         return NotificationImportance.max;
//       default:
//         return NotificationImportance.defaultImportance;
//     }
//   }
//
//   // Handle notification click
//   void _handleNotificationClick(NotificationPayload payload) {
//     _notificationClickSubject.add(payload);
//   }
//
//   // Notification response callback
//   void _onNotificationResponse(NotificationResponse response) {
//     _handleNotificationClick(NotificationPayload(
//       id: response.id ?? 0,
//       payload: response.payload,
//       actionId: response.actionId,
//     ));
//   }
//
//   // Background notification response callback
//   @pragma('vm:entry-point')
//   static void _onBackgroundNotificationResponse(
//       NotificationResponse response) {
//     Console.printInfo('Background notification response: ${response.id}');
//   }
//
//   // Cleanup
//   void dispose() {
//     _notificationClickSubject.close();
//     _fcmMessageController.close();
//   }
// }
//
// // Notification Models
// enum NotificationImportance {
//   min,
//   low,
//   defaultImportance,
//   high,
//   max,
// }
//
// class NotificationPayload {
//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
//   final String? actionId;
//   final Map<String, dynamic>? data;
//
//   NotificationPayload({
//     required this.id,
//     this.title,
//     this.body,
//     this.payload,
//     this.actionId,
//     this.data,
//   });
//
//   factory NotificationPayload.fromRemoteMessage(RemoteMessage message) {
//     return NotificationPayload(
//       id: message.hashCode,
//       title: message.notification?.title,
//       body: message.notification?.body,
//       payload: jsonEncode(message.data),
//       data: message.data,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'body': body,
//       'payload': payload,
//       'actionId': actionId,
//       'data': data,
//     };
//   }
// }
//
// class NotificationAction {
//   final String id;
//   final String title;
//   final bool showsUserInterface;
//   final bool contextual;
//   final bool destructive;
//
//   NotificationAction({
//     required this.id,
//     required this.title,
//     this.showsUserInterface = true,
//     this.contextual = false,
//     this.destructive = false,
//   });
// }