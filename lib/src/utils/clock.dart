import '../core/browser_context.dart';

/// Clock API for mocking time in browser contexts.
abstract interface class Clock {
  Future<void> install({double? timeNumber, String? timeString});
  Future<void> fastForward({double? ticksNumber, String? ticksString});
  Future<void> pauseAt({double? timeNumber, String? timeString});
  Future<void> resume();
  Future<void> runFor({double? ticksNumber, String? ticksString});
  Future<void> setFixedTime({double? timeNumber, String? timeString});
  Future<void> setSystemTime({double? timeNumber, String? timeString});
}

class ClockImpl implements Clock {
  final BrowserContext _context;

  ClockImpl(this._context);

  @override
  Future<void> install({double? timeNumber, String? timeString}) =>
      _context.clockInstall(timeNumber: timeNumber, timeString: timeString);

  @override
  Future<void> fastForward({double? ticksNumber, String? ticksString}) =>
      _context.clockFastForward(
        ticksNumber: ticksNumber,
        ticksString: ticksString,
      );

  @override
  Future<void> pauseAt({double? timeNumber, String? timeString}) =>
      _context.clockPauseAt(timeNumber: timeNumber, timeString: timeString);

  @override
  Future<void> resume() => _context.clockResume();

  @override
  Future<void> runFor({double? ticksNumber, String? ticksString}) =>
      _context.clockRunFor(ticksNumber: ticksNumber, ticksString: ticksString);

  @override
  Future<void> setFixedTime({double? timeNumber, String? timeString}) =>
      _context.clockSetFixedTime(
        timeNumber: timeNumber,
        timeString: timeString,
      );

  @override
  Future<void> setSystemTime({double? timeNumber, String? timeString}) =>
      _context.clockSetSystemTime(
        timeNumber: timeNumber,
        timeString: timeString,
      );
}
