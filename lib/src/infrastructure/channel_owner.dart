import 'dart:async';
import 'connection.dart';

abstract class ChannelOwner {
  final Connection connection;
  final String guid;
  final String channelType;
  final ChannelOwner? parent;
  final Map<String, ChannelOwner> objects = {};

  final StreamController<Map<String, dynamic>> _eventController =
      StreamController.broadcast();
  Stream<Map<String, dynamic>> get onEvent => _eventController.stream;

  void emitEvent(String event, dynamic params) {
    if (!_eventController.isClosed) {
      _eventController.add({'event': event, 'params': params});
    }
  }

  Map<String, dynamic> initializer;

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

  void dispose() {
    // Clean up from parent
    if (parent != null) {
      parent!.objects.remove(guid);
    }
    // Clean up from connection
    connection.objects.remove(guid);

    if (!_eventController.isClosed) {
      _eventController.close();
    }

    // Dispose children
    for (final child in objects.values.toList()) {
      child.dispose();
    }
    objects.clear();
  }

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

class RootChannelOwner extends ChannelOwner {
  RootChannelOwner(Connection connection) : super(connection, '', '', {});
}

abstract class Channel {
  final ChannelOwner owner;

  Channel(this.owner);

  Future<Map<String, dynamic>> sendMessageToServer(
    String method, [
    Map<String, dynamic>? params,
  ]) {
    return owner.connection.sendMessageToServer(owner.guid, method, params);
  }
}
