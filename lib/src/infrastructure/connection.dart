import 'dart:async';
import 'dart:convert';
import 'transport.dart';
import '../utils/logger.dart';
import 'channel_owner.dart';
import 'playwright_errors.dart';
import '../core/playwright.dart';
import '../core/browser_type.dart';
import '../core/browser.dart';
import '../core/browser_context.dart';
import '../interaction/element_handle.dart';
import '../core/frame.dart';
import '../interaction/jshandle.dart';
import '../core/page.dart';
import 'local_utils.dart';
import '../network/request.dart';
import '../network/response.dart';
import '../network/route.dart';
import '../network/websocket_route.dart';
import '../network/websocket.dart';
import '../network/api_request_context.dart';
import '../utils/tracing.dart';
import '../utils/cdp_session.dart';
import '../debugging/debugger.dart';
import '../debugging/debug_controller.dart';
import '../utils/artifact.dart';
import 'stream.dart';
import 'writable_stream.dart';
import '../debugging/disposable.dart';
import '../interaction/dialog.dart';
import '../utils/worker.dart';
import '../debugging/binding_call.dart';
import '../debugging/event_target.dart';
import '../platform/android.dart';
import '../platform/android_device.dart';
import '../platform/android_socket.dart';
import '../platform/electron.dart';
import '../platform/electron_application.dart';
import 'root.dart';
import '../network/socks_support.dart';
import 'json_pipe.dart';

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
  bool _isClosed = false;
  bool isAutoCloseEnabled = true;

  Connection(this.transport) {
    transport.onMessage = _dispatch;
    transport.onClose = _onClose;
    rootObject = RootChannelOwner(this);

    registerObjectFactory(
      'Playwright',
      (c, t, g, i, p) => PlaywrightImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'BrowserType',
      (c, t, g, i, p) => BrowserTypeImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'LocalUtils',
      (c, t, g, i, p) => LocalUtilsImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Browser',
      (c, t, g, i, p) => BrowserImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'BrowserContext',
      (c, t, g, i, p) => BrowserContextImpl(c, t, g, i, p),
    );
    registerObjectFactory('Page', (c, t, g, i, p) => PageImpl(c, t, g, i, p));
    registerObjectFactory('Frame', (c, t, g, i, p) => FrameImpl(c, t, g, i, p));
    registerObjectFactory(
      'JSHandle',
      (c, t, g, i, p) => JSHandleImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'ElementHandle',
      (c, t, g, i, p) => ElementHandleImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Request',
      (c, t, g, i, p) => RequestImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Response',
      (c, t, g, i, p) => ResponseImpl(c, t, g, i, p),
    );
    registerObjectFactory('Route', (c, t, g, i, p) => RouteImpl(c, t, g, i, p));
    registerObjectFactory(
      'WebSocketRoute',
      (c, t, g, i, p) => WebSocketRouteImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'WebSocket',
      (c, t, g, i, p) => PlaywrightWebSocketImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'APIRequestContext',
      (c, t, g, i, p) => APIRequestContextImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Tracing',
      (c, t, g, i, p) => TracingImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'CDPSession',
      (c, t, g, i, p) => CDPSessionImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Debugger',
      (c, t, g, i, p) => DebuggerImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'DebugController',
      (c, t, g, i, p) => DebugControllerImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Artifact',
      (c, t, g, i, p) => ArtifactImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Stream',
      (c, t, g, i, p) => PlaywrightStreamImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'WritableStream',
      (c, t, g, i, p) => WritableStreamImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Disposable',
      (c, t, g, i, p) => DisposableImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Dialog',
      (c, t, g, i, p) => DialogImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Worker',
      (c, t, g, i, p) => WorkerImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'BindingCall',
      (c, t, g, i, p) => BindingCallImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'EventTarget',
      (c, t, g, i, p) => EventTargetImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Android',
      (c, t, g, i, p) => AndroidImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'AndroidDevice',
      (c, t, g, i, p) => AndroidDeviceImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'AndroidSocket',
      (c, t, g, i, p) => AndroidSocketImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'Electron',
      (c, t, g, i, p) => ElectronImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'ElectronApplication',
      (c, t, g, i, p) => ElectronApplicationImpl(c, t, g, i, p),
    );
    registerObjectFactory('Root', (c, t, g, i, p) => RootImpl(c, t, g, i, p));
    registerObjectFactory(
      'SocksSupport',
      (c, t, g, i, p) => SocksSupportImpl(c, t, g, i, p),
    );
    registerObjectFactory(
      'JsonPipe',
      (c, t, g, i, p) => JsonPipeImpl(c, t, g, i, p),
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
    if (_isClosed) {
      return Future.error(Exception('Connection is closed'));
    }
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

    Logger.debug(
      '▶ SEND: ${jsonEncode(message)}',
      name: 'playwright.connection',
    );
    transport.send(message);

    return completer.future;
  }

  void _dispatch(Map<String, dynamic> message) {
    Logger.debug(
      '◀ RECV: ${jsonEncode(message)}',
      name: 'playwright.connection',
    );
    final id = message['id'] as int?;

    if (id != null) {
      // It's a response
      final callback = _callbacks.remove(id);
      if (callback != null) {
        if (message.containsKey('error')) {
          final errorStr = _parseError(message['error']);
          final parsed = parseServerError(errorStr);
          if (parsed is TargetClosedError) {
            // Silently complete with an empty result — the target is gone.
            callback.complete(<String, dynamic>{});
          } else {
            callback.completeError(parsed);
          }
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

        if (type == 'Dialog' && parent != null) {
          parent.emitEvent('dialog', {
            'dialog': {'guid': newGuid},
          });
        }
      } else {
        // Fallback for objects we haven't mapped yet
        Logger.warn('Warning: No factory registered for type $type');
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
      if (method == 'console' || method == 'request' || method == 'response') {
        Logger.debug(
          'RCV EVENT on $guid: $method',
          name: 'playwright.connection',
        );
      }
      object.emitEvent(method, params);
    } else {
      Logger.warn('Warning: Received event $method for unknown object $guid');
    }
  }

  void _onClose() {
    _isClosed = true;
    for (final callback in _callbacks.values) {
      callback.completeError(const TargetClosedError());
    }
    _callbacks.clear();
  }

  void close() {
    transport.close();
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
