import 'dart:developer' as developer;

/// Simple native logger for Playwright internal debugging.
class Logger {
  static bool isDebugEnabled = false;

  /// Prints a debug message if debugging is enabled.
  static void debug(String message, {String name = 'playwright'}) {
    if (isDebugEnabled) {
      developer.log(message, name: name);
      // Fallback to print so it always shows up in terminal stdout
      print('[$name] $message');
    }
  }

  /// Prints an informational message unconditionally.
  static void info(String message) {
    developer.log(message, name: 'playwright.info');
    print(message);
  }

  /// Prints an error message.
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'playwright.error',
      error: error,
      stackTrace: stackTrace,
    );
    print('[playwright.error] $message');
    if (error != null) print(error);
    if (stackTrace != null) print(stackTrace);
  }
}
