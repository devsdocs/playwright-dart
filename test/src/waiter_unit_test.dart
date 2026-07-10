import 'package:test/test.dart';
import 'package:playwright_dart/src/infrastructure/waiter.dart';
import 'package:playwright_dart/src/infrastructure/playwright_errors.dart';
import 'infrastructure/mock_transport.dart';

void main() {
  group('Waiter Unit Tests', () {
    late TestConnection testConnection;
    late dynamic dummyOwner;

    setUp(() {
      testConnection = TestConnection(
        handler: (req) => <String, dynamic>{'id': req['id'], 'result': {}},
      );
      testConnection.dispatchCreate('Frame', 'Frame_1', {
        'url': 'about:blank',
        'name': '',
        'loadStates': [],
      });
      testConnection.dispatchCreate('Page', 'Page_1', {
        'isClosed': false,
        'mainFrame': {'guid': 'Frame_1'},
      });
      dummyOwner = testConnection.getObject('Page_1');
    });

    test('waitForEvent completes successfully', () async {
      final waiter = Waiter<Map<String, dynamic>>(dummyOwner, 'some_event');
      final future = waiter.waitForEvent(dummyOwner, 'my_event');

      testConnection.dispatchEvent('Page_1', 'my_event', {'foo': 'bar'});

      final result = await future;
      expect(result['foo'], 'bar');
    });

    test('waitForEvent with predicate', () async {
      final waiter = Waiter<Map<String, dynamic>>(dummyOwner, 'some_event');
      final future = waiter.waitForEvent(
        dummyOwner,
        'my_event',
        (params) => params['id'] == 2,
      );

      testConnection.dispatchEvent('Page_1', 'my_event', {
        'id': 1,
      }); // should be ignored
      testConnection.dispatchEvent('Page_1', 'my_event', {
        'id': 2,
        'foo': 'bar',
      }); // should be matched

      final result = await future;
      expect(result['id'], 2);
      expect(result['foo'], 'bar');
    });

    test('rejectOnTimeout throws TimeoutError', () async {
      final waiter = Waiter<void>(dummyOwner, 'some_event');
      waiter.rejectOnTimeout(50, 'Custom timeout');

      final future = waiter.waitForEvent(dummyOwner, 'never_happens');

      await expectLater(
        () => future,
        throwsA(
          isA<TimeoutError>().having(
            (e) => e.message,
            'message',
            'Custom timeout',
          ),
        ),
      );
    });

    test('rejectOnEvent throws specified error', () async {
      final waiter = Waiter<void>(dummyOwner, 'some_event');
      waiter.rejectOnEvent(
        dummyOwner,
        'close',
        TargetClosedError('Page closed'),
      );

      final future = waiter.waitForEvent(dummyOwner, 'never_happens');

      testConnection.dispatchEvent('Page_1', 'close', {});

      await expectLater(
        () => future,
        throwsA(
          isA<TargetClosedError>().having(
            (e) => e.message,
            'message',
            'Page closed',
          ),
        ),
      );
    });

    test('rejectOnEvent with predicate', () async {
      final waiter = Waiter<void>(dummyOwner, 'some_event');
      waiter.rejectOnEvent(
        dummyOwner,
        'error',
        PlaywrightError('Specific error'),
        (params) => params['fatal'] == true,
      );

      final future = waiter.waitForEvent(dummyOwner, 'never_happens');

      testConnection.dispatchEvent('Page_1', 'error', {
        'fatal': false,
      }); // should be ignored
      testConnection.dispatchEvent('Page_1', 'error', {
        'fatal': true,
      }); // should trigger reject

      await expectLater(
        () => future,
        throwsA(
          isA<PlaywrightError>().having(
            (e) => e.message,
            'message',
            'Specific error',
          ),
        ),
      );
    });

    test('rejectImmediately throws immediately', () async {
      final waiter = Waiter<void>(dummyOwner, 'some_event');
      waiter.rejectImmediately(PlaywrightError('Immediate!'));

      final future = waiter.waitForEvent(dummyOwner, 'never_happens');

      await expectLater(
        () => future,
        throwsA(
          isA<PlaywrightError>().having(
            (e) => e.message,
            'message',
            'Immediate!',
          ),
        ),
      );
    });
  });
}
