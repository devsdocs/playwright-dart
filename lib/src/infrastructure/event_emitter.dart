import 'dart:async';

/// A typed event emitter that mirrors the Playwright Node.js [EventEmitter] API.
///
/// Unlike Dart's built-in [Stream] / [StreamController], this class provides
/// the familiar `on` / `off` / `once` / `emit` surface that matches the
/// JavaScript Playwright client, while mapping each named event to a
/// [StreamController.broadcast] under the hood.
///
/// ## Usage
///
/// ```dart
/// final emitter = EventEmitter();
///
/// void handler(dynamic args) => print('got: $args');
/// emitter.on('data', handler);
/// emitter.emit('data', 'hello');   // prints "got: hello"
/// emitter.off('data', handler);
/// ```
class EventEmitter {
  final Map<String, List<_Listener>> _events = {};

  // ── Public API ──────────────────────────────────────────────────────────────

  /// Adds a persistent [handler] for [event].
  void on(String event, void Function(dynamic) handler) {
    _events.putIfAbsent(event, () => []).add(_Listener(handler));
  }

  /// Alias for [on].
  void addListener(String event, void Function(dynamic) handler) =>
      on(event, handler);

  /// Removes a previously registered [handler] for [event].
  void off(String event, void Function(dynamic) handler) {
    final listeners = _events[event];
    if (listeners == null) return;
    listeners.removeWhere((l) => l.handler == handler);
    if (listeners.isEmpty) _events.remove(event);
  }

  /// Alias for [off].
  void removeListener(String event, void Function(dynamic) handler) =>
      off(event, handler);

  /// Adds a [handler] that fires only **once** for [event] and then
  /// automatically removes itself.
  void once(String event, void Function(dynamic) handler) {
    late final _Listener wrapper;
    wrapper = _Listener(
      (args) {
        off(event, wrapper.handler);
        handler(args);
      },
      once: true,
      original: handler,
    );
    _events.putIfAbsent(event, () => []).add(wrapper);
  }

  /// Removes all listeners for [event], or all listeners when [event] is null.
  void removeAllListeners([String? event]) {
    if (event == null) {
      _events.clear();
    } else {
      _events.remove(event);
    }
  }

  /// Emits [event] synchronously, calling all registered listeners with [args].
  ///
  /// Returns `true` if any listeners were registered for this event.
  bool emit(String event, [dynamic args]) {
    final listeners = _events[event];
    if (listeners == null || listeners.isEmpty) return false;
    // Iterate over a snapshot to allow handlers to mutate the list.
    for (final listener in listeners.toList()) {
      listener.handler(args);
    }
    return true;
  }

  /// Returns the current number of listeners registered for [event].
  int listenerCount(String event) => _events[event]?.length ?? 0;

  /// Returns the list of event names that have at least one listener.
  List<String> eventNames() => _events.keys.toList();

  /// Returns a [Stream] that emits values whenever [event] is fired via
  /// [emit].  Each call returns a new broadcast stream backed by a controller
  /// added to [event]'s listener list.
  Stream<dynamic> stream(String event) {
    late StreamController<dynamic> controller;
    controller = StreamController<dynamic>.broadcast();
    on(event, controller.add);
    controller.onCancel = () => off(event, controller.add);
    return controller.stream;
  }
}

/// Internal wrapper around a listener function.
class _Listener {
  final void Function(dynamic) handler;
  final bool once;
  final void Function(dynamic)? original;

  _Listener(this.handler, {this.once = false, this.original});
}
