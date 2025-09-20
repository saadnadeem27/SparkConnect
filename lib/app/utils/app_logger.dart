import 'dart:developer' as developer;

/// Application logger utility for debugging and error tracking
class AppLogger {
  static const String _appName = 'SparkConnect';

  /// Log an info message
  static void info(String message, [String? tag]) {
    developer.log(
      message,
      name: tag ?? _appName,
      level: 800, // Info level
    );
  }

  /// Log a success message
  static void success(String message, [String? tag]) {
    developer.log(
      '✅ $message',
      name: tag ?? _appName,
      level: 800, // Info level
    );
  }

  /// Log a warning message
  static void warning(String message, [String? tag]) {
    developer.log(
      '⚠️ $message',
      name: tag ?? _appName,
      level: 900, // Warning level
    );
  }

  /// Log an error message
  static void error(String message, [String? tag, Object? error, StackTrace? stackTrace]) {
    developer.log(
      '❌ $message',
      name: tag ?? _appName,
      level: 1000, // Error level
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a debug message (only in debug mode)
  static void debug(String message, [String? tag]) {
    assert(() {
      developer.log(
        '🐛 $message',
        name: tag ?? _appName,
        level: 700, // Debug level
      );
      return true;
    }());
  }

  /// Log network activity
  static void network(String message, [String? tag]) {
    developer.log(
      '🌐 $message',
      name: tag ?? '${_appName}_Network',
      level: 800,
    );
  }

  /// Log database activity
  static void database(String message, [String? tag]) {
    developer.log(
      '🗄️ $message',
      name: tag ?? '${_appName}_Database',
      level: 800,
    );
  }

  /// Log authentication activity
  static void auth(String message, [String? tag]) {
    developer.log(
      '🔐 $message',
      name: tag ?? '${_appName}_Auth',
      level: 800,
    );
  }

  /// Log performance metrics
  static void performance(String message, [String? tag]) {
    developer.log(
      '⚡ $message',
      name: tag ?? '${_appName}_Performance',
      level: 800,
    );
  }
}