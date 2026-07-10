import 'package:test/test.dart';
import 'package:playwright_dart/src/utils/tracing.dart';
import 'package:playwright_dart/src/generated/channels.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('TracingImpl Unit Tests', () {
    late TestConnection testConn;

    TestConnection makeConn() => TestConnection(
      handler: (req) {
        switch (req['method']) {
          case 'tracingStart':
          case 'tracingGroupEnd':
          case 'tracingStop':
          case 'tracingGroup':
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{},
            };

          case 'tracingStartChunk':
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{'traceName': 'chunk-trace'},
            };

          case 'tracingStopChunk':
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{},
            };

          case 'harExport':
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{},
            };

          case 'harStart':
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{'harId': 'har_001'},
            };

          default:
            return <String, dynamic>{
              'id': req['id'],
              'result': <String, dynamic>{},
            };
        }
      },
    );

    setUp(() {
      testConn = makeConn();
      testConn.dispatchCreate('Tracing', 'Tracing_1', {});
    });

    // ── start ─────────────────────────────────────────────────────────────

    test('start sends tracingStart with all options', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.start(
        name: 'my-trace',
        snapshots: true,
        screenshots: true,
        live: false,
      );

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingStart',
      );
      expect(msg['params']['name'], equals('my-trace'));
      expect(msg['params']['snapshots'], isTrue);
      expect(msg['params']['screenshots'], isTrue);
      expect(msg['params']['live'], isFalse);
    });

    test('start sends tracingStart with no options', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.start();

      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'tracingStart',
        ),
        isTrue,
      );
    });

    test('tracingStart alias delegates to start', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.tracingStart(name: 'alias-trace', snapshots: false);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingStart',
      );
      expect(msg['params']['name'], equals('alias-trace'));
    });

    // ── startChunk ────────────────────────────────────────────────────────

    test('startChunk sends tracingStartChunk with name and title', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.startChunk(name: 'chunk-1', title: 'My chunk');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingStartChunk',
      );
      expect(msg['params']['name'], equals('chunk-1'));
      expect(msg['params']['title'], equals('My chunk'));
    });

    test('startChunk returns TracingTracingStartChunkResult', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      final result = await tracing.startChunk();
      expect(result, isA<TracingTracingStartChunkResult>());
      expect(result.traceName, equals('chunk-trace'));
    });

    test('tracingStartChunk alias works', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.tracingStartChunk(title: 'aliased');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingStartChunk',
      );
      expect(msg['params']['title'], equals('aliased'));
    });

    // ── group / groupEnd ──────────────────────────────────────────────────

    test('group sends tracingGroup with name', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.group('Login flow');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingGroup',
      );
      expect(msg['params']['name'], equals('Login flow'));
    });

    test('group sends tracingGroup with location', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.group(
        'Step',
        location: TracingTracingGroupLocation(file: 'test.dart', line: 10),
      );

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingGroup',
      );
      expect(msg['params']['location'], isNotNull);
    });

    test('tracingGroup alias works', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.tracingGroup('Alias group');

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingGroup',
      );
      expect(msg['params']['name'], equals('Alias group'));
    });

    test('groupEnd sends tracingGroupEnd', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.groupEnd();

      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'tracingGroupEnd',
        ),
        isTrue,
      );
    });

    test('tracingGroupEnd alias works', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.tracingGroupEnd();

      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'tracingGroupEnd',
        ),
        isTrue,
      );
    });

    // ── stopChunk ─────────────────────────────────────────────────────────

    test('stopChunk sends tracingStopChunk with mode', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.stopChunk(mode: TracingTracingStopChunkModeEnum.discard);

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingStopChunk',
      );
      expect(msg['params']['mode'], equals('discard'));
    });

    test('stopChunk defaults to discard mode', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.stopChunk();

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'tracingStopChunk',
      );
      expect(msg['params']['mode'], equals('discard'));
    });

    test('stopChunk returns TracingTracingStopChunkResult', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      final result = await tracing.stopChunk();
      expect(result, isA<TracingTracingStopChunkResult>());
    });

    test('tracingStopChunk alias works', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.tracingStopChunk();

      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'tracingStopChunk',
        ),
        isTrue,
      );
    });

    // ── stop ─────────────────────────────────────────────────────────────

    test('stop sends tracingStop', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.stop();

      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'tracingStop',
        ),
        isTrue,
      );
    });

    test('tracingStop alias delegates to stop', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.tracingStop();

      expect(
        testConn.transport.sentMessages.any(
          (m) => m['method'] == 'tracingStop',
        ),
        isTrue,
      );
    });

    // ── harExport ─────────────────────────────────────────────────────────

    test('harExport sends harExport message', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.harExport(
        harId: 'har_001',
        mode: TracingHarExportModeEnum.archive,
      );

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'harExport',
      );
      expect(msg['params']['harId'], equals('har_001'));
      expect(msg['params']['mode'], equals('archive'));
    });

    test('harExport defaults to archive mode', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.harExport();

      final msg = testConn.transport.sentMessages.lastWhere(
        (m) => m['method'] == 'harExport',
      );
      expect(msg['params']['mode'], equals('archive'));
    });

    // ── harStart ──────────────────────────────────────────────────────────

    test('harStart sends harStart message', () async {
      final tracing = testConn.getObject('Tracing_1') as TracingImpl;
      await tracing.harStart();

      expect(
        testConn.transport.sentMessages.any((m) => m['method'] == 'harStart'),
        isTrue,
      );
    });

    test(
      'harStart sends default RecordHarOptions when none provided',
      () async {
        final tracing = testConn.getObject('Tracing_1') as TracingImpl;
        await tracing.harStart();

        final msg = testConn.transport.sentMessages.lastWhere(
          (m) => m['method'] == 'harStart',
        );
        expect(msg['params']['options'], isNotNull);
      },
    );

    // ── typical lifecycle ─────────────────────────────────────────────────

    test(
      'full tracing lifecycle: start → startChunk → group → groupEnd → stopChunk → stop',
      () async {
        final tracing = testConn.getObject('Tracing_1') as TracingImpl;

        await tracing.start(screenshots: true, snapshots: true);
        await tracing.startChunk(title: 'chunk-a');
        await tracing.group('my group');
        await tracing.groupEnd();
        await tracing.stopChunk();
        await tracing.stop();

        final methods = testConn.transport.sentMessages
            .map((m) => m['method'])
            .toList();
        expect(
          methods,
          containsAllInOrder([
            'tracingStart',
            'tracingStartChunk',
            'tracingGroup',
            'tracingGroupEnd',
            'tracingStopChunk',
            'tracingStop',
          ]),
        );
      },
    );
  });
}
