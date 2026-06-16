import 'dart:async';

import 'connection.dart';

import 'event_emitter.dart';

/// Base class for every object that participates in the Playwright protocol.

///

/// Every protocol object (Page, Frame, ElementHandle, …) is represented as a

/// [ChannelOwner].  The class manages:

///

/// - Object identity via [guid].

/// - Parent / child ownership so that a `__dispose__` from the server can walk

///   the tree and clean up all descendants.

/// - A broadcast [StreamController] for inbound server events so sub-classes

///   can expose typed `Stream` getters (e.g. `onConsole`, `onClose`).

/// - A Playwright-style [EventEmitter] that lets sub-classes use the

///   `on/off/once/emit` API (mirrors the JS `ChannelOwner extends EventEmitter`

///   design).

abstract class ChannelOwner {
  final Connection connection;

  final String guid;

  final String channelType;

  final ChannelOwner? parent;

  final Map<String, ChannelOwner> objects = {};

  // ── Raw event stream (internal, matches server events) ───────────────────

  final StreamController<Map<String, dynamic>> _eventController =
      StreamController.broadcast();

  /// Raw stream of every server event dispatched to this object.

  ///

  /// Events are maps with keys `'event'` (String) and `'params'`

  /// (`Map<String, dynamic>`).  Sub-classes should expose typed `Stream` getters

  /// that filter/map this stream rather than exposing it directly.

  Stream<Map<String, dynamic>> get onEvent => _eventController.stream;

  // ── EventEmitter (named-event API, matches JS Playwright) ─────────────────

  /// Playwright-style event emitter for this channel owner.

  ///

  /// Sub-classes and users may call `channel.on('close', handler)` just like

  /// the Node.js Playwright client does.  Internally, the raw [onEvent] stream

  /// forwards events here so both APIs work simultaneously.

  final EventEmitter _emitter = EventEmitter();

  /// Registers a persistent listener for the named [event].

  void on(String event, void Function(dynamic) handler) =>
      _emitter.on(event, handler);

  /// Alias for [on].

  void addListener(String event, void Function(dynamic) handler) =>
      _emitter.addListener(event, handler);

  /// Removes a previously registered [handler].

  void off(String event, void Function(dynamic) handler) =>
      _emitter.off(event, handler);

  /// Alias for [off].

  void removeListener(String event, void Function(dynamic) handler) =>
      _emitter.removeListener(event, handler);

  /// Registers a listener that fires only once.

  void once(String event, void Function(dynamic) handler) =>
      _emitter.once(event, handler);

  /// Returns the number of listeners registered for [event].

  int listenerCount(String event) => _emitter.listenerCount(event);

  // ── Initializer data ──────────────────────────────────────────────────────

  Map<String, dynamic> initializer;

  // ── Constructor ───────────────────────────────────────────────────────────

  ChannelOwner(
    this.connection,

    this.channelType,

    this.guid,

    this.initializer, [

    this.parent,
  ]) {
    connection.objects[guid] = this;

    if (parent != null) {
      parent!.objects[guid] = this;
    }
  }

  // ── Event dispatch ────────────────────────────────────────────────────────

  /// Called by [Connection] to forward a server event to this object.

  ///

  /// The event is placed on the raw [onEvent] stream **and** forwarded to the

  /// named-event [EventEmitter], mirroring the JS behaviour where

  /// `ChannelOwner` both extends `EventEmitter` and wires `_channel.on(...)`.

  void emitEvent(String event, dynamic params) {
    if (!_eventController.isClosed) {
      final envelope = {'event': event, 'params': params ?? {}};

      _eventController.add(envelope);

      _emitter.emit(event, params);
    }
  }

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  /// Disposes this object and all of its children.

  ///

  /// Called automatically by [Connection] when it receives a `__dispose__`

  /// message from the server.

  void dispose() {
    // Remove from parent.

    if (parent != null) {
      parent!.objects.remove(guid);
    }

    // Remove from connection's global object map.

    connection.objects.remove(guid);

    if (!_eventController.isClosed) {
      _eventController.close();
    }

    // Recursively dispose children.

    for (final child in objects.values.toList()) {
      child.dispose();
    }

    objects.clear();

    _emitter.removeAllListeners();
  }

  // ── Static helpers ────────────────────────────────────────────────────────

  /// Resolves a wire-format object reference `{'guid': '...'}` to a typed

  /// [ChannelOwner] instance.

  ///

  /// Throws if the guid is not currently registered in [connection].

  static T from<T extends ChannelOwner>(
    Connection connection,

    Map<String, dynamic> wire,
  ) {
    final guid = wire['guid'] as String;

    final obj = connection.objects[guid];

    if (obj == null) throw Exception('Object with guid $guid not found');

    return obj as T;
  }
}

/// The virtual root object.  Every connection starts with one of these so

/// that the first `__create__` event has a parent to attach to.

class RootChannelOwner extends ChannelOwner {
  RootChannelOwner(Connection connection) : super(connection, '', '', {});
}

/// Abstract base for the typed channel dispatch helpers generated in

/// `channels.dart`.  Each concrete `*Base` class holds a reference to its

/// [ChannelOwner] and exposes `channel_*` methods that forward to

/// [ChannelOwner.connection].sendMessageToServer.

abstract class Channel {
  final ChannelOwner owner;

  Channel(this.owner);

  /// Sends a method call to the server on behalf of [owner].

  Future<Map<String, dynamic>> sendMessageToServer(
    String method, [

    Map<String, dynamic>? params,
  ]) {
    return owner.connection.sendMessageToServer(owner.guid, method, params);
  }
}
