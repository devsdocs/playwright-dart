import 'dart:convert';
import 'package:test/test.dart';
import 'package:playwright_dart/src/utils/artifact.dart';
import 'package:playwright_dart/src/infrastructure/stream.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('ArtifactImpl Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) {
          switch (req['method']) {
            case 'pathAfterFinished':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{'value': '/tmp/trace.zip'},
              };
            case 'failure':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{'error': 'download failed'},
              };
            case 'saveAs':
            case 'delete':
            case 'cancel':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{},
              };
            default:
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{},
              };
          }
        },
      );

      testConn.dispatchCreate('Artifact', 'Artifact_1', {
        'absolutePath': '/tmp/trace.zip',
      });
    });

    test('ArtifactImpl is created', () {
      expect(testConn.getObject('Artifact_1'), isA<ArtifactImpl>());
    });

    test('implements Artifact interface', () {
      expect(testConn.getObject('Artifact_1'), isA<Artifact>());
    });

    test('pathAfterFinished sends message and returns path', () async {
      final artifact = testConn.getObject('Artifact_1') as ArtifactImpl;
      final path = await artifact.pathAfterFinished();

      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'pathAfterFinished',
        ),
        isTrue,
      );
      expect(path, equals('/tmp/trace.zip'));
    });

    test('saveAs sends saveAs message with path', () async {
      final artifact = testConn.getObject('Artifact_1') as ArtifactImpl;
      await artifact.saveAs('/output/trace.zip');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'saveAs',
      );
      expect(msg['params']['path'], equals('/output/trace.zip'));
    });

    test('delete sends delete message', () async {
      final artifact = testConn.getObject('Artifact_1') as ArtifactImpl;
      await artifact.delete();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'delete'),
        isTrue,
      );
    });

    test(
      'failureError returns error string from failure channel call',
      () async {
        final artifact = testConn.getObject('Artifact_1') as ArtifactImpl;
        final error = await artifact.failureError();
        expect(error, equals('download failed'));
      },
    );

    test('failure alias delegates to failureError', () async {
      final artifact = testConn.getObject('Artifact_1') as ArtifactImpl;
      final error = await artifact.failure();
      expect(error, equals('download failed'));
    });

    test('cancel sends cancel message', () async {
      final artifact = testConn.getObject('Artifact_1') as ArtifactImpl;
      await artifact.cancel();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'cancel'),
        isTrue,
      );
    });
  });

  group('PlaywrightStreamImpl Unit Tests', () {
    late TestConnection testConn;

    setUp(() {
      testConn = TestConnection(
        handler: (req) {
          switch (req['method']) {
            case 'read':
              // Return base64-encoded "hello world"
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{
                  'binary': base64Encode('hello world'.codeUnits),
                },
              };
            case 'close':
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{},
              };
            default:
              return <String, dynamic>{
                'id': req['id'],
                'result': <String, dynamic>{},
              };
          }
        },
      );

      testConn.dispatchCreate('Stream', 'Stream_1', {});
    });

    test('PlaywrightStreamImpl is created', () {
      expect(testConn.getObject('Stream_1'), isA<PlaywrightStreamImpl>());
    });

    test('implements PlaywrightStream interface', () {
      expect(testConn.getObject('Stream_1'), isA<PlaywrightStream>());
    });

    test('read sends read message and decodes base64 bytes', () async {
      final stream = testConn.getObject('Stream_1') as PlaywrightStreamImpl;
      final bytes = await stream.read();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'read'),
        isTrue,
      );
      expect(String.fromCharCodes(bytes), equals('hello world'));
    });

    test('read sends size parameter when provided', () async {
      final stream = testConn.getObject('Stream_1') as PlaywrightStreamImpl;
      await stream.read(size: 1024);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'read',
      );
      expect(msg['params']['size'], equals(1024));
    });

    test('read with no size sends no size param', () async {
      final stream = testConn.getObject('Stream_1') as PlaywrightStreamImpl;
      await stream.read();

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'read',
      );
      expect(msg['params'].containsKey('size'), isFalse);
    });

    test('close sends close message', () async {
      final stream = testConn.getObject('Stream_1') as PlaywrightStreamImpl;
      await stream.close();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'close'),
        isTrue,
      );
    });
  });
}
