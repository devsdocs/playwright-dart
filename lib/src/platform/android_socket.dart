import '../generated/channels.dart';

/// Interface for AndroidSocket
abstract interface class AndroidSocket {
  Stream<AndroidSocket> get onClose;
  Stream<AndroidSocketDataEvent> get onData;

  /// Writes some [data] to the socket.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidSocket.write(data);
  /// ```
  ///
  /// **Arguments**
  /// - `data` String
  ///
  ///   Data to write.
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> write(String data);

  /// Closes the socket.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await androidSocket.close();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> close();
}

class AndroidSocketImpl extends AndroidSocketBase implements AndroidSocket {
  @override
  Stream<AndroidSocket> get onClose {
    return onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  @override
  Stream<AndroidSocketDataEvent> get onData {
    return onEvent
        .where((e) => e['event'] == 'data')
        .map((e) => AndroidSocketDataEvent.fromJson(e['params']));
  }

  AndroidSocketImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<void> write(String data) async {
    await channel_write(data: data);
  }

  @override
  Future<void> close() async {
    await channel_close();
  }
}
