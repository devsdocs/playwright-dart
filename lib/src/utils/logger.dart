import 'dart:developer' as developer;

/// Controls which messages the [Logger] emits.
///
/// Levels are ordered from most to least verbose:
/// [trace] > [debug] > [info] > [warn] > [error] > [none]
///
/// Setting a level means that level **and all levels above it** are printed.
/// For example, [LogLevel.info] prints `info`, `warn`, and `error` messages.
enum LogLevel {
  /// Prints every message including low-level protocol traces.
  trace,

  /// Prints debug, info, warn and error messages.
  debug,

  /// Prints info, warn and error messages. Default level.
  info,

  /// Prints warn and error messages only.
  warn,

  /// Prints error messages only.
  error,

  /// Suppresses all output.
  none,
}

/// Central logger for Playwright Dart.
///
/// The active level is set via [Logger.level] (defaults to [LogLevel.info]).
/// Use [PlaywrightDart.create] to pass a [LogLevel] at startup.
class Logger {
  /// The minimum level at which messages are emitted. Defaults to [LogLevel.info].
  static LogLevel level = LogLevel.info;

  /// Optional custom sink for testing or custom log redirection.
  static void Function(
    String message, {
    required String channel,
    Object? error,
    StackTrace? stackTrace,
  })?
  sink;

  // ── Private helpers ──────────────────────────────────────────────────────

  static bool _allows(LogLevel msgLevel) => msgLevel.index >= level.index;

  static void _emit(
    String message, {
    required String channel,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (sink != null) {
      sink!(message, channel: channel, error: error, stackTrace: stackTrace);
      return;
    }
    developer.log(message, name: channel, error: error, stackTrace: stackTrace);
    final prefix = channel == 'playwright.info' ? '' : '[$channel] ';
    print('$prefix$message');
    if (error != null) print(error);
    if (stackTrace != null) print(stackTrace);
  }

  // ── Public API ────────────────────────────────────────────────────────────

  /// Low-level protocol trace — only emitted at [LogLevel.trace].
  static void trace(String message, {String name = 'playwright'}) {
    if (_allows(LogLevel.trace)) {
      _emit(message, channel: 'playwright.trace/$name');
    }
  }

  /// Debug message — emitted at [LogLevel.debug] and below.
  static void debug(String message, {String name = 'playwright'}) {
    if (_allows(LogLevel.debug)) {
      _emit(message, channel: 'playwright.debug/$name');
    }
  }

  /// Informational milestone — emitted at [LogLevel.info] and below.
  static void info(String message) {
    if (_allows(LogLevel.info)) {
      _emit(message, channel: 'playwright.info');
    }
  }

  /// Warning — always emitted unless level is [LogLevel.none].
  static void warn(String message) {
    if (_allows(LogLevel.warn)) {
      _emit(message, channel: 'playwright.warn');
    }
  }

  /// Error — always emitted unless level is [LogLevel.none].
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (_allows(LogLevel.error)) {
      _emit(
        message,
        channel: 'playwright.error',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
