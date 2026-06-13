import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

typedef MessageCallback = void Function(Map<String, dynamic> message);
typedef CloseCallback = void Function();

abstract class Transport {
  void send(Map<String, dynamic> message);
  void close();
  set onMessage(MessageCallback callback);
  set onClose(CloseCallback callback);
}

class StdioTransport implements Transport {
  final Process _process;
  MessageCallback? _onMessage;
  CloseCallback? _onClose;

  final _buffer = <int>[];
  int? _expectedLength;

  StdioTransport(this._process) {
    _process.stdout.listen(
      (data) {
        _buffer.addAll(data);
        _processBuffer();
      },
      onDone: () {
        _onClose?.call();
      },
    );

    _process.stderr.listen((data) {
      // Typically log to console or handle
      print('[Driver STDERR] ${utf8.decode(data)}');
    });
  }

  void _processBuffer() {
    while (true) {
      if (_expectedLength == null) {
        if (_buffer.length < 4) {
          return;
        } // Need more data for length prefix

        final lengthBytes = Uint8List.fromList(_buffer.take(4).toList());
        final byteData = ByteData.sublistView(lengthBytes);
        _expectedLength = byteData.getUint32(0, Endian.little);
        _buffer.removeRange(0, 4);
      }

      if (_buffer.length < _expectedLength!) {
        return; // Need more data for message
      }

      final messageBytes = _buffer.take(_expectedLength!).toList();
      _buffer.removeRange(0, _expectedLength!);
      _expectedLength = null;

      final messageStr = utf8.decode(messageBytes);
      if (messageStr.contains('dialog')) {
        print('RCV: $messageStr');
      }
      final message = jsonDecode(messageStr) as Map<String, dynamic>;
      _onMessage?.call(message);
    }
  }

  @override
  void send(Map<String, dynamic> message) {
    final messageStr = jsonEncode(message, toEncodable: (dynamic item) {
      if (item == null) return null;
      try {
        if (item is Enum) return (item as dynamic).value;
        return item.toJson();
      } catch (_) {
        return item.toString();
      }
    });
    final messageBytes = utf8.encode(messageStr);

    final lengthBytes = ByteData(4);
    lengthBytes.setUint32(0, messageBytes.length, Endian.little);

    _process.stdin.add(lengthBytes.buffer.asUint8List());
    _process.stdin.add(messageBytes);
  }

  @override
  void close() {
    _process.kill();
  }

  @override
  set onMessage(MessageCallback callback) => _onMessage = callback;

  @override
  set onClose(CloseCallback callback) => _onClose = callback;
}
