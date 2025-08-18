// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data'; // Added for Uint8List
// import 'package:flutter/foundation.dart'; // Added for kIsWeb
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import '../utils/debug_utils.dart';
//
// class FirebaseService {
//   // Singleton pattern
//   FirebaseService._internal();
//   static final FirebaseService _instance = FirebaseService._internal();
//   static FirebaseService get instance => _instance;
//   factory FirebaseService() => _instance;
//
//   // Firebase instances
//   late final FirebaseAuth _auth;
//   late final FirebaseFirestore _firestore;
//   late final FirebaseStorage _storage;
//   late final FirebaseMessaging _messaging;
//   late final FirebaseAnalytics _analytics;
//   late final FirebaseCrashlytics _crashlytics;
//   late final FirebaseRemoteConfig _remoteConfig;
//   late final GoogleSignIn _googleSignIn;
//
//   // Stream controllers
//   final StreamController<User?> _authStateController = StreamController<User?>.broadcast();
//   final StreamController<String?> _fcmTokenController = StreamController<String?>.broadcast();
//
//   // Getters
//   FirebaseAuth get auth => _auth;
//   FirebaseFirestore get firestore => _firestore;
//   FirebaseStorage get storage => _storage;
//   FirebaseMessaging get messaging => _messaging;
//   FirebaseAnalytics get analytics => _analytics;
//   FirebaseCrashlytics get crashlytics => _crashlytics;
//   FirebaseRemoteConfig get remoteConfig => _remoteConfig;
//
//   Stream<User?> get authStateChanges => _authStateController.stream;
//   Stream<String?> get fcmTokenStream => _fcmTokenController.stream;
//   User? get currentUser => _auth.currentUser;
//   bool get isAuthenticated => currentUser != null;
//   String? get userId => currentUser?.uid;
//
//   // Initialize Firebase
//   Future<void> initialize() async {
//     try {
//       Console.printInfo('🔥 Initializing Firebase...');
//
//       await Firebase.initializeApp();
//
//       _auth = FirebaseAuth.instance;
//       _firestore = FirebaseFirestore.instance;
//       _storage = FirebaseStorage.instance;
//       _messaging = FirebaseMessaging.instance;
//       _analytics = FirebaseAnalytics.instance;
//       _crashlytics = FirebaseCrashlytics.instance;
//       _remoteConfig = FirebaseRemoteConfig.instance;
//
//       // Fixed: GoogleSignIn initialization with proper constructor
//       _googleSignIn = GoogleSignIn(
//         scopes: [
//           'email',
//           'https://www.googleapis.com/auth/userinfo.profile',
//         ],
//       );
//
//       // Setup listeners
//       _setupAuthListener();
//       await _setupMessaging();
//       await _setupRemoteConfig();
//       await _setupCrashlytics();
//
//       Console.printSuccess('✅ Firebase initialized successfully');
//     } catch (e, stack) {
//       Console.printError('❌ Firebase initialization failed: $e');
//       AppLogger.error('Firebase initialization error', e, stack);
//     }
//   }
//
//   // ============= AUTH METHODS =============
//
//   // Email/Password Sign In
//   Future<AuthResult> signInWithEmail({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final credential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       await _postAuthSuccess(credential.user);
//       return AuthResult.success(user: credential.user);
//     } on FirebaseAuthException catch (e) {
//       return _handleAuthException(e);
//     } catch (e) {
//       return AuthResult.error(message: 'An unexpected error occurred');
//     }
//   }
//
//   // Email/Password Sign Up
//   Future<AuthResult> signUpWithEmail({
//     required String email,
//     required String password,
//     String? displayName,
//   }) async {
//     try {
//       final credential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       if (displayName != null && credential.user != null) {
//         await credential.user!.updateDisplayName(displayName);
//       }
//
//       await _postAuthSuccess(credential.user);
//       return AuthResult.success(user: credential.user);
//     } on FirebaseAuthException catch (e) {
//       return _handleAuthException(e);
//     } catch (e) {
//       return AuthResult.error(message: 'An unexpected error occurred');
//     }
//   }
//
//   // Google Sign In (Fixed)
//   Future<AuthResult> signInWithGoogle() async {
//     try {
//       // Fixed: Using proper GoogleSignIn methods
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//
//       if (googleUser == null) {
//         return AuthResult.error(message: 'Google sign in cancelled');
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       // Fixed: Using proper accessToken and idToken properties
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       final userCredential = await _auth.signInWithCredential(credential);
//
//       await _postAuthSuccess(userCredential.user);
//       return AuthResult.success(user: userCredential.user);
//     } on FirebaseAuthException catch (e) {
//       return _handleAuthException(e);
//     } catch (e) {
//       Console.printError('Google sign in error: $e');
//       return AuthResult.error(message: 'Google sign in failed');
//     }
//   }
//
//   // Apple Sign In
//   Future<AuthResult> signInWithApple() async {
//     try {
//       // Check if Apple Sign In is available
//       if (!await SignInWithApple.isAvailable()) {
//         return AuthResult.error(message: 'Apple Sign In is not available on this device');
//       }
//
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//       );
//
//       final oauthCredential = OAuthProvider("apple.com").credential(
//         idToken: appleCredential.identityToken,
//         accessToken: appleCredential.authorizationCode,
//       );
//
//       final userCredential = await _auth.signInWithCredential(oauthCredential);
//
//       // Update display name if available
//       if (appleCredential.givenName != null && appleCredential.familyName != null) {
//         final displayName = '${appleCredential.givenName} ${appleCredential.familyName}';
//         await userCredential.user?.updateDisplayName(displayName);
//       }
//
//       await _postAuthSuccess(userCredential.user);
//       return AuthResult.success(user: userCredential.user);
//     } on FirebaseAuthException catch (e) {
//       return _handleAuthException(e);
//     } catch (e) {
//       return AuthResult.error(message: 'Apple sign in failed');
//     }
//   }
//
//   // Phone Authentication
//   Future<void> signInWithPhone({
//     required String phoneNumber,
//     required Function(String) onCodeSent,
//     required Function(AuthResult) onVerificationCompleted,
//     required Function(String) onError,
//   }) async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           final userCredential = await _auth.signInWithCredential(credential);
//           await _postAuthSuccess(userCredential.user);
//           onVerificationCompleted(AuthResult.success(user: userCredential.user));
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           onError(_getAuthErrorMessage(e.code));
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           onCodeSent(verificationId);
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           // Auto-retrieval timeout
//         },
//         timeout: const Duration(seconds: 60),
//       );
//     } catch (e) {
//       onError('Phone authentication failed');
//     }
//   }
//
//   // Verify Phone Code
//   Future<AuthResult> verifyPhoneCode({
//     required String verificationId,
//     required String smsCode,
//   }) async {
//     try {
//       final credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: smsCode,
//       );
//
//       final userCredential = await _auth.signInWithCredential(credential);
//       await _postAuthSuccess(userCredential.user);
//       return AuthResult.success(user: userCredential.user);
//     } on FirebaseAuthException catch (e) {
//       return _handleAuthException(e);
//     } catch (e) {
//       return AuthResult.error(message: 'Verification failed');
//     }
//   }
//
//   // Anonymous Sign In
//   Future<AuthResult> signInAnonymously() async {
//     try {
//       final userCredential = await _auth.signInAnonymously();
//       await _postAuthSuccess(userCredential.user);
//       return AuthResult.success(user: userCredential.user);
//     } on FirebaseAuthException catch (e) {
//       return _handleAuthException(e);
//     } catch (e) {
//       return AuthResult.error(message: 'Anonymous sign in failed');
//     }
//   }
//
//   // Password Reset
//   Future<bool> sendPasswordResetEmail(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//       return true;
//     } catch (e) {
//       Console.printError('Password reset failed: $e');
//       return false;
//     }
//   }
//
//   // Sign Out
//   Future<void> signOut() async {
//     try {
//       await _googleSignIn.signOut();
//       await _auth.signOut();
//       Console.printSuccess('User signed out');
//     } catch (e) {
//       Console.printError('Sign out failed: $e');
//     }
//   }
//
//   // Delete Account
//   Future<bool> deleteAccount() async {
//     try {
//       await currentUser?.delete();
//       return true;
//     } catch (e) {
//       Console.printError('Account deletion failed: $e');
//       return false;
//     }
//   }
//
//   // ============= FIRESTORE METHODS =============
//
//   // Create document
//   Future<String?> createDocument({
//     required String collection,
//     required Map<String, dynamic> data,
//     String? documentId,
//   }) async {
//     try {
//       data['createdAt'] = FieldValue.serverTimestamp();
//       data['updatedAt'] = FieldValue.serverTimestamp();
//
//       if (documentId != null) {
//         await _firestore.collection(collection).doc(documentId).set(data);
//         return documentId;
//       } else {
//         final doc = await _firestore.collection(collection).add(data);
//         return doc.id;
//       }
//     } catch (e) {
//       Console.printError('Create document failed: $e');
//       return null;
//     }
//   }
//
//   // Read document
//   Future<Map<String, dynamic>?> getDocument({
//     required String collection,
//     required String documentId,
//   }) async {
//     try {
//       final doc = await _firestore.collection(collection).doc(documentId).get();
//       if (doc.exists) {
//         return {'id': doc.id, ...?doc.data()};
//       }
//       return null;
//     } catch (e) {
//       Console.printError('Get document failed: $e');
//       return null;
//     }
//   }
//
//   // Update document
//   Future<bool> updateDocument({
//     required String collection,
//     required String documentId,
//     required Map<String, dynamic> data,
//   }) async {
//     try {
//       data['updatedAt'] = FieldValue.serverTimestamp();
//       await _firestore.collection(collection).doc(documentId).update(data);
//       return true;
//     } catch (e) {
//       Console.printError('Update document failed: $e');
//       return false;
//     }
//   }
//
//   // Delete document
//   Future<bool> deleteDocument({
//     required String collection,
//     required String documentId,
//   }) async {
//     try {
//       await _firestore.collection(collection).doc(documentId).delete();
//       return true;
//     } catch (e) {
//       Console.printError('Delete document failed: $e');
//       return false;
//     }
//   }
//
//   // Query documents
//   Future<List<Map<String, dynamic>>> queryDocuments({
//     required String collection,
//     Query Function(Query query)? queryBuilder,
//     int? limit,
//   }) async {
//     try {
//       Query query = _firestore.collection(collection);
//
//       if (queryBuilder != null) {
//         query = queryBuilder(query);
//       }
//
//       if (limit != null) {
//         query = query.limit(limit);
//       }
//
//       final snapshot = await query.get();
//       return snapshot.docs.map((doc) => {
//         'id': doc.id,
//         ...doc.data() as Map<String, dynamic>,
//       }).toList();
//     } catch (e) {
//       Console.printError('Query documents failed: $e');
//       return [];
//     }
//   }
//
//   // Real-time document listener
//   Stream<Map<String, dynamic>?> documentStream({
//     required String collection,
//     required String documentId,
//   }) {
//     return _firestore
//         .collection(collection)
//         .doc(documentId)
//         .snapshots()
//         .map((snapshot) {
//       if (snapshot.exists) {
//         return {'id': snapshot.id, ...?snapshot.data()};
//       }
//       return null;
//     });
//   }
//
//   // Real-time collection listener
//   Stream<List<Map<String, dynamic>>> collectionStream({
//     required String collection,
//     Query Function(Query query)? queryBuilder,
//   }) {
//     Query query = _firestore.collection(collection);
//
//     if (queryBuilder != null) {
//       query = queryBuilder(query);
//     }
//
//     return query.snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) => {
//         'id': doc.id,
//         ...doc.data() as Map<String, dynamic>,
//       }).toList();
//     });
//   }
//
//   // Batch operations
//   Future<bool> batchOperation(
//       Future<void> Function(WriteBatch batch) operations,
//       ) async {
//     try {
//       final batch = _firestore.batch();
//       await operations(batch);
//       await batch.commit();
//       return true;
//     } catch (e) {
//       Console.printError('Batch operation failed: $e');
//       return false;
//     }
//   }
//
//   // ============= STORAGE METHODS =============
//
//   // Upload file
//   Future<String?> uploadFile({
//     required File file,
//     required String path,
//     Function(double)? onProgress,
//   }) async {
//     try {
//       final ref = _storage.ref().child(path);
//       final uploadTask = ref.putFile(file);
//
//       if (onProgress != null) {
//         uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
//           final progress = snapshot.bytesTransferred / snapshot.totalBytes;
//           onProgress(progress);
//         });
//       }
//
//       final snapshot = await uploadTask;
//       final downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       Console.printError('File upload failed: $e');
//       return null;
//     }
//   }
//
//   // Upload bytes (Fixed: Added Uint8List import)
//   Future<String?> uploadBytes({
//     required Uint8List bytes,
//     required String path,
//     Map<String, String>? metadata,
//   }) async {
//     try {
//       final ref = _storage.ref().child(path);
//
//       SettableMetadata? settableMetadata;
//       if (metadata != null) {
//         settableMetadata = SettableMetadata(
//           customMetadata: metadata,
//         );
//       }
//
//       final snapshot = await ref.putData(bytes, settableMetadata);
//       final downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       Console.printError('Bytes upload failed: $e');
//       return null;
//     }
//   }
//
//   // Delete file
//   Future<bool> deleteFile(String path) async {
//     try {
//       await _storage.ref().child(path).delete();
//       return true;
//     } catch (e) {
//       Console.printError('File deletion failed: $e');
//       return false;
//     }
//   }
//
//   // Get download URL
//   Future<String?> getDownloadUrl(String path) async {
//     try {
//       return await _storage.ref().child(path).getDownloadURL();
//     } catch (e) {
//       Console.printError('Get download URL failed: $e');
//       return null;
//     }
//   }
//
//   // ============= MESSAGING METHODS =============
//
//   // Setup messaging
//   Future<void> _setupMessaging() async {
//     try {
//       // Request permission
//       final settings = await _messaging.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//         provisional: false,
//         announcement: false,
//         carPlay: false,
//         criticalAlert: false,
//       );
//
//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         Console.printSuccess('✅ Push notifications authorized');
//
//         // Get FCM token (Web requires VAPID key)
//         String? token;
//         if (kIsWeb) {
//           // For web, you need to provide VAPID key
//           // token = await _messaging.getToken(vapidKey: 'YOUR_VAPID_KEY');
//           token = await _messaging.getToken();
//         } else {
//           token = await _messaging.getToken();
//         }
//
//         if (token != null) {
//           _fcmTokenController.add(token);
//           Console.printInfo('FCM Token: $token');
//         }
//
//         // Listen to token refresh
//         _messaging.onTokenRefresh.listen((token) {
//           _fcmTokenController.add(token);
//           Console.printInfo('FCM Token refreshed: $token');
//         });
//       } else {
//         Console.printWarning('⚠️ Push notifications not authorized');
//       }
//     } catch (e) {
//       Console.printError('Messaging setup failed: $e');
//     }
//   }
//
//   // Subscribe to topic
//   Future<void> subscribeToTopic(String topic) async {
//     try {
//       await _messaging.subscribeToTopic(topic);
//       Console.printSuccess('Subscribed to topic: $topic');
//     } catch (e) {
//       Console.printError('Topic subscription failed: $e');
//     }
//   }
//
//   // Unsubscribe from topic
//   Future<void> unsubscribeFromTopic(String topic) async {
//     try {
//       await _messaging.unsubscribeFromTopic(topic);
//       Console.printSuccess('Unsubscribed from topic: $topic');
//     } catch (e) {
//       Console.printError('Topic unsubscription failed: $e');
//     }
//   }
//
//   // ============= ANALYTICS METHODS =============
//
//   // Log event (Fixed: proper type casting for parameters)
//   Future<void> logEvent({
//     required String name,
//     Map<String, dynamic>? parameters,
//   }) async {
//     try {
//       // Convert parameters to Map<String, Object>? as required by Firebase Analytics
//       Map<String, Object>? analyticsParams;
//       if (parameters != null) {
//         analyticsParams = {};
//         parameters.forEach((key, value) {
//           if (value != null) {
//             analyticsParams![key] = value as Object;
//           }
//         });
//       }
//
//       await _analytics.logEvent(
//         name: name,
//         parameters: analyticsParams,
//       );
//     } catch (e) {
//       Console.printError('Analytics event logging failed: $e');
//     }
//   }
//
//   // Set user property
//   Future<void> setUserProperty({
//     required String name,
//     required String? value,
//   }) async {
//     try {
//       await _analytics.setUserProperty(
//         name: name,
//         value: value,
//       );
//     } catch (e) {
//       Console.printError('Set user property failed: $e');
//     }
//   }
//
//   // Log screen view
//   Future<void> logScreenView({
//     required String screenName,
//     String? screenClass,
//   }) async {
//     try {
//       await _analytics.logScreenView(
//         screenName: screenName,
//         screenClass: screenClass,
//       );
//     } catch (e) {
//       Console.printError('Screen view logging failed: $e');
//     }
//   }
//
//   // ============= CRASHLYTICS METHODS =============
//
//   // Setup Crashlytics
//   Future<void> _setupCrashlytics() async {
//     try {
//       // Crashlytics is not supported on web
//       if (!kIsWeb) {
//         await _crashlytics.setCrashlyticsCollectionEnabled(true);
//
//         // Pass all uncaught errors to Crashlytics
//         FlutterError.onError = _crashlytics.recordFlutterError;
//
//         Console.printSuccess('✅ Crashlytics initialized');
//       } else {
//         Console.printInfo('ℹ️ Crashlytics is not supported on web');
//       }
//     } catch (e) {
//       Console.printError('Crashlytics setup failed: $e');
//     }
//   }
//
//   // Log error
//   void logError(dynamic error, StackTrace? stackTrace) {
//     if (!kIsWeb) {
//       _crashlytics.recordError(error, stackTrace);
//     }
//   }
//
//   // Log message
//   void logMessage(String message) {
//     if (!kIsWeb) {
//       _crashlytics.log(message);
//     }
//   }
//
//   // Set user identifier
//   Future<void> setUserId(String userId) async {
//     if (!kIsWeb) {
//       await _crashlytics.setUserIdentifier(userId);
//     }
//   }
//
//   // Set custom key (Fixed: proper type handling)
//   Future<void> setCustomKey(String key, dynamic value) async {
//     if (!kIsWeb) {
//       // Ensure value is not null and is a supported type
//       if (value != null) {
//         if (value is String || value is int || value is double || value is bool) {
//           await _crashlytics.setCustomKey(key, value);
//         } else {
//           await _crashlytics.setCustomKey(key, value.toString());
//         }
//       }
//     }
//   }
//
//   // ============= REMOTE CONFIG METHODS =============
//
//   // Setup Remote Config
//   Future<void> _setupRemoteConfig() async {
//     try {
//       await _remoteConfig.setConfigSettings(RemoteConfigSettings(
//         fetchTimeout: const Duration(minutes: 1),
//         minimumFetchInterval: const Duration(hours: 1),
//       ));
//
//       // Set default values
//       await _remoteConfig.setDefaults({
//         'welcome_message': 'Welcome to our app!',
//         'feature_enabled': true,
//         'minimum_version': '1.0.0',
//       });
//
//       // Fetch and activate
//       await fetchAndActivateRemoteConfig();
//
//       Console.printSuccess('✅ Remote Config initialized');
//     } catch (e) {
//       Console.printError('Remote Config setup failed: $e');
//     }
//   }
//
//   // Fetch and activate
//   Future<bool> fetchAndActivateRemoteConfig() async {
//     try {
//       final updated = await _remoteConfig.fetchAndActivate();
//       if (updated) {
//         Console.printSuccess('Remote Config updated');
//       }
//       return updated;
//     } catch (e) {
//       Console.printError('Remote Config fetch failed: $e');
//       return false;
//     }
//   }
//
//   // Get config value
//   T getConfigValue<T>(String key) {
//     final value = _remoteConfig.getValue(key);
//
//     if (T == String) {
//       return value.asString() as T;
//     } else if (T == int) {
//       return value.asInt() as T;
//     } else if (T == double) {
//       return value.asDouble() as T;
//     } else if (T == bool) {
//       return value.asBool() as T;
//     } else {
//       throw Exception('Unsupported type for Remote Config');
//     }
//   }
//
//   // ============= PRIVATE METHODS =============
//
//   void _setupAuthListener() {
//     _auth.authStateChanges().listen((User? user) {
//       _authStateController.add(user);
//       if (user != null) {
//         Console.printSuccess('User authenticated: ${user.uid}');
//         setUserId(user.uid);
//       } else {
//         Console.printInfo('User not authenticated');
//       }
//     });
//   }
//
//   Future<void> _postAuthSuccess(User? user) async {
//     if (user != null) {
//       // Log analytics event
//       await logEvent(
//         name: 'login',
//         parameters: {
//           'method': user.providerData.firstOrNull?.providerId ?? 'unknown',
//         },
//       );
//
//       // Set user properties
//       await setUserProperty(name: 'user_id', value: user.uid);
//
//       // Update FCM token
//       final token = await _messaging.getToken();
//       if (token != null) {
//         await updateUserToken(user.uid, token);
//       }
//     }
//   }
//
//   Future<void> updateUserToken(String userId, String token) async {
//     await updateDocument(
//       collection: 'users',
//       documentId: userId,
//       data: {
//         'fcmToken': token,
//         'lastActive': FieldValue.serverTimestamp(),
//       },
//     );
//   }
//
//   AuthResult _handleAuthException(FirebaseAuthException e) {
//     final message = _getAuthErrorMessage(e.code);
//     return AuthResult.error(message: message, code: e.code);
//   }
//
//   String _getAuthErrorMessage(String code) {
//     switch (code) {
//       case 'weak-password':
//         return 'The password provided is too weak.';
//       case 'email-already-in-use':
//         return 'An account already exists for that email.';
//       case 'invalid-email':
//         return 'The email address is invalid.';
//       case 'operation-not-allowed':
//         return 'This operation is not allowed.';
//       case 'user-disabled':
//         return 'This user has been disabled.';
//       case 'user-not-found':
//         return 'No user found for that email.';
//       case 'wrong-password':
//         return 'Wrong password provided.';
//       case 'too-many-requests':
//         return 'Too many requests. Try again later.';
//       case 'network-request-failed':
//         return 'Network error. Please check your connection.';
//       default:
//         return 'An error occurred. Please try again.';
//     }
//   }
//
//   // Cleanup
//   void dispose() {
//     _authStateController.close();
//     _fcmTokenController.close();
//   }
// }
//
// // Auth Result Model
// class AuthResult {
//   final bool success;
//   final User? user;
//   final String? message;
//   final String? code;
//
//   AuthResult({
//     required this.success,
//     this.user,
//     this.message,
//     this.code,
//   });
//
//   factory AuthResult.success({User? user}) {
//     return AuthResult(
//       success: true,
//       user: user,
//     );
//   }
//
//   factory AuthResult.error({
//     required String message,
//     String? code,
//   }) {
//     return AuthResult(
//       success: false,
//       message: message,
//       code: code,
//     );
//   }
// }