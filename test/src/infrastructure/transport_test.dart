import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:playwright_dart/src/infrastructure/transport.dart';
import 'package:test/test.dart';

class TransportMockProcess implements Process {
  final StreamController<List<int>> stdoutController =
      StreamController<List<int>>();
  final StreamController<List<int>> stderrController =
      StreamController<List<int>>();
  final IOSink stdinSink;

  TransportMockProcess(this.stdinSink);

  @override
  int get pid => 1;

  @override
  Future<int> get exitCode => Future.value(0);

  @override
  Stream<List<int>> get stdout => stdoutController.stream;

  @override
  Stream<List<int>> get stderr => stderrController.stream;

  @override
  IOSink get stdin => stdinSink;

  @override
  bool kill([ProcessSignal signal = ProcessSignal.sigterm]) => true;
}

class MockIOSink implements IOSink {
  final List<List<int>> writes = [];

  @override
  void add(List<int> data) {
    writes.add(data);
  }

  @override
  void write(Object? object) {}

  @override
  void writeAll(Iterable objects, [String separator = ""]) {}

  @override
  void writeCharCode(int charCode) {}

  @override
  void writeln([Object? object = ""]) {}

  @override
  Encoding get encoding => utf8;

  @override
  set encoding(Encoding encoding) {}

  @override
  void addError(Object error, [StackTrace? stackTrace]) {}

  @override
  Future addStream(Stream<List<int>> stream) async {}

  @override
  Future close() async {}

  @override
  Future get done => Future.value();

  @override
  Future flush() async {}
}

void main() {
  group('StdioTransport', () {
    late MockIOSink mockStdin;
    late TransportMockProcess mockProcess;
    late StdioTransport transport;

    setUp(() {
      mockStdin = MockIOSink();
      mockProcess = TransportMockProcess(mockStdin);
      transport = StdioTransport(mockProcess);
    });

    test('send() prefixes message with 4-byte little-endian length', () {
      final msg = {'id': 1, 'method': 'test'};
      transport.send(msg);

      expect(mockStdin.writes.length, 2);

      final lengthBytes = mockStdin.writes[0];
      expect(lengthBytes.length, 4);

      final messageBytes = mockStdin.writes[1];
      final messageStr = utf8.decode(messageBytes);
      expect(jsonDecode(messageStr), msg);

      final byteData = ByteData.sublistView(Uint8List.fromList(lengthBytes));
      expect(byteData.getUint32(0, Endian.little), messageBytes.length);
    });

    test('onMessage receives parsed json objects from stdout', () async {
      final messages = <Map<String, dynamic>>[];
      transport.onMessage = (msg) {
        messages.add(msg);
      };

      final msg1 = {'id': 1, 'result': 'ok'};
      final msg1Str = jsonEncode(msg1);
      final msg1Bytes = utf8.encode(msg1Str);

      final lengthBytes = ByteData(4);
      lengthBytes.setUint32(0, msg1Bytes.length, Endian.little);

      // Send length and payload
      mockProcess.stdoutController.add(lengthBytes.buffer.asUint8List());
      mockProcess.stdoutController.add(msg1Bytes);

      // Allow stream to process
      await Future.delayed(Duration.zero);

      expect(messages.length, 1);
      expect(messages[0], msg1);
    });

    test('onMessage handles fragmented payloads', () async {
      final messages = <Map<String, dynamic>>[];
      transport.onMessage = (msg) {
        messages.add(msg);
      };

      final msg = {'id': 2, 'result': 'fragmented'};
      final msgStr = jsonEncode(msg);
      final msgBytes = utf8.encode(msgStr);

      final lengthBytes = ByteData(4);
      lengthBytes.setUint32(0, msgBytes.length, Endian.little);
      final lengthList = lengthBytes.buffer.asUint8List();

      // Send 2 bytes of length
      mockProcess.stdoutController.add(lengthList.sublist(0, 2));
      await Future.delayed(Duration.zero);
      expect(messages, isEmpty);

      // Send rest of length and half of payload
      mockProcess.stdoutController.add(lengthList.sublist(2, 4));
      mockProcess.stdoutController.add(msgBytes.sublist(0, 5));
      await Future.delayed(Duration.zero);
      expect(messages, isEmpty);

      // Send rest of payload
      mockProcess.stdoutController.add(msgBytes.sublist(5));
      await Future.delayed(Duration.zero);
      expect(messages.length, 1);
      expect(messages[0], msg);
    });
  });
}
