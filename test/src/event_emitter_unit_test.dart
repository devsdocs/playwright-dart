import 'package:test/test.dart';
import 'package:playwright_dart/src/infrastructure/event_emitter.dart';

void main() {
  group('EventEmitter Unit Tests', () {
    test('on, emit, off', () {
      final emitter = EventEmitter();
      int count = 0;
      void handler(dynamic data) {
        count += data as int;
      }

      emitter.on('test_event', handler);

      expect(emitter.listenerCount('test_event'), 1);
      expect(emitter.eventNames(), ['test_event']);

      final result = emitter.emit('test_event', 5);
      expect(result, isTrue);
      expect(count, 5);

      emitter.emit('test_event', 10);
      expect(count, 15);

      emitter.off('test_event', handler);
      expect(emitter.listenerCount('test_event'), 0);
      expect(emitter.eventNames(), isEmpty);

      final result2 = emitter.emit('test_event', 10);
      expect(result2, isFalse);
      expect(count, 15);
    });

    test('addListener, removeListener aliases', () {
      final emitter = EventEmitter();
      int count = 0;
      void handler(dynamic data) {
        count++;
      }

      emitter.addListener('alias_event', handler);
      emitter.emit('alias_event');
      expect(count, 1);

      emitter.removeListener('alias_event', handler);
      emitter.emit('alias_event');
      expect(count, 1);
    });

    test('once', () {
      final emitter = EventEmitter();
      int count = 0;
      void handler(dynamic data) {
        count++;
      }

      emitter.once('once_event', handler);
      expect(emitter.listenerCount('once_event'), 1);

      emitter.emit('once_event');
      expect(count, 1);
      expect(emitter.listenerCount('once_event'), 0);

      // Second emit should do nothing
      emitter.emit('once_event');
      expect(count, 1);
    });

    test('once with off before emit', () {
      final emitter = EventEmitter();
      int count = 0;
      void handler(dynamic data) {
        count++;
      }

      emitter.once('once_event', handler);
      expect(emitter.listenerCount('once_event'), 1);

      // off must be able to remove it using the original handler
      emitter.off('once_event', handler);
      expect(emitter.listenerCount('once_event'), 0);

      emitter.emit('once_event');
      expect(count, 0);
    });

    test('removeAllListeners', () {
      final emitter = EventEmitter();
      emitter.on('event1', (_) {});
      emitter.on('event1', (_) {});
      emitter.on('event2', (_) {});

      expect(emitter.listenerCount('event1'), 2);
      expect(emitter.listenerCount('event2'), 1);

      emitter.removeAllListeners('event1');
      expect(emitter.listenerCount('event1'), 0);
      expect(emitter.listenerCount('event2'), 1);

      emitter.removeAllListeners();
      expect(emitter.listenerCount('event2'), 0);
      expect(emitter.eventNames(), isEmpty);
    });

    test('stream conversion', () async {
      final emitter = EventEmitter();
      final stream = emitter.stream('stream_event');

      final future1 = stream.first;
      final future2 = stream.skip(1).first;

      emitter.emit('stream_event', 'hello');
      emitter.emit('stream_event', 'world');

      expect(await future1, 'hello');
      expect(await future2, 'world');

      expect(emitter.listenerCount('stream_event'), 0); // controller canceled
    });
  });
}
