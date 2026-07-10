import 'package:playwright_dart/src/utils/logger.dart';
import 'package:test/test.dart';

void main() {
  group('Logger', () {
    late List<Map<String, dynamic>> logs;
    late LogLevel originalLevel;

    setUp(() {
      logs = [];
      originalLevel = Logger.level;
      Logger.sink = (message, {required channel, error, stackTrace}) {
        logs.add({
          'message': message,
          'channel': channel,
          'error': error,
          'stackTrace': stackTrace,
        });
      };
    });

    tearDown(() {
      Logger.sink = null;
      Logger.level = originalLevel;
    });

    test('trace emits when level is trace', () {
      Logger.level = LogLevel.trace;
      Logger.trace('test trace', name: 'mytrace');
      expect(logs.length, 1);
      expect(logs[0]['message'], 'test trace');
      expect(logs[0]['channel'], 'playwright.trace/mytrace');
    });

    test('trace does not emit when level is above trace', () {
      Logger.level = LogLevel.debug;
      Logger.trace('test trace');
      expect(logs, isEmpty);
    });

    test('debug emits when level is debug or trace', () {
      Logger.level = LogLevel.debug;
      Logger.debug('test debug', name: 'mydebug');
      expect(logs.length, 1);
      expect(logs[0]['message'], 'test debug');
      expect(logs[0]['channel'], 'playwright.debug/mydebug');
    });

    test('debug does not emit when level is above debug', () {
      Logger.level = LogLevel.info;
      Logger.debug('test debug');
      expect(logs, isEmpty);
    });

    test('info emits when level is info or below', () {
      Logger.level = LogLevel.info;
      Logger.info('test info');
      expect(logs.length, 1);
      expect(logs[0]['message'], 'test info');
      expect(logs[0]['channel'], 'playwright.info');
    });

    test('info does not emit when level is above info', () {
      Logger.level = LogLevel.warn;
      Logger.info('test info');
      expect(logs, isEmpty);
    });

    test('warn emits when level is warn or below', () {
      Logger.level = LogLevel.warn;
      Logger.warn('test warn');
      expect(logs.length, 1);
      expect(logs[0]['message'], 'test warn');
      expect(logs[0]['channel'], 'playwright.warn');
    });

    test('warn does not emit when level is above warn', () {
      Logger.level = LogLevel.error;
      Logger.warn('test warn');
      expect(logs, isEmpty);
    });

    test('error emits when level is error or below', () {
      Logger.level = LogLevel.error;
      final err = Exception('test error obj');
      final stack = StackTrace.empty;
      Logger.error('test error', err, stack);
      expect(logs.length, 1);
      expect(logs[0]['message'], 'test error');
      expect(logs[0]['channel'], 'playwright.error');
      expect(logs[0]['error'], err);
      expect(logs[0]['stackTrace'], stack);
    });

    test('error does not emit when level is none', () {
      Logger.level = LogLevel.none;
      Logger.error('test error');
      expect(logs, isEmpty);
    });
  });
}
