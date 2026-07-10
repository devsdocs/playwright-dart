import 'package:test/test.dart';
import 'package:playwright_dart/src/utils/clock.dart';
import 'package:playwright_dart/src/core/browser_context.dart';

void main() {
  group('ClockImpl Unit Tests', () {
    late _MockBrowserContext mockCtx;
    late ClockImpl clock;

    setUp(() {
      mockCtx = _MockBrowserContext();
      clock = ClockImpl(mockCtx);
    });

    test('install delegates to context.clockInstall with timeNumber', () async {
      await clock.install(timeNumber: 1000.0);
      expect(mockCtx.lastCall, equals('clockInstall'));
      expect(mockCtx.lastArgs['timeNumber'], equals(1000.0));
      expect(mockCtx.lastArgs['timeString'], isNull);
    });

    test('install delegates to context.clockInstall with timeString', () async {
      await clock.install(timeString: '2024-01-01');
      expect(mockCtx.lastCall, equals('clockInstall'));
      expect(mockCtx.lastArgs['timeString'], equals('2024-01-01'));
      expect(mockCtx.lastArgs['timeNumber'], isNull);
    });

    test('install with no args passes nulls', () async {
      await clock.install();
      expect(mockCtx.lastCall, equals('clockInstall'));
      expect(mockCtx.lastArgs['timeNumber'], isNull);
      expect(mockCtx.lastArgs['timeString'], isNull);
    });

    test('fastForward delegates with ticksNumber', () async {
      await clock.fastForward(ticksNumber: 5000.0);
      expect(mockCtx.lastCall, equals('clockFastForward'));
      expect(mockCtx.lastArgs['ticksNumber'], equals(5000.0));
    });

    test('fastForward delegates with ticksString', () async {
      await clock.fastForward(ticksString: '01:00');
      expect(mockCtx.lastCall, equals('clockFastForward'));
      expect(mockCtx.lastArgs['ticksString'], equals('01:00'));
    });

    test('pauseAt delegates with timeNumber', () async {
      await clock.pauseAt(timeNumber: 9999.0);
      expect(mockCtx.lastCall, equals('clockPauseAt'));
      expect(mockCtx.lastArgs['timeNumber'], equals(9999.0));
    });

    test('pauseAt delegates with timeString', () async {
      await clock.pauseAt(timeString: '2024-12-25');
      expect(mockCtx.lastCall, equals('clockPauseAt'));
      expect(mockCtx.lastArgs['timeString'], equals('2024-12-25'));
    });

    test('resume delegates to context.clockResume', () async {
      await clock.resume();
      expect(mockCtx.lastCall, equals('clockResume'));
    });

    test('runFor delegates with ticksNumber', () async {
      await clock.runFor(ticksNumber: 2000.0);
      expect(mockCtx.lastCall, equals('clockRunFor'));
      expect(mockCtx.lastArgs['ticksNumber'], equals(2000.0));
    });

    test('runFor delegates with ticksString', () async {
      await clock.runFor(ticksString: '30:00');
      expect(mockCtx.lastCall, equals('clockRunFor'));
      expect(mockCtx.lastArgs['ticksString'], equals('30:00'));
    });

    test('setFixedTime delegates with timeNumber', () async {
      await clock.setFixedTime(timeNumber: 0.0);
      expect(mockCtx.lastCall, equals('clockSetFixedTime'));
      expect(mockCtx.lastArgs['timeNumber'], equals(0.0));
    });

    test('setFixedTime delegates with timeString', () async {
      await clock.setFixedTime(timeString: '2020-02-02');
      expect(mockCtx.lastCall, equals('clockSetFixedTime'));
      expect(mockCtx.lastArgs['timeString'], equals('2020-02-02'));
    });

    test('setSystemTime delegates with timeNumber', () async {
      await clock.setSystemTime(timeNumber: 1234567890.0);
      expect(mockCtx.lastCall, equals('clockSetSystemTime'));
      expect(mockCtx.lastArgs['timeNumber'], equals(1234567890.0));
    });

    test('setSystemTime delegates with timeString', () async {
      await clock.setSystemTime(timeString: '2030-06-15');
      expect(mockCtx.lastCall, equals('clockSetSystemTime'));
      expect(mockCtx.lastArgs['timeString'], equals('2030-06-15'));
    });

    test('each call updates lastCall independently', () async {
      await clock.resume();
      expect(mockCtx.lastCall, equals('clockResume'));
      await clock.install();
      expect(mockCtx.lastCall, equals('clockInstall'));
    });
  });
}

// ── Minimal mock ─────────────────────────────────────────────────────────────

class _MockBrowserContext implements BrowserContext {
  String lastCall = '';
  Map<String, dynamic> lastArgs = {};

  @override
  Future<void> clockFastForward({
    double? ticksNumber,
    String? ticksString,
  }) async {
    lastCall = 'clockFastForward';
    lastArgs = {'ticksNumber': ticksNumber, 'ticksString': ticksString};
  }

  @override
  Future<void> clockInstall({double? timeNumber, String? timeString}) async {
    lastCall = 'clockInstall';
    lastArgs = {'timeNumber': timeNumber, 'timeString': timeString};
  }

  @override
  Future<void> clockPauseAt({double? timeNumber, String? timeString}) async {
    lastCall = 'clockPauseAt';
    lastArgs = {'timeNumber': timeNumber, 'timeString': timeString};
  }

  @override
  Future<void> clockResume() async {
    lastCall = 'clockResume';
    lastArgs = {};
  }

  @override
  Future<void> clockRunFor({double? ticksNumber, String? ticksString}) async {
    lastCall = 'clockRunFor';
    lastArgs = {'ticksNumber': ticksNumber, 'ticksString': ticksString};
  }

  @override
  Future<void> clockSetFixedTime({
    double? timeNumber,
    String? timeString,
  }) async {
    lastCall = 'clockSetFixedTime';
    lastArgs = {'timeNumber': timeNumber, 'timeString': timeString};
  }

  @override
  Future<void> clockSetSystemTime({
    double? timeNumber,
    String? timeString,
  }) async {
    lastCall = 'clockSetSystemTime';
    lastArgs = {'timeNumber': timeNumber, 'timeString': timeString};
  }

  // All other members are unused by ClockImpl — noSuchMethod handles them.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
