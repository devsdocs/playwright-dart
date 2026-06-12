import 'dart:async';
import 'transport.dart';
import 'channel_owner.dart';
import 'playwright.dart';
import 'browser_type.dart';
import 'browser.dart';
import 'browser_context.dart';
import 'element_handle.dart';
import 'frame.dart';
import 'jshandle.dart';
import 'page.dart';

typedef ChannelOwnerFactory =
    ChannelOwner Function(
      Connection connection,
      String type,
      String guid,
      Map<String, dynamic> initializer,
      ChannelOwner? parent,
    );

class Connection {
  final Transport transport;
  final Map<String, ChannelOwner> objects = {};
  final Map<int, Completer<Map<String, dynamic>>> _callbacks = {};

  int _lastId = 0;
  final Map<String, ChannelOwnerFactory> _objectFactories = {};
  RootChannelOwner? rootObject;

  Connection(this.transport) {
    transport.onMessage = _dispatch;
    transport.onClose = _onClose;
    rootObject = RootChannelOwner(this);

    registerObjectFactory(
      'Playwright',
      (c, t, g, i, p) => Playwright(c, t, g, i, p),
    );
    registerObjectFactory(
      'BrowserType',
      (c, t, g, i, p) => BrowserType(c, t, g, i, p),
    );
    registerObjectFactory('Browser', (c, t, g, i, p) => Browser(c, t, g, i, p));
    registerObjectFactory(
      'BrowserContext',
      (c, t, g, i, p) => BrowserContext(c, t, g, i, p),
    );
    registerObjectFactory('Page', (c, t, g, i, p) => Page(c, t, g, i, p));
    registerObjectFactory('Frame', (c, t, g, i, p) => Frame(c, t, g, i, p));
    registerObjectFactory(
      'JSHandle',
      (c, t, g, i, p) => JSHandle(c, t, g, i, p),
    );
    registerObjectFactory(
      'ElementHandle',
      (c, t, g, i, p) => ElementHandle(c, t, g, i, p),
    );
  }

  void registerObjectFactory(String type, ChannelOwnerFactory factory) {
    _objectFactories[type] = factory;
  }

  Future<Map<String, dynamic>> sendMessageToServer(
    String guid,
    String method, [
    Map<String, dynamic>? params,
  ]) {
    final id = ++_lastId;
    final message = {
      'id': id,
      'guid': guid,
      'method': method,
      'params': params ?? {},
      'metadata': {},
    };

    final completer = Completer<Map<String, dynamic>>();
    _callbacks[id] = completer;

    transport.send(message);
    return completer.future;
  }

  void _dispatch(Map<String, dynamic> message) {
    final id = message['id'] as int?;

    if (id != null) {
      // It's a response
      final callback = _callbacks.remove(id);
      if (callback != null) {
        if (message.containsKey('error')) {
          callback.completeError(Exception(_parseError(message['error'])));
        } else {
          callback.complete((message['result'] as Map<String, dynamic>?) ?? {});
        }
      }
      return;
    }

    // It's an event from the server
    final guid = message['guid'] as String;
    final method = message['method'] as String;
    final params = message['params'] as Map<String, dynamic>? ?? {};

    if (method == '__create__') {
      final type = params['type'] as String;
      final initializer = params['initializer'] as Map<String, dynamic>;
      final newGuid = params['guid'] as String;

      final parent = objects[guid];

      final factory = _objectFactories[type];
      if (factory != null) {
        factory(this, type, newGuid, initializer, parent);
      } else {
        // Fallback for objects we haven't mapped yet
        print('Warning: No factory registered for type \$type');
        // create a dummy owner
        // ignore: unused_local_variable
        final dummy = _DummyChannelOwner(
          this,
          type,
          newGuid,
          initializer,
          parent,
        );
      }
      return;
    }

    if (method == '__dispose__') {
      final object = objects[guid];
      object?.dispose();
      return;
    }

    // Normal event
    final object = objects[guid];
    if (object != null) {
      // TODO: Dispatch event to the object's channel
      // object.channel.emit(method, params);
      print('Event received: \$method on \$guid');
    }
  }

  void _onClose() {
    for (final callback in _callbacks.values) {
      callback.completeError(Exception('Connection closed'));
    }
    _callbacks.clear();
  }

  String _parseError(dynamic error) {
    if (error is Map) {
      final e = error['error'];
      if (e is Map) {
        return '${e['name']}: ${e['message']}\n${e['stack']}';
      }
      return e.toString();
    }
    return error.toString();
  }
}

class _DummyChannelOwner extends ChannelOwner {
  _DummyChannelOwner(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);
}
