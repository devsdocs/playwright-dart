import 'dart:async';
import 'package:playwright_dart/src/infrastructure/transport.dart';
import 'package:playwright_dart/src/infrastructure/connection.dart';
import 'package:playwright_dart/src/infrastructure/channel_owner.dart';

class MockTransport implements Transport {
  @override
  void Function(Map<String, dynamic>)? onMessage;

  @override
  void Function()? onClose;

  final List<Map<String, dynamic>> sentMessages = [];
  final Map<String, dynamic> Function(Map<String, dynamic> request)? handler;

  MockTransport({this.handler});

  @override
  void send(Map<String, dynamic> message) {
    sentMessages.add(message);

    if (handler != null) {
      final response = handler!(message);
      if (response.isNotEmpty) {
        // Schedule response to be delivered asynchronously
        scheduleMicrotask(() {
          onMessage?.call(response);
        });
      }
    }
  }

  @override
  void close() {
    onClose?.call();
  }
}

class TestConnection {
  late Connection connection;
  late MockTransport transport;

  TestConnection({
    Map<String, dynamic> Function(Map<String, dynamic> request)? handler,
  }) {
    transport = MockTransport(handler: handler);
    connection = Connection(transport);
  }

  void dispatchEvent(
    String guid,
    String method, [
    Map<String, dynamic>? params,
  ]) {
    transport.onMessage?.call({
      'guid': guid,
      'method': method,
      'params': params ?? {},
    });
  }

  void dispatchCreate(
    String type,
    String guid,
    Map<String, dynamic> initializer, {
    String parentGuid = '',
  }) {
    transport.onMessage?.call({
      'guid': parentGuid,
      'method': '__create__',
      'params': {'type': type, 'guid': guid, 'initializer': initializer},
    });
  }

  ChannelOwner? getObject(String guid) => connection.objects[guid];
}
