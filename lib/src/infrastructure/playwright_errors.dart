/// Playwright typed error hierarchy.
///
/// Mirrors the error classes in the official Playwright Node.js client:
/// - [PlaywrightError] — base class for all Playwright errors.
/// - [TimeoutError] — thrown when an action exceeds its timeout.
/// - [TargetClosedError] — thrown when the target page, context or browser
///   has been closed before the action completes.
library;

/// Base class for all Playwright errors.
class PlaywrightError implements Exception {
  final String message;

  /// Optional log lines collected during the failing operation.
  final List<String> log;

  const PlaywrightError(this.message, {this.log = const []});

  @override
  String toString() {
    final logSection = log.isEmpty ? '' : '\n\n${_formatLog(log)}';
    return 'PlaywrightError: $message$logSection';
  }

  static String _formatLog(List<String> log) {
    const header = ' logs ';
    const width = 60;
    final left = (width - header.length) ~/ 2;
    final right = width - header.length - left;
    final bar = '=' * left + header + '=' * right;
    return '$bar\n${log.join('\n')}\n${'=' * width}';
  }
}

/// Thrown when an action exceeds its configured timeout.
class TimeoutError extends PlaywrightError {
  const TimeoutError(super.message, {super.log});

  @override
  String toString() => 'TimeoutError: $message';
}

/// Thrown when the target page, context or browser has been closed.
class TargetClosedError extends PlaywrightError {
  const TargetClosedError([String? cause])
    : super(cause ?? 'Target page, context or browser has been closed');

  @override
  String toString() => 'TargetClosedError: $message';
}

/// Returns `true` when [error] is a [TargetClosedError].
bool isTargetClosedError(Object error) => error is TargetClosedError;

/// Returns `true` when [error] is a [TimeoutError].
bool isTimeoutError(Object error) => error is TimeoutError;

/// Parses an error message string from the server and returns the appropriate
/// typed [PlaywrightError] subclass.
PlaywrightError parseServerError(String message) {
  if (message.contains('TimeoutError') || message.startsWith('TimeoutError:')) {
    return TimeoutError(message);
  }
  if (message.contains('TargetClosedError') ||
      message.contains('Target closed') ||
      message.contains('Browser has been closed') ||
      message.contains('Target page, context or browser has been closed')) {
    return TargetClosedError(message);
  }
  return PlaywrightError(message);
}
