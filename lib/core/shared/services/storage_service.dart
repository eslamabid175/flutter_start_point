import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/debug_utils.dart';

class StorageService {
  // Singleton pattern
  StorageService._internal();
  static final StorageService _instance = StorageService._internal();
  static StorageService get instance => _instance;
  factory StorageService() => _instance;

  // Storage instances
  late SharedPreferences _prefs;
  late FlutterSecureStorage _secureStorage;
  Database? _database;

  // Database configuration
  static const String _databaseName = 'app_database.db';
  static const int _databaseVersion = 1;

  // Table names
  static const String tableCache = 'cache';
  static const String tableUser = 'users';
  static const String tableSettings = 'settings';
  static const String tableLogs = 'logs';
  static const String tableNotifications = 'notifications';
  static const String tableOfflineData = 'offline_data';

  // Initialize storage service
  Future<void> initialize() async {
    try {
      Console.printInfo('💾 Initializing Storage Service...');

      // Initialize SharedPreferences
      _prefs = await SharedPreferences.getInstance();

      // Initialize SecureStorage
      _secureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      // Initialize SQLite Database
      await _initDatabase();

      Console.printSuccess('✅ Storage Service initialized');
    } catch (e) {
      Console.printError('❌ Storage Service initialization failed: $e');
    }
  }

  // ============= SQLITE DATABASE =============

  // Initialize database
  Future<void> _initDatabase() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _databaseName);

      _database = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure,
      );

      Console.printSuccess('✅ Database initialized at: $path');
    } catch (e) {
      Console.printError('Database initialization failed: $e');
    }
  }

  // Configure database
  Future<void> _onConfigure(Database db) async {
    // Enable foreign keys
    await db.execute('PRAGMA foreign_keys = ON');

    // Performance optimizations
    await db.execute('PRAGMA journal_mode = WAL');
    await db.execute('PRAGMA synchronous = NORMAL');
  }

  // Create database tables
  Future<void> _onCreate(Database db, int version) async {
    // Cache table
    await db.execute('''
      CREATE TABLE $tableCache (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE NOT NULL,
        value TEXT NOT NULL,
        expiry INTEGER,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // Users table
    await db.execute('''
      CREATE TABLE $tableUser (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT UNIQUE NOT NULL,
        username TEXT,
        email TEXT,
        profile_data TEXT,
        token TEXT,
        refresh_token TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // Settings table
    await db.execute('''
      CREATE TABLE $tableSettings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE NOT NULL,
        value TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // Logs table
    await db.execute('''
      CREATE TABLE $tableLogs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        level TEXT NOT NULL,
        message TEXT NOT NULL,
        data TEXT,
        timestamp INTEGER NOT NULL
      )
    ''');

    // Notifications table
    await db.execute('''
      CREATE TABLE $tableNotifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        notification_id TEXT UNIQUE NOT NULL,
        title TEXT,
        body TEXT,
        data TEXT,
        is_read INTEGER DEFAULT 0,
        timestamp INTEGER NOT NULL
      )
    ''');

    // Offline data table
    await db.execute('''
      CREATE TABLE $tableOfflineData (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        request_id TEXT UNIQUE NOT NULL,
        method TEXT NOT NULL,
        url TEXT NOT NULL,
        headers TEXT,
        body TEXT,
        retry_count INTEGER DEFAULT 0,
        created_at INTEGER NOT NULL
      )
    ''');

    // Create indexes
    await db.execute('CREATE INDEX idx_cache_key ON $tableCache(key)');
    await db.execute('CREATE INDEX idx_cache_expiry ON $tableCache(expiry)');
    await db.execute('CREATE INDEX idx_user_user_id ON $tableUser(user_id)');
    await db.execute('CREATE INDEX idx_settings_key ON $tableSettings(key)');
    await db.execute('CREATE INDEX idx_logs_timestamp ON $tableLogs(timestamp)');
    await db.execute('CREATE INDEX idx_notifications_timestamp ON $tableNotifications(timestamp)');
    await db.execute('CREATE INDEX idx_offline_data_created_at ON $tableOfflineData(created_at)');

    Console.printSuccess('✅ Database tables created');
  }

  // Upgrade database
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Console.printInfo('Upgrading database from v$oldVersion to v$newVersion');

    // Handle migrations based on version
    if (oldVersion < 2) {
      // Add new columns or tables for version 2
    }
  }

  // Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    await _initDatabase();
    return _database!;
  }

  // ============= CACHE OPERATIONS =============

  // Save to cache
  Future<void> saveToCache({
    required String key,
    required dynamic value,
    Duration? expiry,
  }) async {
    try {
      final db = await database;
      final now = DateTime.now().millisecondsSinceEpoch;
      final expiryTime = expiry != null
          ? now + expiry.inMilliseconds
          : null;

      await db.insert(
        tableCache,
        {
          'key': key,
          'value': jsonEncode(value),
          'expiry': expiryTime,
          'created_at': now,
          'updated_at': now,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      Console.printDebug('💾 Cached: $key');
    } catch (e) {
      Console.printError('Cache save failed: $e');
    }
  }

  // Get from cache
  Future<dynamic> getFromCache(String key) async {
    try {
      final db = await database;
      final results = await db.query(
        tableCache,
        where: 'key = ?',
        whereArgs: [key],
      );

      if (results.isNotEmpty) {
        final row = results.first;
        final expiry = row['expiry'] as int?;

        // Check if expired
        if (expiry != null && expiry < DateTime.now().millisecondsSinceEpoch) {
          await deleteCacheEntry(key);
          return null;
        }

        return jsonDecode(row['value'] as String);
      }
    } catch (e) {
      Console.printError('Cache get failed: $e');
    }
    return null;
  }

  // Delete cache entry
  Future<void> deleteCacheEntry(String key) async {
    try {
      final db = await database;
      await db.delete(
        tableCache,
        where: 'key = ?',
        whereArgs: [key],
      );
    } catch (e) {
      Console.printError('Cache delete failed: $e');
    }
  }

  // Clear all cache
  Future<void> clearCache() async {
    try {
      final db = await database;
      await db.delete(tableCache);
      Console.printSuccess('✅ Cache cleared');
    } catch (e) {
      Console.printError('Cache clear failed: $e');
    }
  }

  // Clear expired cache
  Future<void> clearExpiredCache() async {
    try {
      final db = await database;
      final now = DateTime.now().millisecondsSinceEpoch;

      final count = await db.delete(
        tableCache,
        where: 'expiry IS NOT NULL AND expiry < ?',
        whereArgs: [now],
      );

      Console.printInfo('🧹 Cleared $count expired cache entries');
    } catch (e) {
      Console.printError('Clear expired cache failed: $e');
    }
  }

  // Get cache size
  Future<int> getCacheSize() async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $tableCache',
      );
      return result.first['count'] as int;
    } catch (e) {
      Console.printError('Get cache size failed: $e');
      return 0;
    }
  }

  // ============= USER OPERATIONS =============

  // Save user
  Future<void> saveUser(Map<String, dynamic> userData) async {
    try {
      final db = await database;
      final now = DateTime.now().millisecondsSinceEpoch;

      await db.insert(
        tableUser,
        {
          'user_id': userData['id'],
          'username': userData['username'],
          'email': userData['email'],
          'profile_data': jsonEncode(userData),
          'token': userData['token'],
          'refresh_token': userData['refresh_token'],
          'created_at': now,
          'updated_at': now,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      Console.printSuccess('✅ User saved: ${userData['id']}');
    } catch (e) {
      Console.printError('Save user failed: $e');
    }
  }

  // Get user
  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      final db = await database;
      final results = await db.query(
        tableUser,
        where: 'user_id = ?',
        whereArgs: [userId],
      );

      if (results.isNotEmpty) {
        final row = results.first;
        final profileData = row['profile_data'] as String?;
        if (profileData != null) {
          return jsonDecode(profileData) as Map<String, dynamic>;
        }
      }
    } catch (e) {
      Console.printError('Get user failed: $e');
    }
    return null;
  }

  // Get current user (Fixed return type)
  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final db = await database;
      final results = await db.query(
        tableUser,
        orderBy: 'updated_at DESC',
        limit: 1,
      );

      if (results.isNotEmpty) {
        final row = results.first;
        final profileData = row['profile_data'] as String?;
        if (profileData != null) {
          return jsonDecode(profileData) as Map<String, dynamic>;
        }
      }
    } catch (e) {
      Console.printError('Get current user failed: $e');
    }
    return null;
  }

  // Delete user
  Future<void> deleteUser(String userId) async {
    try {
      final db = await database;
      await db.delete(
        tableUser,
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      Console.printSuccess('✅ User deleted: $userId');
    } catch (e) {
      Console.printError('Delete user failed: $e');
    }
  }

  // Clear all users
  Future<void> clearAllUsers() async {
    try {
      final db = await database;
      await db.delete(tableUser);
      Console.printSuccess('✅ All users cleared');
    } catch (e) {
      Console.printError('Clear users failed: $e');
    }
  }

  // ============= SETTINGS OPERATIONS =============

  // Save setting
  Future<void> saveSetting(String key, dynamic value) async {
    try {
      final db = await database;
      final now = DateTime.now().millisecondsSinceEpoch;

      await db.insert(
        tableSettings,
        {
          'key': key,
          'value': jsonEncode(value),
          'created_at': now,
          'updated_at': now,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      Console.printError('Save setting failed: $e');
    }
  }

  // Get setting
  Future<dynamic> getSetting(String key) async {
    try {
      final db = await database;
      final results = await db.query(
        tableSettings,
        where: 'key = ?',
        whereArgs: [key],
      );

      if (results.isNotEmpty) {
        return jsonDecode(results.first['value'] as String);
      }
    } catch (e) {
      Console.printError('Get setting failed: $e');
    }
    return null;
  }

  // Get all settings
  Future<Map<String, dynamic>> getAllSettings() async {
    try {
      final db = await database;
      final results = await db.query(tableSettings);

      final settings = <String, dynamic>{};
      for (final row in results) {
        settings[row['key'] as String] = jsonDecode(row['value'] as String);
      }
      return settings;
    } catch (e) {
      Console.printError('Get all settings failed: $e');
      return {};
    }
  }

  // ============= LOG OPERATIONS =============

  // Save log
  Future<void> saveLog({
    required String level,
    required String message,
    Map<String, dynamic>? data,
  }) async {
    try {
      final db = await database;

      await db.insert(
        tableLogs,
        {
          'level': level,
          'message': message,
          'data': data != null ? jsonEncode(data) : null,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      Console.printError('Save log failed: $e');
    }
  }

  // Get logs
  Future<List<Map<String, dynamic>>> getLogs({
    String? level,
    int? limit,
    int? offset,
  }) async {
    try {
      final db = await database;

      String? where;
      List<dynamic>? whereArgs;

      if (level != null) {
        where = 'level = ?';
        whereArgs = [level];
      }

      final results = await db.query(
        tableLogs,
        where: where,
        whereArgs: whereArgs,
        orderBy: 'timestamp DESC',
        limit: limit,
        offset: offset,
      );

      return results.map((row) => {
        'id': row['id'],
        'level': row['level'],
        'message': row['message'],
        'data': row['data'] != null ? jsonDecode(row['data'] as String) : null,
        'timestamp': row['timestamp'],
      }).toList();
    } catch (e) {
      Console.printError('Get logs failed: $e');
      return [];
    }
  }

  // Clear old logs
  Future<void> clearOldLogs({Duration age = const Duration(days: 7)}) async {
    try {
      final db = await database;
      final cutoff = DateTime.now().subtract(age).millisecondsSinceEpoch;

      final count = await db.delete(
        tableLogs,
        where: 'timestamp < ?',
        whereArgs: [cutoff],
      );

      Console.printInfo('🧹 Cleared $count old log entries');
    } catch (e) {
      Console.printError('Clear old logs failed: $e');
    }
  }

  // ============= NOTIFICATION OPERATIONS =============

  // Save notification
  Future<void> saveNotification({
    required String notificationId,
    String? title,
    String? body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final db = await database;

      await db.insert(
        tableNotifications,
        {
          'notification_id': notificationId,
          'title': title,
          'body': body,
          'data': data != null ? jsonEncode(data) : null,
          'is_read': 0,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      Console.printError('Save notification failed: $e');
    }
  }

  // Get notifications
  Future<List<Map<String, dynamic>>> getNotifications({
    bool? isRead,
    int? limit,
    int? offset,
  }) async {
    try {
      final db = await database;

      String? where;
      List<dynamic>? whereArgs;

      if (isRead != null) {
        where = 'is_read = ?';
        whereArgs = [isRead ? 1 : 0];
      }

      final results = await db.query(
        tableNotifications,
        where: where,
        whereArgs: whereArgs,
        orderBy: 'timestamp DESC',
        limit: limit,
        offset: offset,
      );

      return results.map((row) => {
        'id': row['id'],
        'notification_id': row['notification_id'],
        'title': row['title'],
        'body': row['body'],
        'data': row['data'] != null ? jsonDecode(row['data'] as String) : null,
        'is_read': row['is_read'] == 1,
        'timestamp': row['timestamp'],
      }).toList();
    } catch (e) {
      Console.printError('Get notifications failed: $e');
      return [];
    }
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      final db = await database;

      await db.update(
        tableNotifications,
        {'is_read': 1},
        where: 'notification_id = ?',
        whereArgs: [notificationId],
      );
    } catch (e) {
      Console.printError('Mark notification as read failed: $e');
    }
  }

  // Get unread notification count
  Future<int> getUnreadNotificationCount() async {
    try {
      final db = await database;

      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $tableNotifications WHERE is_read = 0',
      );

      return result.first['count'] as int;
    } catch (e) {
      Console.printError('Get unread notification count failed: $e');
      return 0;
    }
  }

  // ============= OFFLINE DATA OPERATIONS =============

  // Save offline request
  Future<void> saveOfflineRequest({
    required String requestId,
    required String method,
    required String url,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final db = await database;

      await db.insert(
        tableOfflineData,
        {
          'request_id': requestId,
          'method': method,
          'url': url,
          'headers': headers != null ? jsonEncode(headers) : null,
          'body': body != null ? jsonEncode(body) : null,
          'retry_count': 0,
          'created_at': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      Console.printInfo('💾 Offline request saved: $requestId');
    } catch (e) {
      Console.printError('Save offline request failed: $e');
    }
  }

  // Get offline requests
  Future<List<Map<String, dynamic>>> getOfflineRequests() async {
    try {
      final db = await database;

      final results = await db.query(
        tableOfflineData,
        orderBy: 'created_at ASC',
      );

      return results.map((row) => {
        'id': row['id'],
        'request_id': row['request_id'],
        'method': row['method'],
        'url': row['url'],
        'headers': row['headers'] != null ? jsonDecode(row['headers'] as String) : null,
        'body': row['body'] != null ? jsonDecode(row['body'] as String) : null,
        'retry_count': row['retry_count'],
        'created_at': row['created_at'],
      }).toList();
    } catch (e) {
      Console.printError('Get offline requests failed: $e');
      return [];
    }
  }

  // Delete offline request
  Future<void> deleteOfflineRequest(String requestId) async {
    try {
      final db = await database;

      await db.delete(
        tableOfflineData,
        where: 'request_id = ?',
        whereArgs: [requestId],
      );

      Console.printInfo('✅ Offline request deleted: $requestId');
    } catch (e) {
      Console.printError('Delete offline request failed: $e');
    }
  }

  // Increment retry count
  Future<void> incrementRetryCount(String requestId) async {
    try {
      final db = await database;

      await db.rawUpdate(
        'UPDATE $tableOfflineData SET retry_count = retry_count + 1 WHERE request_id = ?',
        [requestId],
      );
    } catch (e) {
      Console.printError('Increment retry count failed: $e');
    }
  }

  // ============= DATABASE MAINTENANCE =============

  // Vacuum database (optimize storage)
  Future<void> vacuumDatabase() async {
    try {
      final db = await database;
      await db.execute('VACUUM');
      Console.printSuccess('✅ Database optimized');
    } catch (e) {
      Console.printError('Database vacuum failed: $e');
    }
  }

  // Get database size
  Future<int> getDatabaseSize() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _databaseName);
      final file = File(path);

      if (await file.exists()) {
        return await file.length();
      }
    } catch (e) {
      Console.printError('Get database size failed: $e');
    }
    return 0;
  }

  // Export database
  Future<File?> exportDatabase() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final dbPath = join(documentsDirectory.path, _databaseName);
      final exportPath = join(documentsDirectory.path, 'backup_$_databaseName');

      final dbFile = File(dbPath);
      if (await dbFile.exists()) {
        return await dbFile.copy(exportPath);
      }
    } catch (e) {
      Console.printError('Export database failed: $e');
    }
    return null;
  }

  // Import database
  Future<bool> importDatabase(File backupFile) async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final dbPath = join(documentsDirectory.path, _databaseName);

      // Close current database
      await _database?.close();
      _database = null;

      // Copy backup file
      await backupFile.copy(dbPath);

      // Reinitialize database
      await _initDatabase();

      Console.printSuccess('✅ Database imported successfully');
      return true;
    } catch (e) {
      Console.printError('Import database failed: $e');
      return false;
    }
  }

  // Clear all data
  Future<void> clearAllData() async {
    try {
      // Clear SharedPreferences
      await _prefs.clear();

      // Clear SecureStorage
      await _secureStorage.deleteAll();

      // Clear database tables
      final db = await database;
      await db.delete(tableCache);
      await db.delete(tableUser);
      await db.delete(tableSettings);
      await db.delete(tableLogs);
      await db.delete(tableNotifications);
      await db.delete(tableOfflineData);

      Console.printSuccess('✅ All data cleared');
    } catch (e) {
      Console.printError('Clear all data failed: $e');
    }
  }

  // ============= SHARED PREFERENCES (Original Methods) =============

  // Save methods
  Future<bool> saveString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      Console.printError('Failed to save string: $e');
      return false;
    }
  }

  Future<bool> saveInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      Console.printError('Failed to save int: $e');
      return false;
    }
  }

  Future<bool> saveDouble(String key, double value) async {
    try {
      return await _prefs.setDouble(key, value);
    } catch (e) {
      Console.printError('Failed to save double: $e');
      return false;
    }
  }

  Future<bool> saveBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      Console.printError('Failed to save bool: $e');
      return false;
    }
  }

  Future<bool> saveStringList(String key, List<String> value) async {
    try {
      return await _prefs.setStringList(key, value);
    } catch (e) {
      Console.printError('Failed to save string list: $e');
      return false;
    }
  }

  // Get methods
  String? getString(String key) => _prefs.getString(key);
  int? getInt(String key) => _prefs.getInt(key);
  double? getDouble(String key) => _prefs.getDouble(key);
  bool? getBool(String key) => _prefs.getBool(key);
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  // ============= SECURE STORAGE (Original Methods) =============

  Future<void> saveSecure(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      Console.printError('Failed to save secure data: $e');
    }
  }

  Future<String?> getSecure(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      Console.printError('Failed to get secure data: $e');
      return null;
    }
  }

  Future<void> deleteSecure(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      Console.printError('Failed to delete secure data: $e');
    }
  }

  Future<void> deleteAllSecure() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      Console.printError('Failed to delete all secure data: $e');
    }
  }

  // ============= USER PREFERENCES =============

  Future<void> saveToken(String token) => saveSecure('user_token', token);
  Future<String?> getToken() => getSecure('user_token');
  Future<void> deleteToken() => deleteSecure('user_token');

  Future<void> clearUserData() async {
    await deleteToken();
    await deleteAllSecure();
    await clearAllUsers();
  }

  // Dispose
  Future<void> dispose() async {
    await _database?.close();
  }
}