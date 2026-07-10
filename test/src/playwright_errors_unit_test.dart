import 'package:test/test.dart';
import 'package:playwright_dart/src/infrastructure/playwright_errors.dart';

void main() {
  group('PlaywrightError', () {
    test('stores message', () {
      const e = PlaywrightError('something went wrong');
      expect(e.message, equals('something went wrong'));
    });

    test('log defaults to empty list', () {
      const e = PlaywrightError('msg');
      expect(e.log, isEmpty);
    });

    test('stores log lines when provided', () {
      const e = PlaywrightError('msg', log: ['line1', 'line2']);
      expect(e.log, equals(['line1', 'line2']));
    });

    test('toString with no log', () {
      const e = PlaywrightError('bad thing');
      expect(e.toString(), equals('PlaywrightError: bad thing'));
    });

    test('toString includes formatted log section when log is non-empty', () {
      const e = PlaywrightError('bad thing', log: ['step 1', 'step 2']);
      final str = e.toString();
      expect(str, startsWith('PlaywrightError: bad thing'));
      expect(str, contains('step 1'));
      expect(str, contains('step 2'));
      // log section is separated by a blank line
      expect(str, contains('\n\n'));
    });

    test('is an Exception', () {
      const e = PlaywrightError('msg');
      expect(e, isA<Exception>());
    });
  });

  group('TimeoutError', () {
    test('stores message', () {
      const e = TimeoutError('timed out after 30s');
      expect(e.message, equals('timed out after 30s'));
    });

    test('is a PlaywrightError', () {
      const e = TimeoutError('timeout');
      expect(e, isA<PlaywrightError>());
    });

    test('toString returns TimeoutError prefix', () {
      const e = TimeoutError('wait exceeded');
      expect(e.toString(), equals('TimeoutError: wait exceeded'));
    });

    test('supports log lines', () {
      const e = TimeoutError('timeout', log: ['waiting for selector']);
      expect(e.log, equals(['waiting for selector']));
    });
  });

  group('TargetClosedError', () {
    test('default message when no cause given', () {
      const e = TargetClosedError();
      expect(
        e.message,
        equals('Target page, context or browser has been closed'),
      );
    });

    test('uses provided cause as message', () {
      const e = TargetClosedError('page was closed by the test');
      expect(e.message, equals('page was closed by the test'));
    });

    test('is a PlaywrightError', () {
      const e = TargetClosedError();
      expect(e, isA<PlaywrightError>());
    });

    test('toString returns TargetClosedError prefix', () {
      const e = TargetClosedError('closed');
      expect(e.toString(), equals('TargetClosedError: closed'));
    });

    test('toString with default message', () {
      const e = TargetClosedError();
      expect(e.toString(), startsWith('TargetClosedError: Target page'));
    });
  });

  group('isTargetClosedError', () {
    test('returns true for TargetClosedError', () {
      expect(isTargetClosedError(const TargetClosedError()), isTrue);
    });

    test('returns false for PlaywrightError', () {
      expect(isTargetClosedError(const PlaywrightError('x')), isFalse);
    });

    test('returns false for TimeoutError', () {
      expect(isTargetClosedError(const TimeoutError('t')), isFalse);
    });

    test('returns false for generic Exception', () {
      expect(isTargetClosedError(Exception('x')), isFalse);
    });

    test('returns false for String', () {
      expect(isTargetClosedError('some string'), isFalse);
    });
  });

  group('isTimeoutError', () {
    test('returns true for TimeoutError', () {
      expect(isTimeoutError(const TimeoutError('t')), isTrue);
    });

    test('returns false for PlaywrightError', () {
      expect(isTimeoutError(const PlaywrightError('x')), isFalse);
    });

    test('returns false for TargetClosedError', () {
      expect(isTimeoutError(const TargetClosedError()), isFalse);
    });

    test('returns false for generic Exception', () {
      expect(isTimeoutError(Exception('x')), isFalse);
    });
  });

  group('parseServerError', () {
    test('returns TimeoutError for message starting with TimeoutError:', () {
      final e = parseServerError('TimeoutError: Timeout 30000ms exceeded.');
      expect(e, isA<TimeoutError>());
      expect(e.message, contains('Timeout 30000ms'));
    });

    test('returns TimeoutError for message containing TimeoutError', () {
      final e = parseServerError('page.goto: TimeoutError occurred');
      expect(e, isA<TimeoutError>());
    });

    test('returns TargetClosedError for Target closed message', () {
      final e = parseServerError('Target closed');
      expect(e, isA<TargetClosedError>());
    });

    test('returns TargetClosedError for TargetClosedError keyword', () {
      final e = parseServerError('TargetClosedError: context was destroyed');
      expect(e, isA<TargetClosedError>());
    });

    test('returns TargetClosedError for Browser has been closed', () {
      final e = parseServerError('Browser has been closed');
      expect(e, isA<TargetClosedError>());
    });

    test('returns TargetClosedError for exact closed message', () {
      final e = parseServerError(
        'Target page, context or browser has been closed',
      );
      expect(e, isA<TargetClosedError>());
    });

    test('returns plain PlaywrightError for unknown messages', () {
      final e = parseServerError('Some unknown error');
      expect(e, isA<PlaywrightError>());
      expect(e, isNot(isA<TimeoutError>()));
      expect(e, isNot(isA<TargetClosedError>()));
    });

    test('preserves original message text in returned error', () {
      const msg = 'TimeoutError: waiting for element';
      final e = parseServerError(msg);
      expect(e.message, equals(msg));
    });

    test('empty string returns plain PlaywrightError', () {
      final e = parseServerError('');
      expect(e, isA<PlaywrightError>());
      expect(e, isNot(isA<TimeoutError>()));
    });
  });
}
