import 'dart:async';
import 'connection.dart';

abstract class ChannelOwner {
  final Connection connection;
  final String guid;
  final String type;
  final ChannelOwner? parent;
  final Map<String, ChannelOwner> objects = {};

  Map<String, dynamic> initializer;

  ChannelOwner(
    this.connection,
    this.type,
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
