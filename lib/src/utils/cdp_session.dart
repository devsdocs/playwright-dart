import '../generated/channels.dart';

/// Interface for CDPSession
abstract interface class CDPSession {
  Stream<CDPSession> get onClose;
  Stream<Map<String, dynamic>> get onEvent;

  /// **Usage**
  ///
  /// ```dart
  /// await cdpSession.send(method);
  /// await cdpSession.send(method, params);
  /// ```
  ///
  /// **Arguments**
  /// - `method` String
  ///
  ///   Protocol method name.
  /// - `params` Map&lt;String, dynamic&gt; *(optional)*
  ///
  ///   Optional method parameters.
  ///
  /// **Returns**
  /// - Future&lt;Map&gt;
  Future<Map<String, dynamic>> send(
    String method, {
    Map<String, dynamic>? params,
  });

  /// Detaches the CDPSession from the target. Once detached, the CDPSession object won't emit any events and can't be used to send messages.
  ///
  /// **Usage**
  ///
  /// ```dart
  /// await cdpSession.detach();
  /// ```
  ///
  /// **Returns**
  /// - Future&lt;void&gt;
  Future<void> detach();
}

class CDPSessionImpl extends CDPSessionBase implements CDPSession {
  @override
  Stream<CDPSession> get onClose {
    return super.onEvent.where((e) => e['event'] == 'close').map((e) => this);
  }

  @override
  Stream<Map<String, dynamic>> get onEvent {
    return super.onEvent
        .where((e) => e['event'] == 'event')
        .map((e) => e['params']);
  }

  CDPSessionImpl(
    super.connection,
    super.channelType,
    super.guid,
    super.initializer, [
    super.parent,
  ]);

  @override
  Future<Map<String, dynamic>> send(
    String method, {
    Map<String, dynamic>? params,
  }) async {
    final result = await channel.send(method: method, params: params);
    return result.result as Map<String, dynamic>? ?? {};
  }

  @override
  Future<void> detach() async {
    await channel.detach();
  }
}
