import 'dart:async';
import 'playwright_errors.dart';
import 'channel_owner.dart';

/// Utility that waits for a named event on a [ChannelOwner] with support for
/// race conditions (timeout, reject-on-another-event).
///
/// This mirrors the Playwright Node.js `Waiter` class, which is used
/// internally to implement `page.waitForEvent(...)` and similar APIs.
///
/// ## Example
///
/// ```dart
/// final waiter = Waiter(page, 'load');
/// waiter.rejectOnTimeout(30000, 'Timeout waiting for load event');
/// waiter.rejectOnEvent(page, 'close', TargetClosedError('Page was closed'));
/// final result = await waiter.waitForEvent<void>(page, 'load');
/// waiter.dispose();
/// ```
class Waiter<T> {
  final ChannelOwner
  _channelOwner; // ignore: unused_field — kept for tracing/future use
  final String _event; // ignore: unused_field — kept for tracing/future use

  final List<void Function()> _disposeCallbacks = [];
  final List<Future<T>> _rejectFutures = [];
  PlaywrightError? _immediateError;

  Waiter(this._channelOwner, this._event);

  /// Creates a [Waiter] for a named event on [channelOwner].
  static Waiter<T> createForEvent<T>(ChannelOwner channelOwner, String event) =>
      Waiter<T>(channelOwner, event);

  // ── Reject conditions ────────────────────────────────────────────────────

  /// Rejects the waiter with a [TimeoutError] after [timeoutMs] milliseconds.
  ///
  /// Pass 0 to disable the timeout.
  void rejectOnTimeout(double timeoutMs, String message) {
    if (timeoutMs <= 0) return;
    final future = Future<T>.delayed(
      Duration(milliseconds: timeoutMs.toInt()),
      () => throw TimeoutError(message),
    );
    _rejectFutures.add(future);
  }

  /// Rejects the waiter when [event] fires on [emitter].
  void rejectOnEvent(
    ChannelOwner emitter,
    String event,
    PlaywrightError error, [
    bool Function(dynamic)? predicate,
  ]) {
    late StreamSubscription<dynamic> sub;
    final completer = Completer<T>();
    sub = emitter.onEvent
        .where(
          (e) =>
              e['event'] == event &&
              (predicate == null || predicate(e['params'])),
        )
        .listen((_) {
          if (!completer.isCompleted) {
            completer.completeError(error);
          }
        });
    _rejectFutures.add(completer.future);
    _disposeCallbacks.add(sub.cancel);
  }

  /// Rejects the waiter immediately with [error].
  void rejectImmediately(PlaywrightError error) {
    _immediateError = error;
  }

  // ── Wait ─────────────────────────────────────────────────────────────────

  /// Waits for [event] on [emitter], subject to any reject conditions.
  ///
  /// An optional [predicate] filters which event payloads are accepted.
  Future<T> waitForEvent(
    ChannelOwner emitter,
    String event, [
    bool Function(dynamic)? predicate,
  ]) {
    final completer = Completer<T>();
    late StreamSubscription<dynamic> sub;
    sub = emitter.onEvent
        .where(
          (e) =>
              e['event'] == event &&
              (predicate == null || predicate(e['params'])),
        )
        .listen((e) {
          if (!completer.isCompleted) {
            completer.complete(e['params'] as T);
          }
          sub.cancel();
        });
    _disposeCallbacks.add(sub.cancel);
    return waitForPromise(completer.future);
  }

  /// Waits for [promise], racing it against all registered reject conditions.
  Future<R> waitForPromise<R>(Future<R> promise) async {
    if (_immediateError != null) throw _immediateError!;
    try {
      return await Future.any([promise, ..._rejectFutures.cast<Future<R>>()]);
    } finally {
      dispose();
    }
  }

  // ── Cleanup ───────────────────────────────────────────────────────────────

  /// Cancels all registered timers and subscriptions.
  void dispose() {
    for (final cb in _disposeCallbacks) {
      cb();
    }
    _disposeCallbacks.clear();
  }
}
